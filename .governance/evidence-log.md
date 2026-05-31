# 证据日志 — Evidence Log

## 记录格式

每条证据：`EVD-{NNN} | {日期} | {任务ID} | {类型} | {摘要} | {文件引用}`

类型：test-result / review-report / gate-check / decision-record / risk-assessment / manual-verification

---

## 证据记录

| 证据 ID | 日期 | 关联任务 | 类型 | 摘要 | 引用 |
|---------|------|----------|------|------|------|
| EVD-001 | 2026-05-30 | — | gate-check | 半途接入——项目已迭代至 v4.0.0，103 commits，前置 Gate (G1-G5) 标记为 passed-on-entry | plan-tracker.md §Gate状态跟踪 |
| EVD-002 | 2026-05-30 | TSK-001 | review-report | Analyst 需求差距分析完成——发现 5 项差距 (G1-G5)、3 项潜在改进 (P1-P3)。高优先级: 七猫平台适配缺失 | plan-tracker.md §需求跟踪矩阵 |
| EVD-003 | 2026-05-30 | TSK-002 | review-report | Requirement Reviewer 审查通过——确认 5 项差距真实，补充：G1更严重(核心SKILL完全缺失)、G3应升P2(明确处置)、README维度滞后 | plan-tracker.md §需求跟踪矩阵 |
| EVD-004 | 2026-05-30 | TSK-004 | review-report | Code Reviewer 审查 TSK-003: NEEDS_CHANGE——P1(chapter-outline-review 缺七猫字数标准)、P2×3(92%数据缺来源、过度实现) | plan-tracker.md TSK-004 |
| EVD-005 | 2026-05-30 | TSK-005 | review-report | Developer 修复 P1+P2——chapter-outline +七猫字数、92%改定性表述、#6引用opening-optimization、#7精简为1句 | commit fc32ba6 |
| EVD-006 | 2026-05-30 | TSK-007 | review-report | Test Reviewer 审查 TSK-006: APPROVED——9/10风险评级准确、Tier-1/2可执行。3项硬门槛缺口属G7范围 | plan-tracker.md TSK-007 |

---

| EVD-007 | 2026-05-31 | TSK-011 | review-report | Analyst 完成 REQ-003 调研报告修复——B1(阅文10平台全覆盖+开放平台API分析+起点图第三方工具)、B2(三种方案时间/错误/延迟/粒度全维度量化对比)、B3(CSV Schema含50+字段、三级验证规则15条、完整错误处理流程)。报告产出: docs/research/02-data-loop-automation-research.md | plan-tracker.md TSK-011 |

---

| EVD-008 | 2026-05-31 | TSK-012 | test-result | Tier-1 Smoke Test 执行完成——7/7 项通过，0 P0 阻塞，5 P1 警告，3 P2 备注。核心创作路径全链路可验证。报告产出: test-novel-project/10-reviews/smoke-test-tier1-report.md | plan-tracker.md TSK-012 |
| EVD-009 | 2026-05-31 | TSK-013 | review-report | Requirement Reviewer 审查 TSK-011 修复: NEEDS_CHANGE——B1/B2通过，B3存在1个阻塞项(retention_rate_3d字段缺失)。审查报告: .governance/review-TSK-013.md | plan-tracker.md TSK-013 |
| EVD-010 | 2026-05-31 | TSK-014 | manual-verification | Developer 修复 CSV Schema——5.2.2通用字段表新增 retention_rate_3d、5.2.3 CSV示例同步、附录A引用一致。修改文件: docs/research/02-data-loop-automation-research.md | plan-tracker.md TSK-014 |
| EVD-011 | 2026-05-31 | TSK-015 | review-report | Test Reviewer 审查 TSK-012 Smoke Test: NEEDS_CHANGE——2个阻塞项(B1: P1-5基于错误事实前提07-content/chapter-003.md不存在、B2: P1计数内部不一致4/5/6)。4/5 P1准确,3 P2准确。审查报告: test-novel-project/10-reviews/smoke-test-tier1-review.md | plan-tracker.md TSK-015 |
| EVD-012 | 2026-05-31 | TSK-016 | test-result | QA 修复 Smoke Test 报告——B1(P1-5重新分类为P2项目状态观察)、B2(P1计数统一为4)。P2数由3→5。报告产出: test-novel-project/10-reviews/smoke-test-tier1-report.md | plan-tracker.md TSK-016 |
| EVD-013 | 2026-05-31 | TSK-017 | review-report | Requirement Reviewer 重新验证 TSK-014: APPROVED——retention_rate_3d正确添加到通用字段表、CSV示例同步(13列一致)、data-monitoring兼容。REQ-003数据闭环调研报告通过全部审查。审查报告: .governance/review-TSK-017.md | plan-tracker.md TSK-017 |
| EVD-014 | 2026-05-31 | TSK-018 | review-report | Test Reviewer 最终验证 TSK-016: APPROVED——B1(P1-5重分类正确)、B2(P1计数统一为4)、报告达可靠Gate check标准。REQ-002 Tier-1 Smoke Test通过。审查报告: test-novel-project/10-reviews/smoke-test-tier1-final-review.md | plan-tracker.md TSK-018 |
| EVD-015 | 2026-05-31 | TSK-019 | review-report | Code Reviewer 审查 REQ-001 七猫检查项增强: APPROVED——2 SKILL 变更一致、7项检查与 content-generation 对齐、无幻觉数据、无回归风险。4 P2建议。审查报告: .governance/review-TSK-019.md | plan-tracker.md TSK-019 |
| EVD-016 | 2026-05-31 | TSK-020 | review-report | Analyst 修复 Smoke P1-1+P1-2: 晋江用户画像更新至2025-2026年数据(注册用户580万→7624万)、七猫AI政策找到官方来源(反洗稿公约签约方)。修改文件: test-novel-project/01-platform-research.md | plan-tracker.md TSK-020 |
| EVD-017 | 2026-05-31 | TSK-021 | manual-verification | Developer 补充创作计划情感签名: 04-creation-plan.md新增84行章节(主情感:智识满足+辅助:紧张悬疑/爽感驱动)、workflow-state.json新增emotional_signature字段。JSON有效+Markdown结构完整 | plan-tracker.md TSK-021 |
| EVD-018 | 2026-05-31 | TSK-022 | manual-verification | Developer 修剪 chapter-002: 字数5060→3015(+7.7%在±30%门禁内)、14/14情节节点保留、章末钩子完整。修改文件: test-novel-project/07-content/chapter-002.md | plan-tracker.md TSK-022 |
| EVD-019 | 2026-05-31 | TSK-023 | review-report | Requirement Reviewer 审查 TSK-020: NEEDS_CHANGE——C1(在线时长75.2分钟未同步)+C2(女性比例93%未同步)，核心P1修复质量好、跨节一致性遗漏。审查报告: .governance/review-TSK-023.md | plan-tracker.md TSK-023 |
| EVD-020 | 2026-05-31 | TSK-024 | review-report | Code Reviewer 审查 TSK-021: APPROVED——所有声明可追溯至03-novel-info.md、JSON有效、零回归。1 P2(SKILL模板缺失emotional_signature字段)+1 P3(辅助情感分类学偏差)。审查报告: Agent inline(未写盘) | plan-tracker.md TSK-024 |
| EVD-021 | 2026-05-31 | TSK-025 | review-report | Code Reviewer 审查 TSK-022: APPROVED——字数3015(+7.7%通过)、情节100%完整、连续性无断裂、风格一致。1 P2(自检报告字数不精确)。审查报告: .governance/review-TSK-025.md | plan-tracker.md TSK-025 |
| EVD-022 | 2026-05-31 | TSK-026 | manual-verification | Developer 修复综合推荐数据不一致: C1(75.2→80分钟)+C2(93%→约91%)与用户画像表同步。Commit: 4577766 | plan-tracker.md TSK-026 |
| EVD-023 | 2026-05-31 | TSK-027 | review-report | Requirement Reviewer 最终验证 TSK-026: APPROVED——C1/C2已修复、旧值零残留、15个跨节数据点全一致。审查报告: .governance/review-TSK-027.md | plan-tracker.md TSK-027 |

---

## 待补录

（无）

---

EVD-016 | 2026-05-31 | TSK-028 | manual-verification | 全量标准化 AskUserQuestion 交互指令：47 个交互点跨 17 个 SKILL 文件添加 ⚠️ 标准格式前缀 + using-writing-workflow 添加 40 个检查点 ID 清单 | commit 72ec7ca, 18 files changed (+175/-39)
EVD-017 | 2026-05-31 | TSK-029 | review-report | Code Review: TSK-028 NEEDS_CHANGE — 1×P0(monetary未闭合代码块) + 4×P1(5文件配对断裂+gate-check不一致+CP-WT-02缺失) | commit 72ec7ca
EVD-018 | 2026-05-31 | TSK-030 | manual-verification | 修复 TSK-029 全部 P0+P1: 7 文件代码块修复 + 10 文件 gate-check 加粗 + CP-WT-02 指令补全 | commit 990f091, 11 files changed
EVD-019 | 2026-05-31 | TSK-031 | review-report | Code Review: TSK-030 APPROVED — 5/5 发现验证通过。新发现 FINDING-006(P1) 预存问题 using-writing-workflow 行1467未闭合代码块 | commit 990f091
