# 写作工作流插件审查与修复设计

## 目标

站在用户角度审视当前项目（作者体验、质量看护、开发者维护三个视角），对发现的问题按优先级归档成实施计划，并按计划修复。

## 审查视角

| 视角 | 检查维度 |
|------|---------|
| 作者体验 | 指引是否清晰易懂、分支决策是否直观、失败处理是否有兜底、跳过/回退是否支持 |
| 质量看护 | 连续性追踪机制是否到位、一致性校验是否充分、逻辑矛盾是否有检测、偏离累积是否有熔断 |
| 开发者维护 | 文件职责是否单一、跨 Skill 接口是否对齐、配置/文档是否一致、硬编码残留 |

## 优先级标准

- **P0 (阻塞性)**：会导致创作产出出现严重质量问题（前后矛盾、设定崩塌）或流程中断无法继续
- **P1 (高风险)**：容易导致使用困惑、产出偏差，但不阻塞流程
- **P2 (体验优化)**：使用不便、文档不清、边界未覆盖等体验类问题

## 审查范围

全量覆盖 18 个 Skill、hooks、agents、插件配置、README、设计文档。

## 审查顺序

1. 入口与编排：using-writing-workflow、workflow-state.json
2. 核心创作链：work-type → platform-research → competitor-analysis → genre-selection → novel-confirmation → creation-planning → outline-writing → chapter-outline → content-generation
3. 质量看护链：human-ai-collaboration → quality-review → opening-optimization → novel-style-learning
4. 运营发布链：launch-strategy → monetization-strategy → data-monitoring → reader-interaction
5. 基础设施：hooks、agents、插件配置、README、设计文档

## 问题归档格式

```
- [P0/P1/P2] <简短标题>
  位置: <文件路径>:<行号范围>
  现象: <具体问题描述>
  影响: <对用户/质量/维护的影响>
  修复方向: <建议修复思路>
```

## 实施与验证

- P0 问题逐一修复，每项检查上下游对齐
- P1 问题批量修复，每批做整体回归
- P2 问题时间允许则修复
- 修复后运行整体验证
