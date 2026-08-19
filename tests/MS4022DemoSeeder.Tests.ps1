$runnerPath = Join-Path $PSScriptRoot "..\seed-data\scenarios\ms4022-productsupport\run.ps1"

Describe "MS-4022 Product Support demo seeder" {
    It "shows the dated neutral site and Products library in WhatIf mode" {
        $output = & $runnerPath -WhatIf -Date "20260819" 2>&1 | Out-String

        $output | Should Match "ms4022-productsupport-20260819"
        $output | Should Match "Products"
        $output | Should Not Match "Authenticating"
    }

    It "assigns the configured DemoUser role to the private Product Support site" {
        $scenarioRoot = Split-Path $runnerPath -Parent
        $seedData = Get-Content (Join-Path $scenarioRoot "sharepoint-sites.json") -Raw | ConvertFrom-Json
        $config = Get-Content (Join-Path $scenarioRoot "config.json.example") -Raw | ConvertFrom-Json

        (@($seedData.sites[0].members) -join ",") | Should Match "(^|,)DemoUser(,|$)"
        (@($config.roles.PSObject.Properties.Name) -join ",") | Should Match "(^|,)DemoUser(,|$)"
    }

    It "derives download and upload paths from filesSourceDir" {
        . $runnerPath -WhatIf | Out-Null

        $paths = Get-ScenarioSourcePaths -ScenarioRoot "C:\demo" -FilesSourceDir "custom\Products"

        $paths.ProductSourceDir | Should Be (Join-Path "C:\demo" "custom\Products")
        $paths.ZipPath | Should Be (Join-Path "C:\demo\custom" "Products.zip")
    }

    It "defines a Support Cases list with sample rows in the scenario" {
        $scenarioRoot = Split-Path $runnerPath -Parent
        $seedData = Get-Content (Join-Path $scenarioRoot "sharepoint-sites.json") -Raw | ConvertFrom-Json
        $list = $seedData.sites[0].lists | Where-Object displayName -eq "Support Cases"

        $list | Should Not BeNullOrEmpty
        $list.keyField | Should Be "Title"
        @($list.columns).Count | Should BeGreaterThan 3
        @($list.items).Count | Should BeGreaterThan 4
    }

    It "mentions the Support Cases list in WhatIf mode" {
        $output = & $runnerPath -WhatIf -Date "20260819" 2>&1 | Out-String

        $output | Should Match "Support Cases"
    }
}

