# 决策日志 — Decision Log

## 记录格式

每条决策：`DEC-{NNN} | {日期} | {标题} | {状态} | {摘要} | {理由} | {后果}`

状态：proposed / accepted / rejected / superseded

---

## 决策记录

| 决策 ID | 日期 | 标题 | 状态 | 摘要 | 理由 | 后果 |
|---------|------|------|------|------|------|------|
| DEC-001 | 2026-05-30 | 治理系统半途接入声明 | accepted | 对现有 writing-workflow v4.0.0 项目启用 software-project-governance 治理系统。profile=lightweight, trigger_mode=always-on, permission_mode=maximum-autonomy。当前阶段设为 G6(开发)，前置 Gate G1-G5 标记为 passed-on-entry | 项目已有 103 commits、CHANGELOG、成熟架构，从开发阶段接入是合理的 | 治理系统从此刻起记录所有后续变更 |
| DEC-002 | 2026-05-30 | 阶段调整：维护→开发 | accepted | 用户将 Coordinator 推断的维护(11/11)调整为开发(6/11) | 用户认为项目核心功能仍在构建中，开发阶段更准确反映当前状态 | 当前 Gate 设为 G6(开发) |

---

## 待确认决策

（无）
