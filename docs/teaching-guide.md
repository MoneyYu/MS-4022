# MS-4022 備課指南（trainer-only）

本指南適用於 **MS-4022: Extend Microsoft 365 Copilot in Copilot Studio**。學員公開教材、lab 連結與課程 metadata 位於 [README](../README.md)；SharePoint Product Support demo 的建置流程位於 [demo-environment.md](demo-environment.md)。

## 交付基線與證據

| 項目 | 決定 | 證據 |
| --- | --- | --- |
| 課程目標 | 讓 makers/developers 以 Copilot Studio 建立宣告式代理程式、加入 knowledge 與 prompt/connector tools，並發佈至 Microsoft 365 Copilot。 | [Trainer Prep Guide](../PPT/MS-4022-ENU-TrainerPrepGuide.pdf) p.1、[課程頁](https://learn.microsoft.com/en-us/training/courses/ms-4022)。 |
| 課程範圍 | 依官方五模組授課：宣告式代理程式、第一個 agent、agent tools、prompt tools、connector tools。 | [繁中內容簡報](../PPT/MS-4022-PowerPoint-Content.zh-TW.pptx) slides 2、4、20、37、49、61。 |
| 時間 | 官方設計為 one-day，核心交付估計為 3–6 小時，休息時間另計；本指南提供 4 小時 35 分鐘含 15 分鐘休息的標準版。 | [Trainer Prep Guide](../PPT/MS-4022-ENU-TrainerPrepGuide.pdf) p.4–5。 |
| Lab 策略 | 講師必須先自行完成 labs；BYOE 使用官方 GitHub instructions，hosted delivery 則以 lab provider UI 為準。 | [Trainer Prep Guide](../PPT/MS-4022-ENU-TrainerPrepGuide.pdf) p.3、p.5。 |
| 版本狀態 | May 2025 初版後，August 2025 將 actions 用語改為 agent tools，December 2025 更新螢幕截圖並重新測試 labs；這些都是 minor refresh。 | [Change Log](../PPT/MS-4022-ENU-ChangeLog.pdf) p.2。 |

## 講師定位

- **適合對象**：熟悉 Microsoft 365 Copilot、具基本 AI 概念的 makers 與 developers。
- **講師先備**：要能實作 Copilot Studio agent，並說明 Power Platform connectors、Copilot connectors（舊稱 Graph connectors）、declarative agents，以及 model、orchestrator、plugin 等概念。
- **不應承諾**：本課不是認證考試或 Applied Skills 的直接準備課。交付時只說明 Achievement Code，並跳過通用 certification pitch；每次開課前重新確認當梯 credential 資訊。

## 五模組地圖

| 模組 | 學員完成後應能 | 講師主線 | 對應實作 |
| --- | --- | --- | --- |
| M01 - Microsoft 365 Copilot 宣告式代理程式簡介 | 評估何時適合使用宣告式代理程式，說明 instruction、knowledge、tool 的角色。 | 「情境明確、資料在 Microsoft 365、可沿用 M365 Copilot model/orchestration」才適合。 | 展示 immersive chat 與 `@mention` in-context chat。 |
| M02 - 使用 Copilot Studio 為 Microsoft 365 Copilot 建立您的第一個宣告式代理程式 | 設計 agent、撰寫 instructions、加上 SharePoint knowledge、發佈與驗證。 | Product Support agent：能力、語氣、知識來源、fallback 要一起定義。 | Lab 1.1、1.2、1.3。 |
| M03 - Copilot Studio 中宣告式代理程式工具簡介 | 分辨 prompt、connector、REST API、MCP 等 tool 類型與設定考量。 | Tool 是可重用 capability；description、inputs、outputs、environment 與 solution 影響 orchestration。 | 以「什麼時候用 knowledge，什麼時候用 tool」討論。 |
| M04 - 在 Copilot Studio 中使用提示詞工具擴充宣告式代理程式 | 建立、測試並加入 prompt tool。 | 好的 prompt 要具體、用範例、保持簡單、定義無法完成時的回應。 | Lab 2.1、sample prompt activity。 |
| M05 - 在 Copilot Studio 中使用連接器工具擴充宣告式代理程式 | 設定 connector tool、清楚描述 action，並在 agent 中測試。 | Connector tool 是透過 API 存取外部資料；使用者連線與 tool description 都是功能的一部分。 | Lab 3.1，改用 Support Cases 清單的 Get items connector tool。 |

## 建議議程

### 官方時間窗

| 區段 | 官方估計 | 主要互動 |
| --- | ---: | --- |
| Welcome / Introduction | 20–45 分鐘 | 自我介紹、課程與環境說明。 |
| M01 | Presentation 10–15 分鐘；interactivity 5–25 分鐘 | 宣告式 agent demo、KC。 |
| M02 | Presentation 10–15 分鐘；interactivity 55–90 分鐘 | Lab 1：建立 agent、knowledge、suggested prompts。 |
| M03 | Presentation 10–15 分鐘；interactivity 10–30 分鐘 | Tools discussion、KC。 |
| M04 | Presentation 10–15 分鐘；interactivity 30–60 分鐘 | Lab 2：prompt tool、sample prompt activity、KC。 |
| M05 | Presentation 10–15 分鐘；interactivity 25–45 分鐘 | Lab 3：connector tool、KC。 |
| Conclusion | 10–30 分鐘 | Learning path review、心得討論。 |

### 標準 4 小時 35 分鐘版本

此版本在官方 3–6 小時範圍內，保留三段 hands-on lab 與一段短休息；適合已有預先建立 Power Platform environment 與 Products 資料的班級。

| 時間 | 分鐘 | 區段 | 場控重點 |
| --- | ---: | --- | --- |
| 00:00–00:20 | 20 | Intro | 說明課程成果、lab 環境、互動規則與 Achievement Code。 |
| 00:20–00:50 | 30 | M01 | 以客服或 IT service desk 情境連結 instruction、knowledge、tool；demo 只顯示兩種 chat 體驗。 |
| 00:50–02:05 | 75 | M02 + Lab 1 | 先建立 Product Support，再完成 knowledge 與 suggested prompts；以 citation 驗收。 |
| 02:05–02:20 | 15 | Break | 講師確認每組 agent / knowledge source 狀態。 |
| 02:20–02:50 | 30 | M03 | 先討論 knowledge vs tool，再把 prompt、connector、MCP 放入同一個選擇框架。 |
| 02:50–03:40 | 50 | M04 + Lab 2 | 建立有輸入、輸出與 fallback 的 prompt tool，做 sample-data 測試。 |
| 03:40–04:25 | 45 | M05 + Lab 3 | 以 Products library 的 SharePoint connector tool 示範清楚 description 與 per-user connection。 |
| 04:25–04:35 | 10 | Conclusion | 讓學員說出一項回到工作後會先實作或驗證的能力。 |

### 壓縮與延展規則

- **壓縮至 3 小時**：預先 seed Products、預先建立 environment，Lab 1 只完成 knowledge 與一個 suggested prompt；M04/M05 改講師示範，KC 採 inline 快問快答。
- **延展至 6 小時**：保留每個 lab 的 troubleshooting、M03 discussion、M04 sample prompt activity，以及使用兩種使用者權限測試 citation/connector 結果。
- **時間先砍順序**：先縮 share-out，再縮 demo 範圍，最後才減少 lab 選用步驟；不要省略 M02 的 citation 或 M05 的 connection/description 驗收。

## 模組 facilitation 與 Knowledge Check

### M01 - Microsoft 365 Copilot 宣告式代理程式簡介

**說明重點**

- 宣告式代理程式是對話式 AI，可提供資訊並執行工作；典型情境是客戶支援、IT service desk、HR support。
- 三個組成元件要清楚區分：**instructions** 定義行為與界限，**knowledge** 提供 grounding，**tools** 讓 agent 與外部系統互動。
- 用同一個案例判斷適合性：若需要自訂 model/orchestrator，不要強行套成宣告式 agent；若可用 Microsoft 365 資料與 connector/tool 補足，就適合先從 declarative path 開始。

**互動與 demo**

- 問學員：「你們的支援問題中，哪一類最適合用受控文件回答？」再把答案映射到 knowledge；追問哪些問題需要讀取即時系統，讓學員說出 tool。
- 示範 immersive 1:1 chat 與 Copilot Chat 中的 `@mention`，不要 live build。

**Knowledge Check 提示**

| 題意 | 正確概念 | 為何 |
| --- | --- | --- |
| 將即時內部訂單系統整合到 agent | Custom tool | 即時 API 系統不是 instruction 或 knowledge source 的替代品。 |
| Custom instructions 與 custom grounding 的差異 | Instructions 定義行為；grounding 提供額外資料與脈絡 | 兩者解決不同問題。 |
| 可作為 grounding 的 Microsoft 365 資料 | SharePoint Online、OneDrive、經 Copilot connectors 擷取到 Microsoft 365 的資料 | 對應投影片列出的可用來源。 |

來源：[繁中內容簡報](../PPT/MS-4022-PowerPoint-Content.zh-TW.pptx) slides 4–17、[M01 Learn module](https://learn.microsoft.com/en-us/training/modules/copilot-declarative-agent-intro/)。

### M02 - 使用 Copilot Studio 為 Microsoft 365 Copilot 建立您的第一個宣告式代理程式

**說明重點**

- 開始前先讓學員寫出 capability、tone/role、information sources、fallback；這四項是 instruction 的驗收條件。
- SharePoint knowledge source 採使用者權限；要求每組測試一個可回答問題與一個無資料問題，兩者都要看 citation/fallback。
- Suggested prompts 是可用情境的入口，不只是漂亮按鈕；每組最多挑 3 個真實問題來證明能力範圍。

**Lab 路徑**

1. [Lab 1.1 - Create a declarative agent](https://microsoftlearning.github.io/MS-4022-Extend-Microsoft-365-Copilot-in-Copilot-Studio/Instructions/Labs/01-Build-your-first-declarative-agent/01-create-declarative-agent.html)
2. [Lab 1.2 - Add custom knowledge](https://microsoftlearning.github.io/MS-4022-Extend-Microsoft-365-Copilot-in-Copilot-Studio/Instructions/Labs/01-Build-your-first-declarative-agent/02-add-custom-knowledge.html)
3. [Lab 1.3 - Add suggested prompts](https://microsoftlearning.github.io/MS-4022-Extend-Microsoft-365-Copilot-in-Copilot-Studio/Instructions/Labs/01-Build-your-first-declarative-agent/03-add-starter-prompts.html)

**Knowledge Check 提示**

| 題意 | 正確概念 |
| --- | --- |
| 發佈給全租用戶使用 | 選擇向組織中的所有人顯示，並遵守租用戶的 admin governance。 |
| 撰寫 instruction 時的考量 | 功能、語氣與角色、資訊來源、fallback 程序。 |
| 讓回答更準確、相關的 agent 元件 | Custom grounding / custom knowledge。 |

來源：[繁中內容簡報](../PPT/MS-4022-PowerPoint-Content.zh-TW.pptx) slides 20–35、[M02 Learn module](https://learn.microsoft.com/en-us/training/modules/build-your-first-agent-microsoft-365-copilot-use-copilot-studio/)。

### M03 - Copilot Studio 中宣告式代理程式工具簡介

**說明重點**

- Tool 是可重用 capability；同一個 core tool 可依不同 agent 的 input、output、configuration 包裝。
- 用問題分類而不是產品名稱帶領選擇：要產生/轉換文字用 prompt tool；要取回或更新外部 API 資料用 connector tool；未被現成 connector 覆蓋的 API 再考慮 REST API；既有 knowledge server 與資料來源可考慮 MCP。
- 先設計 tool description、authentication、inputs/outputs、Power Platform environment 和 solution，再建 tool。

**討論題**

「你的 agent 需要知道、生成、讀取或更新什麼？哪些動作需要使用者自己的 connection？」把答案分到 knowledge、prompt、connector、MCP，不讓「能做」取代「該做」。

**Knowledge Check 提示**

| 題意 | 正確概念 |
| --- | --- |
| 透過 API 擷取與更新外部來源資料 | Connector tool。 |
| Solution 的主要用途 | 在 environments 間傳輸應用程式與元件，或管理一組自訂項目。 |
| Prompt tool 如何擴充 agent | 加入可執行的自訂 prompt template 來產生客製文字回應。 |

來源：[繁中內容簡報](../PPT/MS-4022-PowerPoint-Content.zh-TW.pptx) slides 37–47、[M03 Learn module](https://learn.microsoft.com/en-us/training/modules/introduction-copilot-studio-actions/)。

### M04 - 在 Copilot Studio 中使用提示詞工具擴充宣告式代理程式

**說明重點**

- Prompt tool 是可重用的 custom prompt template，可用於分類、擷取實體、草擬回覆或摘要。
- 讓每組把「具體指令、範例、簡潔、無法完成時的處理」逐一寫出；只要求「寫一個好 prompt」無法驗收。
- inputs 是執行時填入實際資料的 placeholders；測試時使用 sample data，查看 model response 後再精煉。

**Lab 與活動**

- [Lab 2.1 - Create a prompt tool](https://microsoftlearning.github.io/MS-4022-Extend-Microsoft-365-Copilot-in-Copilot-Studio/Instructions/Labs/02-Prompt-actions/01-create-prompt-action.html)
- 以一則 Products 文件回答做範例，產出「摘要、建議下一步、未知資訊」；故意移除必要資料一次，檢查 fallback 是否如預期。

**Knowledge Check 提示**

| 題意 | 正確概念 |
| --- | --- |
| Prompt engineering 的主要目標 | 提供盡可能具體的指示，以取得更相關回覆。 |
| Prompt inputs 的用途 | 作為 placeholder，在執行階段填入實際資料。 |
| Prompt tool 的目的 | 以 custom prompt 擴充 agent，產生符合使用者要求的回應。 |

來源：[繁中內容簡報](../PPT/MS-4022-PowerPoint-Content.zh-TW.pptx) slides 49–59、[M04 Learn module](https://learn.microsoft.com/en-us/training/modules/extend-declarative-agents-prompt-actions-copilot-studio/)。

### M05 - 在 Copilot Studio 中使用連接器工具擴充宣告式代理程式

**說明重點**

- Connector tool 透過 API 從外部服務取得或更新資料；有現成、進階與自訂 connector，選擇受環境與方案限制。
- 名稱必須唯一且可辨識；description 使用預期使用者會說的詞，並明寫 action、輸入、輸出，才能幫助 orchestrator 選用正確 tool。
- Authentication 不只是設定步驟：demo 的 SharePoint connection 必須以使用者 credentials 反映其資料權限。

**Lab 路徑**

1. [Lab 3.1 - Create a connector tool](https://microsoftlearning.github.io/MS-4022-Extend-Microsoft-365-Copilot-in-Copilot-Studio/Instructions/Labs/03-Connector-actions/01-create-connector-action.html) — 建立連線與加入工具的流程照這一頁操作。
2. 在 Add tool 搜尋 `SharePoint`，選擇 **Get items** 動作。
3. tool name 用 `Get product support cases`；description 明寫可依產品或狀態查詢 Contoso 產品支援案件，並說明預期的輸入與輸出。
4. Inputs：`Site Address` 指向 demo 站台，`List Name` 選 `Support Cases`。
5. 建立連線時使用學員自己的帳號，讓 agent 只能取得該使用者有權限的清單資料。
6. 在 agent instructions 補一句：詢問案件狀態、未結案件或特定產品的支援紀錄時，使用這個 connector tool，並說明資料來自 SharePoint 清單。
7. 用兩個對照提問驗收：「保固怎麼計算？」應走 M02 的文件 knowledge；「Mark8 目前有哪些未結案件？」應走這個 connector tool。

> 官方 lab 頁面用的是 `List folder` 搭配 `File Identifier = Products`，只回答「有哪些檔案」。本課改用 `Get items` 是刻意調整：清單回傳可查詢的營運資料，「文件回答政策、清單回答即時狀態」的對比才成立。若你拿到的是沒有 seed 過 `Support Cases` 清單的 hosted lab 環境，就照官方 `List folder` 步驟走，其餘教學重點不變。

清單資料由 [demo-environment.md](demo-environment.md) 的 seeder 建立。

**Knowledge Check 提示**

| 題意 | 正確概念 |
| --- | --- |
| 為何 connector tool 要有具描述性的 description | 協助 Microsoft 365 Copilot 與 agent 了解工具功能和使用方式。 |
| 為自有 API 建置的 connector | Custom connector。 |
| Connector tool name 的準則 | 唯一且具描述性，說明可執行的動作類型。 |

來源：[繁中內容簡報](../PPT/MS-4022-PowerPoint-Content.zh-TW.pptx) slides 61–72、[M05 Learn module](https://learn.microsoft.com/en-us/training/modules/extend-declarative-agents-connector-actions-copilot-studio/)。

## 簡報術語與交付修正表

| 舊字詞或通用投影片 | 交付時使用 | 原因與證據 |
| --- | --- | --- |
| `智慧…副駕駛®` 或泛稱 Copilot | **Microsoft 365 Copilot** | 課程目標明確是延伸 Microsoft 365 Copilot，不要泛化成其他 Copilot 產品。 |
| `宣告式助理` | **宣告式代理程式** | 繁中內容簡報 slide 4 同時出現兩種翻譯；統一 agent 對應「代理程式」。 |
| `自訂基礎` | **自訂知識（grounding）** | 簡報 slides 9、11、16、34 的概念是以知識來源為回覆提供 grounding；口語說明時用這個可辨識的用語。 |
| Graph connectors | **Copilot connectors** | Trainer Prep Guide p.2、p.6 明確說明產品重新命名。 |
| Copilot Studio actions | **agent tools** | Change Log 的 August 2025 minor refresh 明確指定此用語更新。 |
| Intro slide 12、Conclusion slide 3 的 generic certification 文案 | **跳過或改寫成 Achievement Code** | 這些是通用模板，並不證明 MS-4022 有認證考試；Intro / Conclusion deck 自己標示需依課程客製。 |

## 預期問題

### Knowledge source 和 connector tool 有何差異？

Knowledge source 用文件進行 grounding，回答要以引用與使用者 SharePoint 權限驗證；connector tool 則是為外部 API 的讀取或更新動作建立可呼叫能力。Products scenario 應同時示範兩者，而不是把 connector 當成文件問答的替代品。

### 為何回答沒有立即引用新上傳的文件？

SharePoint ingestion/indexing 是非同步的。資料與 knowledge source 應至少在授課前一天建立，再用兩個不同類型的問題驗證 citation；不要在課堂上承諾即時完成索引。

### 為何 connector tool 需要清楚的 description？

Orchestrator 必須能將使用者意圖配對到正確 tool。抽象名稱或空泛 description 會使工具雖已建立卻難以被選用；M05 的 KC 直接驗證這個概念。

### 是否可以直接把 app-only seeder secret 用於 Copilot Studio connector？

不可以。Seeder 的 app-only credential 只用於課前建立 demo data；connector 應使用使用者 connection，才能反映使用者資料權限並避免把 secret 帶入 agent 設定。

### 那 Copilot Studio 的 workflows / agent flows 呢？

本課的宣告式代理程式只支援 prompt tool 與 connector tool；**agent flows 與 computer use 不支援宣告式代理程式**，那是自訂代理程式的路線。Trainer Prep Guide 的 common misconceptions 已明列這一點，M03 也會講到。學員若追問自動化情境，可用下列講師背景資料補充，但不要把它當成本課的 lab 路徑：

[Power Hour: Reimagine Automation with Copilot Studio Workflows（隨選錄影）](https://info.microsoft.com/AA-AccLC-VDEO-FY27-07Jul-30-Power-Hour-Reimagine-Automation-with-Copilot-Studio-Workflows-SREVM94772_LP02-Thank-You---Standard-Hero.html)

> 這是行銷活動資產，不是 Learn 文件：網址帶 FY27 campaign ID、頁面標題仍含未取代的 `[REPLACE]` 佔位符，隨時可能失效或改版。學員版 README 把它與 Copilot Studio blog 一起放在 `## Links` 的 `### Beyond this course` 群組，刻意與五個模組的參考索引分開；`## Videos` 仍只收官方 YouTube 頻道。開課前請先自行確認仍可播放。

## 開課前檢核

- [ ] 重跑 [README](../README.md) 連結帳本，確認 Learn、labs 與影片仍可用。
- [ ] 閱讀最新 [Change Log](../PPT/MS-4022-ENU-ChangeLog.pdf)，特別確認 UI、labs 與 tool terminology 是否再次更新。
- [ ] 掃描 [Copilot Studio blog](https://www.microsoft.com/en-us/microsoft-copilot/blog/copilot-studio/) 的近期公告，確認沒有影響 demo 或 lab 的產品變更。
- [ ] 自行完成 Lab 1.1、1.2、1.3、2.1、3.1；記錄任何 UI 差異與可行替代路徑。
- [ ] 至少一天前依 [demo-environment.md](demo-environment.md) 建立 Products 資料與 SharePoint knowledge source，並驗證 citation。
- [ ] 確認 Power Platform environment、solution、Microsoft 365 Copilot 授權與 target users 的 SharePoint permissions。
- [ ] 測試 prompt tool 的正常與無資料輸入；測試 connector tool 的 authorized 與 unauthorized user 結果。
- [ ] 將 Intro slide 1、Intro slide 4、Intro slide 8、Intro slide 10、Intro slide 12、Conclusion slide 1、Conclusion slide 3 依本班資訊客製或刪除模板備註。
- [ ] 準備 product UI 改版時的教學策略：先讓學員辨認功能名稱與目的，再協助定位，不強迫畫面必須與 lab 截圖一致。

## 授課技巧

- 不要逐字念投影片。Trainer Prep Guide 要求講師補上「what、why、how」，而非朗讀 bullet points。
- 用同一個 Product Support 案例貫穿五模組：M01 判斷適合性、M02 建 agent、M03 選 tool、M04 格式化回覆、M05 列出檔案。
- KC 可分散於相應內容中，不必等模組末才集中進行；若學員挑戰答案，回到對應 slide 的概念與 lab 行為，而不是憑記憶辯論。
- UI 與 lab 指引不同時，先要求學員描述他們要找的 capability；僅在真的卡住時介入。官方 Trainer Prep Guide 明確提醒雲端產品 UI 會持續變動。
- 最後的討論不要問「喜不喜歡課程」；請每位學員說出一個要帶回工作中的 knowledge、prompt 或 connector 假設，以及要如何驗證它。

## 來源

- [MS-4022 Trainer Preparation Guide](../PPT/MS-4022-ENU-TrainerPrepGuide.pdf)
- [MS-4022 Change Log](../PPT/MS-4022-ENU-ChangeLog.pdf)
- [MS-4022 Traditional Chinese content deck](../PPT/MS-4022-PowerPoint-Content.zh-TW.pptx)
- [MS-4022 Intro deck](../PPT/MS-4022-ENU-PowerPoint-Intro.pptx)
- [MS-4022 Conclusion deck](../PPT/MS-4022-ENU-PowerPoint-Conclusion.pptx)
- [Official MicrosoftLearning lab repository](https://github.com/MicrosoftLearning/MS-4022-Extend-Microsoft-365-Copilot-in-Copilot-Studio)
