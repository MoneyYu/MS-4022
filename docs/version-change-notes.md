# MS-4022 版本差異說明（trainer-only）

本文件只記錄 **MS-4022: Extend Microsoft 365 Copilot in Copilot Studio** 的版本基線與交付影響。學員版課程資料在 [README](../README.md)，授課方式與投影片修正在 [teaching-guide.md](teaching-guide.md)。

## 目前基線

| 項目 | 目前內容 | 來源 |
| --- | --- | --- |
| 課程名稱 | MS-4022: Extend Microsoft 365 Copilot in Copilot Studio | [Course page](https://learn.microsoft.com/en-us/training/courses/ms-4022)、[Change Log](../PPT/MS-4022-ENU-ChangeLog.pdf) p.1。 |
| 學習路徑 | 五個 modules：declarative agents、first agent、agent tools、prompt tools、connector tools。 | [Learning path](https://learn.microsoft.com/en-us/training/paths/extend-microsoft-365-copilot-studio/)、[繁中內容簡報](../PPT/MS-4022-PowerPoint-Content.zh-TW.pptx) slide 2。 |
| 交付模式 | One-day course；依學員問題與熟悉度調整核心 3–6 小時，休息時間另計。 | [Trainer Prep Guide](../PPT/MS-4022-ENU-TrainerPrepGuide.pdf) p.4。 |
| Lab 模式 | Hosted delivery 使用 lab provider UI；BYOE 使用 MicrosoftLearning GitHub lab instructions。 | [Trainer Prep Guide](../PPT/MS-4022-ENU-TrainerPrepGuide.pdf) p.5。 |

## 官方版本歷程

| 日期 | 變更類型 | 官方變更 | 講師交付調整 |
| --- | --- | --- | --- |
| 2025-05-16 | Initial release | 釋出 Learn content、PowerPoint、Trainer Prep Guide 與 lab instructions，採 bring-your-own-environment approach。 | 建立 environment、課前實跑 labs，並以 official GitHub instructions 作為 BYOE 依據。 |
| 2025-08-22 | Minor - General | 用語從 **Copilot Studio actions** 更新為 **agent tools**，並更新 slides、Learn content、labs 中的相關工具設定。 | 講義、口語、demo label 全部使用「代理程式工具 / agent tools」；不要把 actions 當成現在的頂層概念。 |
| 2025-12-12 | Minor - General, Labs | 更新 Learn content 與 slides 的 screenshots，並測試/更新 labs 以符合最新 UI。 | 授課前自行走一次每個 lab；按功能名稱與目的引導，不能承諾 UI 位置仍與截圖完全相同。 |

**結論：** 隨附的 December 2025 Change Log 只列出初版與兩次 **minor** refresh，沒有 MS-4022 的 major refresh 記錄。先前 MS-4014 的 3 模組、3 小時、discussion-first 內容不屬於本課，不能沿用。

## 需要維持的現行用語

| 不應再作為主用語 | 授課使用 | 證據與原因 |
| --- | --- | --- |
| Copilot Studio actions | Agent tools / 代理程式工具 | August 2025 Change Log 指定的更新。 |
| Graph connectors | Copilot connectors | Trainer Prep Guide p.2、p.6 明示 rebrand。 |
| 宣告式助理 | 宣告式代理程式 | 統一 Traditional Chinese 中 agent 的翻譯；詳見 [teaching-guide.md](teaching-guide.md)。 |
| 自訂基礎 | 自訂知識（grounding） | 避免把 knowledge source 的角色誤解成 generic foundation；詳見 [teaching-guide.md](teaching-guide.md)。 |
| 泛稱 Copilot 或 generic Copilot certification | Microsoft 365 Copilot；Achievement Code | 本課明確延伸 Microsoft 365 Copilot，且 generic certification template 不能當成 MS-4022 exam 證據。 |

## Lab 與 demo 的版本處置

| 項目 | 做法 | 理由 |
| --- | --- | --- |
| 官方 lab instructions | 每次開課前重新開啟 Lab 1.1、1.2、1.3、2.1、3.1。 | December 2025 已證明 UI 與 lab 會持續更新。 |
| UI 差異 | 引導學員找同一個 capability；只有卡住才介入，並在課後回報 MicrosoftLearning repo。 | Trainer Prep Guide p.5–6 說明雲端 UI 會調整，並要求將重大 lab 落差記錄到 repo。 |
| Product Support demo data | 課前至少一天用 [seeder](../seed-data/README.md) 建立 `Products` 文件庫，再驗證 knowledge citation 與 connector tool。 | SharePoint ingestion/indexing 需要授課風險緩衝；這是 operation safeguard，不是產品 SLA。 |
| 學員 README | 只保留 current official course、learning path、lab、影片與憑證說明。 | 避免把 trainer 環境、app permissions、機密或版本遷移細節公開。 |

## 每次開課前的差異檢查

- [ ] 下載目前的 PowerPoint、Trainer Prep Guide、Change Log，不要假定 repo 中的文件仍是最新版。
- [ ] 從 [README](../README.md) 的帳本重新驗證所有 Learn、lab 與影片連結；任何導到 generic hub 或失效的連結都移除或更新。
- [ ] 檢查 course slides、講師口語與 lab 指引中是否仍有 `actions`、`Graph connectors`、`宣告式助理`、`自訂基礎` 等舊用語。
- [ ] 先自行完成 labs，記錄 UI 差異；不要臨場第一次走 lab。
- [ ] 檢查 Intro 與 Conclusion 的 generic certification slides 是否已跳過或改成 Achievement Code。
- [ ] 確認當梯 Date、Course ID、Training key、survey 與任何 portal 資訊；它們是 delivery metadata，不是版本事實。

## 來源

- [MS-4022 Change Log](../PPT/MS-4022-ENU-ChangeLog.pdf)
- [MS-4022 Trainer Preparation Guide](../PPT/MS-4022-ENU-TrainerPrepGuide.pdf)
- [MS-4022 Traditional Chinese content deck](../PPT/MS-4022-PowerPoint-Content.zh-TW.pptx)
- [Official MicrosoftLearning lab repository](https://github.com/MicrosoftLearning/MS-4022-Extend-Microsoft-365-Copilot-in-Copilot-Studio)