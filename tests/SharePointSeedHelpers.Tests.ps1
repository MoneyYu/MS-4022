$modulePath = Join-Path $PSScriptRoot "..\seed-data\engine\SharePointSeedHelpers.psm1"

Describe "SharePoint seed helpers" {
    BeforeAll {
        Import-Module $modulePath -Force
    }

    It "creates the Graph payload for a named document library" {
        $payload = New-DocumentLibraryPayload -LibraryName "Products"

        $payload.displayName | Should Be "Products"
        $payload.list.template | Should Be "documentLibrary"
    }

    It "uploads a named-library file through its drive" {
        $uri = Get-DocumentUploadUri -SiteId "site-123" -DriveId "drive-456" -Filename "Eagle Air Guide.pdf"

        $uri | Should Be "https://graph.microsoft.com/v1.0/drives/drive-456/root:/Eagle%20Air%20Guide.pdf:/content"
    }

    It "uses the default site drive when no library drive is supplied" {
        $uri = Get-DocumentUploadUri -SiteId "site-123" -Filename "Eagle Air Guide.pdf"

        $uri | Should Be "https://graph.microsoft.com/v1.0/sites/site-123/drive/root:/Eagle%20Air%20Guide.pdf:/content"
    }

    It "accepts only a private Unified group for an existing demo alias" {
        $expected = [pscustomobject]@{
            mailNickname = "ms4022-productsupport-20260819"
            groupTypes   = @("Unified")
            visibility   = "Private"
        }
        $unexpected = [pscustomobject]@{
            mailNickname = "ms4022-productsupport-20260819"
            groupTypes   = @()
            visibility   = "Public"
        }

        $validationCommand = Get-Command Assert-ExpectedDemoGroup -ErrorAction SilentlyContinue
        if (-not $validationCommand) {
            $validationCommand | Should Not BeNullOrEmpty
            return
        }

        { & $validationCommand -Group $expected -Alias "ms4022-productsupport-20260819" } | Should Not Throw
        $wasRejected = $false
        try {
            & $validationCommand -Group $unexpected -Alias "ms4022-productsupport-20260819"
        } catch {
            $wasRejected = $true
        }
        $wasRejected | Should Be $true
    }

    It "returns only desired directory object URIs missing from a group relationship" {
        $desiredUris = @(
            "https://graph.microsoft.com/v1.0/users/admin-id",
            "https://graph.microsoft.com/v1.0/users/demo-user-id"
        )
        $existingObjects = @([pscustomobject]@{ id = "admin-id" })

        $missingUris = Get-MissingDirectoryObjectUris -DesiredUris $desiredUris -ExistingDirectoryObjects $existingObjects

        ($missingUris -join ",") | Should Be "https://graph.microsoft.com/v1.0/users/demo-user-id"
    }

    It "deduplicates missing directory object URIs by directory object ID" {
        $desiredUris = @(
            "https://graph.microsoft.com/v1.0/users/admin-id",
            "https://graph.microsoft.com/v1.0/users/demo-user-id",
            "https://graph.microsoft.com/beta/users/demo-user-id"
        )
        $existingObjects = @([pscustomobject]@{ id = "admin-id" })

        $missingUris = Get-MissingDirectoryObjectUris -DesiredUris $desiredUris -ExistingDirectoryObjects $existingObjects

        ($missingUris -join ",") | Should Be "https://graph.microsoft.com/v1.0/users/demo-user-id"
    }

    It "collects all Graph relationship pages before reconciling group roles" {
        $pages = @{
            "https://graph.microsoft.com/page-1" = [pscustomobject]@{
                value           = @([pscustomobject]@{ id = "admin-id" })
                "@odata.nextLink" = "https://graph.microsoft.com/page-2"
            }
            "https://graph.microsoft.com/page-2" = [pscustomobject]@{
                value           = @([pscustomobject]@{ id = "demo-user-id" })
                "@odata.nextLink" = $null
            }
        }
        $getPage = { param($uri) $pages[$uri] }.GetNewClosure()

        $objects = Get-PagedGraphValues -InitialUri "https://graph.microsoft.com/page-1" -GetPage $getPage
        $engineText = Get-Content (Join-Path $PSScriptRoot "..\seed-data\engine\Invoke-SeedSharePoint.ps1") -Raw

        (@($objects.id) -join ",") | Should Be "admin-id,demo-user-id"
        $engineText | Should Match "Get-PagedGraphValues"
    }

    It "binds single owner and member URIs as JSON arrays" {
        $site = [pscustomobject]@{
            displayName = "MS-4022 - Product support - 20260819"
            description = "MS-4022 Product Support declarative agent knowledge source."
            alias       = "ms4022-productsupport-20260819"
        }

        $payload = New-GroupCreatePayload -Site $site -OwnerUris "https://graph.microsoft.com/v1.0/users/admin-id" -MemberUris "https://graph.microsoft.com/v1.0/users/demo-user-id"
        $json = $payload | ConvertTo-Json -Depth 20 -Compress

        $json | Should Match '"owners@odata.bind":\["https://graph.microsoft.com/v1.0/users/admin-id"\]'
        $json | Should Match '"members@odata.bind":\["https://graph.microsoft.com/v1.0/users/demo-user-id"\]'
    }

    It "invokes the relationship page callback in the caller scope" {
        function Get-StubRelationshipPage {
            param($uri)
            if ($uri -eq "page-1") {
                return [pscustomobject]@{ value = @([pscustomobject]@{ id = "admin-id" }); "@odata.nextLink" = "page-2" }
            }
            return [pscustomobject]@{ value = @([pscustomobject]@{ id = "demo-user-id" }); "@odata.nextLink" = $null }
        }

        $objects = Get-PagedGraphValues -InitialUri "page-1" -GetPage { param($uri) Get-StubRelationshipPage $uri }

        (@($objects.id) -join ",") | Should Be "admin-id,demo-user-id"
    }

    It "does not rebind the relationship page callback with GetNewClosure" {
        $engineText = Get-Content (Join-Path $PSScriptRoot "..\seed-data\engine\Invoke-SeedSharePoint.ps1") -Raw

        $engineText | Should Not Match "GetNewClosure"
    }

    It "avoids Graph SDK command-name collisions in the seeding engine" {
        $engineText = Get-Content (Join-Path $PSScriptRoot "..\seed-data\engine\Invoke-SeedSharePoint.ps1") -Raw

        $engineText | Should Not Match "Invoke-GraphRequest"
    }

    It "keeps the relationship segment when building the group relationship URI" {
        $ownersUri = Get-GroupRelationshipUri -GroupId "group-id" -Relationship "owners"
        $membersUri = Get-GroupRelationshipUri -GroupId "group-id" -Relationship "members"

        $ownersUri | Should Be 'https://graph.microsoft.com/v1.0/groups/group-id/owners?$select=id'
        $membersUri | Should Be 'https://graph.microsoft.com/v1.0/groups/group-id/members?$select=id'
    }

    It "builds a generic list payload that keeps its columns as an array" {
        $columns = @(@{ name = "Product"; text = @{} })

        $payload = New-ListPayload -ListName "Support Cases" -Description "Product support cases" -Columns $columns
        $json = $payload | ConvertTo-Json -Depth 20 -Compress

        $payload.displayName | Should Be "Support Cases"
        $payload.list.template | Should Be "genericList"
        $json | Should Match '"columns":\['
    }

    It "returns only list items whose key value is missing" {
        $desired = @(
            [pscustomobject]@{ Title = "CASE-1001" },
            [pscustomobject]@{ Title = "CASE-1002" },
            [pscustomobject]@{ Title = "CASE-1002" }
        )
        $existing = @([pscustomobject]@{ fields = [pscustomobject]@{ Title = "CASE-1001" } })

        $missing = Get-MissingListItems -DesiredItems $desired -ExistingItems $existing -KeyField "Title"

        (@($missing.Title) -join ",") | Should Be "CASE-1002"
    }

    It "builds the list items URI with the expanded fields query" {
        $uri = Get-ListItemsUri -SiteId "site-id" -ListId "list-id"

        $uri | Should Be 'https://graph.microsoft.com/v1.0/sites/site-id/lists/list-id/items?$expand=fields'
    }
}
