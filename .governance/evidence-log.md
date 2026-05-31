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
| EVD-015 | 2026-05-31 | TSK-019 | review-report | Code Reviewer 审查 REQ-001 七猫检查项增强: APPROVED——2 SKILL 变更一致、7项检查与 content-generation 对齐、无幻觉数据、无回归风险。4 P2建议(creation-planning旧描述/三处重复/质量审查摘要缺3项/缺验证用例)。审查报告: .governance/review-TSK-019.md | plan-tracker.md TSK-019 |

---

## 待补录

（无）
