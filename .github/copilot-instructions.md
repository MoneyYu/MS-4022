# MS-4022 repository instructions

## Scope and language

- This repository prepares **MS-4022: Extend Microsoft 365 Copilot in Copilot Studio**.
- Default prose is Traditional Chinese; retain canonical Microsoft product names and code identifiers in English.
- The official module order is fixed: M01 declarative agents, M02 first declarative agent, M03 agent tools, M04 prompt tools, M05 connector tools.
- Do not copy MS-4014 material, its three-module structure, or its planning-first delivery model into this repository.

## Attendee and trainer boundaries

- `README.md` is attendee-facing HackMD content. Preserve its YAML front matter, admonitions, standalone-link spacing, module-grouped references/videos, markmap, and delivery metadata.
- Keep demo credentials, Graph permissions, seeding operations, facilitator cues, Knowledge Check answers, timing, UI drift, and version history in `docs/` or `seed-data/`, never in the attendee README.
- Use `docs/teaching-guide.md` for delivery guidance, `docs/demo-environment.md` for Product Support demo operations, and `docs/version-change-notes.md` for release history.

## Evidence and links

- Use official Microsoft Learn, Microsoft-maintained GitHub repositories, and official Microsoft video channels only. `Microsoft Helps` is a manually approved official channel when its ownership and video liveness have been checked.
- Before adding or retaining an external link, confirm final redirect, page title/topic, locale, and video channel/liveness. Keep candidates in `course-scratch/urls.txt` and run:

  ```powershell
  .\.venv\Scripts\python.exe .github\skills\course-prep\scripts\link_check.py course-scratch\urls.txt
  ```

- Do not retain generic hub redirects, dead links, broken localized repositories, or retired delivery links. The former `aka.ms/ms4022survey` link is invalid; delivery metadata must be refreshed before each class.
- Treat Change Log, Trainer Prep Guide, current Learn pages, lab instructions, and current slides as evidence. Cite the source for version-sensitive trainer guidance.

## Terminology and slide handling

- Use **agent tools**, not Copilot Studio actions, following the August 2025 refresh.
- Use **Copilot connectors**, not Graph connectors.
- In Traditional Chinese use **宣告式代理程式** and **自訂知識（grounding）** consistently.
- Treat generic certification slides in Intro/Conclusion as templates: replace them with course-accurate Achievement Code wording or skip them. Do not imply MS-4022 has an exam or a directly mapped Applied Skills assessment.
- Do not modify user-provided `PPT/` assets or untracked `.mcp.json` unless the user explicitly requests it.

## Product Support seeding

- `seed-data/scenarios/ms4022-productsupport/run.ps1` is the supported demo-data entry point. Run `-WhatIf` before any tenant operation.
- The target group alias must remain `ms4022-productsupport-<yyyyMMdd>` and the named document library must remain **`Products`**. This contract matches the lab knowledge and connector scenario.
- The seeder must remain idempotent for the same date: reuse the group, find/create the named library, and upload lab files.
- Use Microsoft Graph app-only client credentials only. Keep `config.json`, `source/`, tokens, and client secrets local; `.gitignore` must continue excluding them.
- Keep Graph permissions under the Microsoft Graph API, not the SharePoint API. Do not introduce user passwords, access keys, or secret values into committed files.

## Validation

- Python commands use the repo-local `.venv`; never use a global Python environment for generated or verification work.
- Run focused Pester tests after seeder changes, then run all tests before delivery:

  ```powershell
  Invoke-Pester -Script .\tests\*.Tests.ps1
  ```

- Parse every edited PowerShell script with the PowerShell AST before claiming it is valid.
- Validate README structure with the course-prep README contract, rerun the link checker, check local/external documentation links, and run `git diff --check` before completion.