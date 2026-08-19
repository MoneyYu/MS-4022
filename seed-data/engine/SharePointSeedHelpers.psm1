function New-DocumentLibraryPayload {
    param(
        [Parameter(Mandatory)][string]$LibraryName
    )

    return @{
        displayName = $LibraryName
        list = @{ template = "documentLibrary" }
    }
}

function Get-DocumentUploadUri {
    param(
        [Parameter(Mandatory)][string]$SiteId,
        [string]$DriveId,
        [Parameter(Mandatory)][string]$Filename
    )

    $encodedFilename = [System.Uri]::EscapeDataString($Filename)
    if ($DriveId) {
        return "https://graph.microsoft.com/v1.0/drives/$DriveId/root:/$encodedFilename`:/content"
    }

    return "https://graph.microsoft.com/v1.0/sites/$SiteId/drive/root:/$encodedFilename`:/content"
}

function Assert-ExpectedDemoGroup {
    param(
        [Parameter(Mandatory)]$Group,
        [Parameter(Mandatory)][string]$Alias
    )

    $isExpectedGroup = $Group.mailNickname -eq $Alias -and
        @($Group.groupTypes) -contains "Unified" -and
        $Group.visibility -eq "Private"
    if (-not $isExpectedGroup) {
        throw "Existing group '$Alias' is not the expected private Unified Microsoft 365 Group."
    }
}

function Get-MissingDirectoryObjectUris {
    param(
        [string[]]$DesiredUris,
        [object[]]$ExistingDirectoryObjects
    )

    $existingIds = @($ExistingDirectoryObjects | ForEach-Object { $_.id })
    $seenObjectIds = @{}
    return @($DesiredUris | Where-Object {
        $objectId = ([System.Uri]$_).AbsolutePath.Trim("/").Split("/")[-1]
        if ($existingIds -contains $objectId -or $seenObjectIds.ContainsKey($objectId)) {
            return $false
        }
        $seenObjectIds[$objectId] = $true
        return $true
    })
}

function Get-PagedGraphValues {
    param(
        [Parameter(Mandatory)][string]$InitialUri,
        [Parameter(Mandatory)][scriptblock]$GetPage
    )

    $values = @()
    $nextUri = $InitialUri
    while ($nextUri) {
        $response = & $GetPage $nextUri
        $values += @($response.value)
        $nextUri = $response.'@odata.nextLink'
    }
    return @($values)
}

function New-GroupCreatePayload {
    param(
        [Parameter(Mandatory)]$Site,
        [Parameter(Mandatory)][string[]]$OwnerUris,
        [string[]]$MemberUris
    )

    $payload = @{
        displayName         = $Site.displayName
        description         = $Site.description
        groupTypes          = @("Unified")
        mailEnabled         = $true
        mailNickname        = $Site.alias
        securityEnabled     = $false
        visibility          = "Private"
        "owners@odata.bind" = @($OwnerUris)
    }
    if (@($MemberUris).Count -gt 0) {
        $payload["members@odata.bind"] = @($MemberUris)
    }
    return $payload
}

function Get-GroupRelationshipUri {
    param(
        [Parameter(Mandatory)][string]$GroupId,
        [Parameter(Mandatory)][ValidateSet("owners", "members")][string]$Relationship
    )

    return "https://graph.microsoft.com/v1.0/groups/$GroupId/${Relationship}?`$select=id"
}

Export-ModuleMember -Function New-DocumentLibraryPayload, Get-DocumentUploadUri, Assert-ExpectedDemoGroup, Get-MissingDirectoryObjectUris, Get-PagedGraphValues, New-GroupCreatePayload, Get-GroupRelationshipUri

