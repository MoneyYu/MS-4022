# MS-4022 Product Support demo seeder

此工具會將官方 lab 的 Products 範例資料上傳到日期化的私人 Microsoft 365 Group site，供 Product Support 宣告式代理程式作為 SharePoint knowledge source 與 connector tool 的資料來源。

## 安全邊界

- 只使用 Microsoft Graph app-only client-credentials flow；不使用租用戶 access key。
- `config.json` 與下載的 `source/` 資料皆被 [.gitignore](../.gitignore) 排除，不能提交。
- 對同一個 `-Date` 重跑時，runner 只會重用通過 private Unified Microsoft 365 Group 驗證的相同 alias，並尋找既有 `Products` 文件庫；其他同 alias group 會停止。上傳檔案會以同名目標檔覆寫。
- 此工具會建立 M365 Group，因此不適合以 `Sites.Selected` 縮限權限；請在專屬 demo tenant 或受控的測試範圍內執行。

## 必要條件

1. 安裝 PowerShell 7，並可連線至 Microsoft Graph。
2. 建立一個 Microsoft Entra app registration，採用 **Microsoft Graph application permissions**，不是 SharePoint API permissions。
3. 由租用戶管理員授與下列 permissions 的 admin consent：

| Permission | 程式需要的 Graph 操作 |
| --- | --- |
| `Group.ReadWrite.All` | 查詢或建立 Microsoft 365 Group，並設定 owner / member。 |
| `User.Read.All` | 由 `roles.Admin.upn` 與 `roles.DemoUser.upn` 解析 owner / member 的 Entra user ID。 |
| `Sites.Read.All` | 輪詢 `GET /groups/{id}/sites/root` 直到 group 的 SharePoint site 可用。 |
| `Sites.Manage.All` | 在已建立的 site 建立 `Products` document library。 |
| `Files.ReadWrite.All` | 將 lab 的 Products 檔案上傳至 document library drive。 |

`GET /groups/{id}/sites/root` 的 app-only 最小權限是 `Sites.Read.All`。[官方 Graph site 文件](https://learn.microsoft.com/en-us/graph/api/site-get?view=graph-rest-1.0) 也列出這個 group site 路徑。以上權限對應的程式證據分別在 [Invoke-SeedSharePoint.ps1](engine/Invoke-SeedSharePoint.ps1) 的 `/groups`、`/users`、`/sites/.../lists` 與 `/drives/.../content` 呼叫。權限或租用戶原則拒絕時，runner 會停止並保留 Graph 錯誤，請勿改以使用者帳密繞過。

## 設定

從 scenario 目錄建立僅限本機的設定檔：

```powershell
Set-Location .\seed-data\scenarios\ms4022-productsupport
Copy-Item .\config.json.example .\config.json
```

在 `config.json` 填入：

| 欄位 | 說明 |
| --- | --- |
| `tenantId` | 目標租用戶的 GUID。 |
| `clientId` | app registration 的 Application (client) ID。 |
| `clientSecret` | 該 app 的本機 secret value。不得提交或貼入文件。 |
| `roles.Admin.upn` | 將成為 demo group owner 的現有使用者 UPN。 |
| `roles.DemoUser.upn` | 將成為 demo group member、以自己 credentials 測試 SharePoint knowledge 與 connector 的現有使用者 UPN。 |
| `filesSourceDir` | 相對於 scenario root 的 Products 資料夾；runner 會由它推導 `Products.zip` 的下載位置。 |

## 執行

先執行不連線、不讀取設定檔的預覽：

```powershell
.\run.ps1 -WhatIf -Date 20260819
```

輸出應指出 `ms4022-productsupport-20260819` 與 `Products` 文件庫。確認日期與目標租用戶無誤後，再執行正式建立：

```powershell
.\run.ps1 -Date 20260819
```

第一次執行會從 MicrosoftLearning 官方 lab repository 下載 `Products.zip`、解壓至 `filesSourceDir`，建立 private group site 與 `Products` 文件庫，然後上傳檔案。若需重新下載最新 lab data，刪除 `filesSourceDir` 和相鄰的 `Products.zip` 再重跑。重跑既有日期時，runner 會補齊 config 宣告的 owner/member 關係；只在要隔離全新班次時才換 `-Date`。

## 完成條件

在 SharePoint 確認下列結果後，再進行 Copilot Studio lab：

1. 網站名稱為 `MS-4022 - Product support - <yyyyMMdd>`。
2. 有命名為 `Products` 的文件庫，且含 Products 範例檔案。
3. `roles.Admin.upn` 對該私人 site 具有 owner 存取權。
4. `roles.DemoUser.upn` 對該私人 site 具有 member 存取權。

接續的 Copilot Studio 設定與驗證步驟位於 [../docs/demo-environment.md](../docs/demo-environment.md)。