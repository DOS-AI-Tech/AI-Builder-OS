# Product Definition: [Product Name]

<!--
TRIGGER:    new-product workflow, Phases 1–2
SAVE AS:    project_docs/YYYY-MM-DD-[slug]/product_define.md
UPDATED BY: AI at each planning stage; human confirms before advancing

FIELD GUIDE
  [AI]       AI generates from available context — no user input needed
  [USER]     AI asks user, waits for answer before continuing
  [AI+USER]  AI drafts, user confirms or edits
  [GATE]     Human decision required — AI does not advance until confirmed
-->

---

## 1. Business Opportunity

<!-- [USER] Paste or describe the original input: client brief, meeting notes, idea, market observation. Raw text is fine. -->


---

## 1.5. Website Style & Design

<!--
[CONDITIONAL] Only fill this section if the product is a website or web app.
[AI+USER] AI detects website type from Section 1 and presents the options below.
          User picks one option per dimension, or writes a custom description.
          Result is locked before Gate 1 — do not advance without this section filled.
-->

> **AI 提示用户时的说话方式：**
> "我注意到你要做的是一个网站。在开始规划功能之前，我想先了解一下你希望网站**看起来是什么感觉、给人什么印象**。
> 请从下面两个问题各选一个最接近的选项，或者用自己的话描述也完全可以。"

---

### 网站用途（这个网站主要用来做什么？）

从下面选一个，或自由描述：

| 选项 | 简单说就是 |
|------|-----------|
| A — 品牌 / 公司介绍 | 让人了解我是谁、做什么、为什么选我 |
| B — 产品展示 | 把商品或服务摆出来给人看（不一定要在线买） |
| C — 落地页 / 推广页 | 一页搞定，吸引访客留下联系方式或下单 |
| D — SaaS / 软件产品页 | 介绍一款软件或应用，引导用户注册试用 |
| E — 个人作品集 | 展示我的项目、设计、摄影等个人成果 |
| F — 电商 / 在线购买 | 访客可以直接在网站上浏览商品并付款 |
| G — 内容 / 博客 | 以文章、视频、资讯为主，持续更新内容 |
| H — 社区 / 论坛 | 用户之间可以互动、发帖、讨论 |

**用户选择 / 描述：**

---

### 视觉风格（你希望访客打开网站后的第一感觉是？）

从下面选一个，或自由描述：

| 选项 | 简单说就是 | 典型代表 |
|------|-----------|---------|
| 1 — 简洁大方 | 大量留白，字体清晰，没有多余装饰 | Apple 官网、Notion |
| 2 — 科技酷炫（深色） | 深色背景，光效和渐变，有种未来感 | Linear、Vercel |
| 3 — 温暖亲切 | 柔和的颜色，圆角，看着很放松 | Mailchimp、Loom |
| 4 — 专业稳重 | 结构清晰，颜色保守，给人信任感 | McKinsey、大型银行网站 |
| 5 — 大胆创意 | 色彩强烈，排版不走寻常路，有记忆点 | Awwwards 上的获奖作品 |
| 6 — 玻璃质感 | 半透明卡片、模糊背景，有点高级感 | iOS 风格界面 |
| 7 — 鲜艳渐变 | 用大面积渐变色，活泼、现代 | Stripe、Figma |
| 8 — 插画风 | 用手绘或矢量插画代替照片，有温度 | Headspace、Duolingo |

**用户选择 / 描述：**

---

**⬛ Section 1.5 完成确认**
- [ ] 网站用途已确定
- [ ] 视觉风格已确定
- [ ] （如有参考网站，已记录在上方）

---

## 2. Target Customer

<!-- [AI+USER] AI extracts from Section 1. User corrects if wrong. -->

**Who:** 

**Current situation:** 

**Why existing solutions fall short:** 

---

## 3. Problem Statement

<!-- [AI+USER] AI distills the core problem in 1–3 sentences. User confirms. -->


---

## 4. Solution Hypothesis

<!-- [AI+USER] What we believe will solve the problem. Not a spec — a hypothesis. -->


---

## 5. Open Questions Before Planning

<!-- [AI] AI lists what is still missing or ambiguous. User must answer before MVP scope is set. -->

| # | Question | Who answers | Status |
|---|----------|-------------|--------|
| 1 | | User | ☐ |
| 2 | | User | ☐ |

---

<!-- [GATE] Product Direction Gate
     AI stops here. User reviews Sections 1–5, answers open questions, then confirms:
     "Product direction confirmed" before AI continues to MVP scope. -->

**⬛ GATE 1 — Product Direction**
- [ ] Target customer is correct
- [ ] Problem statement is accurate
- [ ] Solution hypothesis is agreed
- [ ] All open questions answered

---

## 6. MVP Scope

<!-- [AI+USER] AI proposes the minimum set of features that validates the core hypothesis.
     User approves each item. Items not approved go to Section 7. -->

### In scope

| Feature | Acceptance criteria | Confirmed |
|---------|-------------------|-----------|
| | | ☐ |

### Explicitly out of scope (deferred)

| Item | Reason deferred |
|------|----------------|
| | |

---

<!-- [GATE] MVP Scope Gate -->

**⬛ GATE 2 — MVP Scope**
- [ ] In-scope features confirmed
- [ ] Out-of-scope items explicitly listed
- [ ] Acceptance criteria agreed

---

## 7. Technical Constraints

<!-- [USER] Existing tech stack, infrastructure limits, third-party dependencies, security requirements. -->


---

## 8. Success Criteria

<!-- [AI+USER] How will we know the MVP succeeded? Concrete, observable. -->

| Criterion | Measurement method |
|-----------|-------------------|
| | |

---

## 9. Risks and Assumptions

<!-- [AI] AI identifies what must be true for this plan to hold. -->

| Risk / Assumption | Impact if wrong | Mitigation |
|------------------|-----------------|------------|
| | | |

---

## 10. Next Step

<!-- [AI] After Gate 2 is confirmed, AI states the next executable action and which workflow it routes to. -->

Next workflow: `new-product` Phase 2.5
Work-item to create: 
First task: 
