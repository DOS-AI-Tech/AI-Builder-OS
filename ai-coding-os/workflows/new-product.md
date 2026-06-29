# Workflow: New Product

## Purpose

Take a raw product idea from concept through implementation, testing, and deployment — in one end-to-end PM-driven flow.

## Trigger

- New project with no existing task logs
- User says "new product", "新产品", "start from scratch", or equivalent
- Auto-detected by Intake & Routing: `.ai/memory/task-log/` is empty or contains only `TEMPLATE.md`

## Required reads

1. `.ai/memory/frozen/architecture.yaml`
2. `.ai/memory/active/current-state.yaml`
3. Latest `.ai/memory/task-log/`
4. Any existing product plan, PRD, or customer interview artifacts

## Execution model

The PM drives every phase in sequence. At the end of each phase, PM uses the Phase Reporting Template (defined in project-manager skill) to report what was done, teach the user how to verify it, and offer the option to continue or give feedback.

**Two mandatory user interactions:**
1. Phase 0 — User describes the idea and answers 2 intake questions. No phase begins until both answers are given.
2. Gate 5 — User confirms the deployed product works. Workflow does not close until confirmed.

All other phase boundaries: user may say 「继续」 to skip verification and proceed, or give feedback for PM to adjust.

## State transitions

```
phase_0_intake
  → clarification              [PM reports → user continues or adjusts]
  → product_direction          [PM reports → user continues or adjusts]
  → mvp_scope                  [PM reports → user continues or adjusts]
  → technical_architecture     [PM reports → user continues or adjusts]
  → implementation_plan        [PM reports → user continues or adjusts]
  → implementation
  → test_design
  → test_write
  → test_execute
  → test_fix                   [loop until all tests pass]
  → delivery                   [PM reports → user continues or adjusts]
  → deployment                 [Gate 5: user explicitly confirms]
```

## File write rule

**Displaying content in conversation is NOT saving it to disk.**
Before reporting a phase complete:
1. Invoke your file-write tool for each required document.
2. Wait for the tool to return success.
3. Include the exact path in the Phase Report: "已保存至 `[path]`"
4. Only then display the Phase Report.

If a file-write tool is unavailable or fails: stop, report the failure, and do not advance to the next phase.

---

## Phase 0: Intake

PM presents both questions together in a single message. Do not split across multiple messages.

---

**在我们开始之前，需要了解两件事，帮我更好地规划这个项目：**

**问题 1 — 这个产品做好后，使用它的人主要会做什么？**

请选择最接近的描述：

- **A** — 浏览信息、展示内容（例如：企业官网、个人主页、活动介绍页）
- **B** — 在网页上操作、计算、生成结果（例如：在线工具、表单、计算器）
- **C** — 注册登录、提交数据、查看记录（例如：管理系统、预约平台、内部应用）
- **D** — 给其他程序调用接口（例如：数据服务、业务 API）

**问题 2 — 产品完成后，您希望以哪种方式让别人使用它？**

- **A** — 发布到网上，任何人都能用链接访问
- **B** — 在本机或公司电脑上运行，主要用于演示
- **C** — 部署到公司内部服务器

---

Record the answers as `product_type` (1/2/3/4) and `delivery_target` (A/B/C). These two values flow through every subsequent phase and must not be changed without user instruction.

If the user's description already makes the answers obvious, PM may infer them and state the inference for user confirmation before proceeding.

---

## Phase 1: Clarification → Product Direction

Requirements Analyst works through `.ai/templates/product_define.md` Sections 1–5 with the user:
- What problem does this solve?
- Who is the target user?
- What does success look like?

**Website detection — conditional step:**
If `product_type` is 1 or 2 (website or web tool): complete **Section 1.5 (Website Style & Design)** before continuing. Present the two style questions in plain, conversational language (as written in the template). Wait for the user's choices before filling Sections 2–5. Do not skip.

**Required before Phase Report:**
Save `project_docs/YYYY-MM-DD-[slug]/product_define.md` with Sections 1–5 (plus 1.5 if website). Confirm save succeeded. Then PM reports using Phase Reporting Template.

**Verification guidance for this phase:**
"打开 `product_define.md` 的第 1-5 节，看看里面描述的问题、目标用户和成功标准是不是您想要的。如果方向不对，告诉我哪里需要改。"

---

## Phase 2: MVP Scope

Requirements Analyst works through the same document, filling in Sections 6–9:
- Core features with per-feature acceptance criteria vs deferred features
- Technical constraints
- Success criteria and risks

Then fills `.ai/templates/requirements.md` with the feature list and acceptance criteria derived from Section 6.

**Required before Phase Report:**
1. Update `project_docs/YYYY-MM-DD-[slug]/product_define.md` with Sections 6–9.
2. Save `project_docs/YYYY-MM-DD-[slug]/requirements.md`.
Confirm both saves succeeded. Then PM reports.

**Verification guidance:**
"打开 `requirements.md`，看第 2 节的功能列表。确认里面每个功能都是您想要的，有没有多余的或者遗漏的。"

---

## Phase 2.5: Technical Architecture

Architect produces `architecture.md` based on confirmed MVP scope.

### Tech Stack Guard

Before designing the architecture, Architect reads `product_type` and `delivery_target` from Phase 0 and applies the following mandatory stack:

| product_type | delivery_target | Mandated stack | Forbidden |
|---|---|---|---|
| Type 1 (静态站) | Target A (公网) | HTML / CSS / JS · Netlify or Vercel | Frameworks, build tools, any backend |
| Type 2 (前端工具) | Target A (公网) | HTML / CSS / JS · Alpine.js (optional) · Netlify | React, Vue, Next.js, any backend |
| Type 3 (全栈Demo) | Target B (本地) or C (服务器) | Python Flask · SQLite · Docker Compose | PostgreSQL, Redis, microservices |
| Type 3 (全栈Demo) | Target A (公网) | Python Flask · SQLite · Render | Same as above |
| Type 4 (API服务) | Target B (本地) or C (服务器) | Python FastAPI · SQLite · Docker Compose | Same as above |
| Type 4 (API服务) | Target A (公网) | Python FastAPI · SQLite · Render | Same as above |

If the user's request implies a stack not in the mandated column: stop. Tell the user: "这个项目类型推荐使用 [mandated stack]，[forbidden item] 对于这个场景过于复杂，会增加不必要的难度。如果您有特殊原因需要使用它，请告诉我。" Only override the guard if the user explicitly insists after the warning.

`architecture.md` must include a section declaring: selected stack, alternatives considered, and why each alternative was excluded.

**Required before Phase Report:**
Save `project_docs/YYYY-MM-DD-[slug]/architecture.md`. Confirm save. Then PM reports.

**Verification guidance:**
"打开 `architecture.md`，看一下技术方案的说明。主要确认：系统分几个部分、用什么语言和工具、数据怎么存储。不需要看懂所有细节——只要大方向符合您的期望就可以。"

---

## Phase 3: Implementation Plan

PM fills `.ai/templates/dev_plan.md`:
- Every file to create or modify (change type and reason)
- Every behavior change (API, schema, permissions, config defaults)
- Every uncertain design decision (options + recommendation)

**Required before Phase Report:**
Save `project_docs/YYYY-MM-DD-[slug]/dev_plan.md`. Confirm save. Then PM reports.

**Verification guidance:**
"打开 `dev_plan.md`，看一下要创建的文件列表和功能变更说明。如果您发现有功能没有在计划里，或者计划里有您不想要的内容，现在是最好的时机告诉我——代码还没开始写。"

No code is written until PM reports Phase 3 complete and the user says 「继续」 or equivalent.

---

## Phase 4: Implementation

Developer implements only what was approved in Phase 3.
If a new file or behavior change is needed mid-implementation: stop, update `dev_plan.md`, report the change to the user before continuing.

No Phase Report needed at the end of implementation — proceed directly to Phase 5.

---

## Phase 5: Testing

**Test design** — Test Engineer fills `.ai/templates/test_plan.md`:
- Test strategy (automated vs manual, and why)
- Every test file path, mapped to acceptance criteria from `requirements.md`
- Coverage map: every acceptance criterion traces to at least one test
- Manual test checklist for items that cannot be automated

**Required before writing test code:**
Save `project_docs/YYYY-MM-DD-[slug]/test_plan.md`. Confirm save.

**Test write** — Write test code at paths listed in `test_plan.md`.

**Test execute** — Run all tests, report results against coverage map.

**Test fix loop** — For each failing test:
1. Diagnose root cause
2. Fix implementation or test (state which, and why)
3. Re-run
4. Repeat until all tests pass

---

## Phase 6: Delivery Summary

PM presents:
- What was built (matches Phase 3 scope)
- Test results mapped to acceptance criteria
- Manual test checklist for human to run

**Phase Report:**

**Verification guidance:**
"下面是手工测试清单，您可以按照清单一项一项试一下。如果都没问题，我们就进入最后一步：把产品部署起来。"

User says 「继续」 (or completes manual tests and confirms ok) → proceed to Gate 5.

---

## Gate 5: Deployment (Mandatory — user must confirm)

This is the only gate where the user must explicitly confirm before the workflow closes.

Deployment Engineer generates deployment artifacts based on `product_type` and `delivery_target`.

### Type 1 / Type 2 × Target A (公网静态托管)

1. Generate `netlify.toml` (publish directory set to project root or build output) **or** `vercel.json` (static config).
2. Save artifact to `project_docs/YYYY-MM-DD-[slug]/`.
3. Provide step-by-step deployment guide — no CLI required version for non-technical users:
   - Netlify: drag the project folder to app.netlify.com → Deploy
   - Vercel: import from GitHub or drag folder
4. Ask user to paste the live URL once deployed.
5. PM confirms: `✅ 网站已上线，访问地址：[URL]`

### Type 3 / Type 4 × Target B (本地容器)

1. Generate `Dockerfile` (Python-slim or Node-alpine base, installs dependencies from requirements.txt or package.json).
2. Generate `docker-compose.yml` (service definition, port mapping, SQLite volume mount, environment variables).
3. Save both to `project_docs/YYYY-MM-DD-[slug]/` and instruct user to copy to project root.
4. Startup command: `docker compose up --build`
5. Ask user to confirm `http://localhost:[PORT]` is accessible.
6. PM confirms: `✅ 应用已在本地运行，访问：http://localhost:[PORT]`

Docker Compose rules:
- SQLite data file mounted as a named volume — data survives container restarts
- Port number explicitly set and referenced in PM report
- Health check endpoint documented (`/health` or `/api/ping`)

### Type 3 / Type 4 × Target C (服务器)

1. Generate `docker-compose.yml` (same as Target B).
2. Save to `project_docs/YYYY-MM-DD-[slug]/`.
3. Provide the list of commands the user must run on the target server.
4. User runs commands and reports the result back.
5. PM confirms success or diagnoses failure based on user's report.

**Gate 5 close condition:** User explicitly confirms the deployed product is accessible and working. PM does not close the workflow on the user's behalf.

---

## Document outputs

| Artifact | Template | Output path | Required before |
|---|---|---|---|
| Product definition (Sections 1–5) | `.ai/templates/product_define.md` | `project_docs/YYYY-MM-DD-[slug]/product_define.md` | Phase 1 report |
| Product definition (Sections 6–9) | `.ai/templates/product_define.md` | same file, updated | Phase 2 report |
| Requirements | `.ai/templates/requirements.md` | `project_docs/YYYY-MM-DD-[slug]/requirements.md` | Phase 2 report |
| Technical architecture | `.ai/templates/architecture.md` | `project_docs/YYYY-MM-DD-[slug]/architecture.md` | Phase 2.5 report |
| Development plan | `.ai/templates/dev_plan.md` | `project_docs/YYYY-MM-DD-[slug]/dev_plan.md` | Phase 3 report |
| Test plan | `.ai/templates/test_plan.md` | `project_docs/YYYY-MM-DD-[slug]/test_plan.md` | Phase 5 test write |
| Deployment artifacts | — | `project_docs/YYYY-MM-DD-[slug]/` (copy to project root) | Gate 5 |
| Work-item | `.ai/memory/active/work-items/TEMPLATE.md` | `.ai/memory/active/work-items/[id]-[name].md` | — |
| Task log | `.ai/memory/task-log/TEMPLATE.md` | `.ai/memory/task-log/YYYY-MM-DD-[slug].md` | — |

`[slug]` = short product name, e.g. `customer-demo`, `api-service`. Same slug for the directory and the task log.

---

## Memory writes

- Add work-item in `current-state.yaml` at Phase 0
- Update work-item stage at each phase boundary
- Write task log at Gate 5 close
- Update `DASHBOARD.md` at Gate 5 close

## Done criteria

- Phase 0 intake questions were answered before any work began
- All phases were executed in order
- Each Phase Report was presented before advancing
- Tech stack guard was applied in Phase 2.5
- No code was written before Phase 3 report was acknowledged
- All automated tests pass
- Manual test checklist exists and was handed to user
- Gate 5 confirmed by user on a working deployed product
- Memory and dashboard are current
