# MS-4022 Demo Environment（trainer-only）

本文件定義「Product Support」示範的可重複起點：用 SharePoint 的產品文件驗證宣告式代理程式的 knowledge source，再逐步加入 prompt tool 與 SharePoint connector tool。它補充學員版 [README](../README.md)，不取代官方 lab 指引。

## 設計決策與證據

| 決策 | 原因 | 證據 |
| --- | --- | --- |
| 使用日期化 private M365 Group site 與 `Products` 文件庫 | 可隔離每次授課資料，並符合 Lab 2、Lab 3 的產品支援情境。 | [scenario 定義](../seed-data/scenarios/ms4022-productsupport/sharepoint-sites.json)、[runner](../seed-data/scenarios/ms4022-productsupport/run.ps1)、[Lab 1.2](https://microsoftlearning.github.io/MS-4022-Extend-Microsoft-365-Copilot-in-Copilot-Studio/Instructions/Labs/01-Build-your-first-declarative-agent/02-add-custom-knowledge.html)、[Lab 3.1](https://microsoftlearning.github.io/MS-4022-Extend-Microsoft-365-Copilot-in-Copilot-Studio/Instructions/Labs/03-Connector-actions/01-create-connector-action.html)。 |
| 使用 app-only Microsoft Graph 來 seed，而不在課堂手動上傳檔案 | 可重複、具日期識別、可在 `-WhatIf` 先確認目標；機密僅留在本機設定檔。 | [seeder 操作說明](../seed-data/README.md)、[Graph connection script](../seed-data/engine/Connect-GraphApp.ps1)、[.gitignore](../.gitignore)。 |
| 以 SharePoint knowledge 和 connector tool 分別示範 | 前者回答文件內容並保留使用者權限，後者呼叫 API 取得或更新外部資料；兩者的責任不同。 | [M02 簡報：新增知識](../PPT/MS-4022-PowerPoint-Content.zh-TW.pptx)、[M05 簡報：連接器工具](../PPT/MS-4022-PowerPoint-Content.zh-TW.pptx)、[Add SharePoint as a knowledge source](https://learn.microsoft.com/en-us/microsoft-copilot-studio/knowledge-add-sharepoint)。 |
| 預留至少一天 | SharePoint knowledge ingestion 與索引非同步；將資料上傳與 knowledge source 設定安排在授課前至少 24 小時，並在授課前以測試 prompt 確認 citation。這是授課風險緩衝，不是產品 SLA。 | [Trainer Prep Guide](../PPT/MS-4022-ENU-TrainerPrepGuide.pdf) 要求講師課前自行完成 labs；[Lab 1.2](https://microsoftlearning.github.io/MS-4022-Extend-Microsoft-365-Copilot-in-Copilot-Studio/Instructions/Labs/01-Build-your-first-declarative-agent/02-add-custom-knowledge.html)。 |

## 課前條件

1. 準備具 Microsoft 365 Copilot 使用資格的 `Admin` 與 `DemoUser` 測試帳號，以及可使用 Copilot Studio 的 Power Platform environment。
2. 使用專屬 demo tenant 或受控的測試範圍；不要以正式生產資料或一般使用者帳號執行 seeder。
3. 依 [seeder 操作說明](../seed-data/README.md) 建立 app registration、授與 Microsoft Graph application permissions，並將機密只放進本機 `config.json`。
4. 在 Copilot Studio 目標 environment 建立或選取 solution，讓 agent、prompt 與 connector tool 可以一起管理與發佈。M03 簡報將 Power Platform environment、solution、authentication 與 inputs/outputs 列為工具設定考量。[來源](../PPT/MS-4022-PowerPoint-Content.zh-TW.pptx)

## 一日前：建立 SharePoint 資料

從 repo 根目錄執行：

```powershell
Set-Location .\seed-data\scenarios\ms4022-productsupport
.\run.ps1 -WhatIf -Date 20260819
.\run.ps1 -Date 20260819
```

預期結果：

- private group alias：`ms4022-productsupport-20260819`
- site display name：`MS-4022 - Product support - 20260819`
- named document library：`Products`
- library 內含官方 lab `Products.zip` 解出的範例檔案
- `Admin` 是 group owner，`DemoUser` 是 private group member

以 SharePoint UI 使用 `roles.Admin.upn` 與 `roles.DemoUser.upn` 驗證 site 與文件庫可開啟。重跑同一日期時，runner 會重用已驗證的 private Unified group、補齊 config 宣告的 owner/member、尋找既有 `Products` library，並重新上傳檔案。只有要隔離全新班次時才換日期。

## 建立 Product Support 宣告式代理程式

下列路徑依官方 Lab 1.1–1.3 的教學順序；產品 UI 可能改變，請以功能名稱而非畫面位置尋找。

1. 在 Copilot Studio 開啟 Microsoft 365 Copilot agents area，建立新的 declarative agent。
2. 設定名稱 `Product Support`，描述為「協助內部團隊根據核准產品文件回答產品支援問題」。
3. 建立 instruction，明確定義能力、語氣、資訊來源與 fallback。例如：

   ```text
   You are Product Support for Contoso products. Answer product questions using the approved Products SharePoint library. Cite the source when it is available. Be concise and suitable for non-technical users. If the information is unavailable, say so and direct the user to the support team; do not invent product facts.
   ```

4. 新增 SharePoint knowledge source，選擇或貼上剛建立的 Products 文件庫 URL。以使用者權限來測試，不要假定 agent 會越過 SharePoint ACL。
5. 建立 3 個 suggested prompts，讓使用者看見可提問的範圍：
   - `Compare the available warranty options for this product.`
   - `What product information is available for a customer asking about returns?`
   - `Summarize the product support guidance and cite the source.`
6. 儲存後先在 Copilot Studio 測試；確認三種 prompt 都能產生與 Products 文件相符的回答與 citation。

官方課程把「能力、語氣與角色、資訊來源、fallback」列為 instruction 的必要考量，並要求以 suggested prompts 展示 agent 的能力範圍。[Lab 1.1](https://microsoftlearning.github.io/MS-4022-Extend-Microsoft-365-Copilot-in-Copilot-Studio/Instructions/Labs/01-Build-your-first-declarative-agent/01-create-declarative-agent.html)、[Lab 1.2](https://microsoftlearning.github.io/MS-4022-Extend-Microsoft-365-Copilot-in-Copilot-Studio/Instructions/Labs/01-Build-your-first-declarative-agent/02-add-custom-knowledge.html)、[Lab 1.3](https://microsoftlearning.github.io/MS-4022-Extend-Microsoft-365-Copilot-in-Copilot-Studio/Instructions/Labs/01-Build-your-first-declarative-agent/03-add-starter-prompts.html)。

## 加入 Prompt Tool（M04）

1. 在同一 solution 建立 prompt，名稱例如 `Summarize product-support response`。
2. 定義 `productQuestion` 與 `groundedAnswer` 兩個 input；要求輸出固定為「摘要、建議下一步、未知資訊」三段。
3. 在 prompt builder 使用示例問題與已引用的回答測試，確認無資料時輸出「未知資訊」而不是編造內容。
4. 將 prompt 加入 agent 作為 tool，並在 agent test chat 測試何時由 orchestrator 選用。

此 tool 的示範重點是可重用 prompt template、明確 inputs/outputs、具體指令與 fallback，而不是把 SharePoint retrieval 重做一次。[Lab 2.1](https://microsoftlearning.github.io/MS-4022-Extend-Microsoft-365-Copilot-in-Copilot-Studio/Instructions/Labs/02-Prompt-actions/01-create-prompt-action.html)、[Prompts overview](https://learn.microsoft.com/en-us/microsoft-copilot-studio/prompts-overview)。

## 加入 Connector Tool（M05）

1. 在 solution 中建立 connector tool，選取 SharePoint connector 的列出資料夾或檔案動作，目標指向 `Products` document library。
2. 名稱使用 `List Product Support Files`，description 要明確寫出：列出 Products 文件庫內可供支援人員查閱的檔案，以及預期的輸入與輸出。
3. 建立連線時，使用 demo 使用者自己的 SharePoint credentials；不要用 app-only seeding secret 當作 connector user connection。
4. 將 tool 加入 agent，補充 instruction：使用者詢問「有哪些產品支援文件」或要求列出可用檔案時，使用此 tool。
5. 測試「List the available Product Support files」；結果應反映文件庫的實際檔案，並確認無權限使用者無法取得內容。

Connector tool 的核心是藉 API 取得或更新外部資料；名稱與 description 會協助 orchestration 決定何時與如何使用 tool。[Lab 3.1](https://microsoftlearning.github.io/MS-4022-Extend-Microsoft-365-Copilot-in-Copilot-Studio/Instructions/Labs/03-Connector-actions/01-create-connector-action.html)、[Use connectors in Copilot Studio agents](https://learn.microsoft.com/en-us/microsoft-copilot-studio/advanced-connectors)。

## 發佈與授課前驗證

1. Publish agent 至 Microsoft 365 Copilot，並依租用戶治理流程完成 admin review / availability 設定。
2. 在 Microsoft 365 Copilot 同時測試 immersive chat 與 `@mention` in-context chat。
3. 以 owner 和一般 demo 使用者各測一次，確認 SharePoint permission trimming 符合預期。
4. 完整驗收以下項目：

| 驗收項目 | 通過條件 |
| --- | --- |
| 知識回答 | Products 文件支援的回答包含 citation。 |
| 不存在的資訊 | agent 說明找不到資訊並導向支援管道，不杜撰答案。 |
| Prompt tool | 回覆遵守摘要、建議下一步、未知資訊的格式。 |
| Connector tool | 可列出 Products 文件庫檔案，且 description 所述 input/output 清楚。 |
| 發佈 | agent 在目標 demo 帳號的 Microsoft 365 Copilot 可見且可互動。 |

授課後，刪除或封存日期化 demo group、撤銷不再需要的 app secret，並保留不含機密的授課觀察記錄。