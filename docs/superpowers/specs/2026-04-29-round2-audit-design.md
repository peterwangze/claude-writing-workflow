# 写作工作流插件第二轮审查与修复设计

## 目标

第二轮审查聚焦第一轮未深入覆盖的 Skill（运营链、辅助工具、主入口）和跨阶段集成问题（状态传递、目录创建、数据消费）。

## 发现的问题

### P0 严重问题（5 项）

| # | 问题 | 位置 |
|---|------|------|
| DF-2 | workflow-state.json 被逐阶段完整替换，导致 statistics/guardrails 被丢弃 | using-writing-workflow + 所有阶段示例 |
| WS-1 | work-type-selection 初始状态缺少 guardrails 对象 | work-type-selection/SKILL.md:147-191 |
| DF-1 | 11-data-monitoring/ 12-reader-interaction/ 13-creation-logs/ 三个目录从未创建 | work-type-selection + using-writing-workflow 目录初始化 |
| IC-1 | creation-planning 与 launch-strategy 存稿数据严重冲突（番茄: 5w vs 15-20w） | creation-planning/SKILL.md + launch-strategy/SKILL.md |
| IC-3 | competitor-analysis 输出未被 genre-selection 消费 | genre-selection/SKILL.md + competitor-analysis/SKILL.md |

### P1 中等问题（5 项）

| # | 问题 | 位置 |
|---|------|------|
| WS-3 | launch-strategy/monetization-strategy 不回写 workflow-state | launch-strategy + monetization-strategy |
| UG-1/2 | data-monitoring/reader-interaction 缺少 AskUserQuestion | data-monitoring + reader-interaction |
| UG-3 | opening-optimization 评分后无用户确认 | opening-optimization |
| UG-5 | WebSearch 搜索失败降级选项不一致 | 5 个 Skill |
| IC-2 | data-monitoring 报告模板重复 | data-monitoring |

### P2 低优先级（6 项）

| # | 问题 | 位置 |
|---|------|------|
| WS-2 | data-monitoring/reader-interaction 不触碰 workflow-state | data-monitoring + reader-interaction |
| WS-4 | opening-optimization/novel-style-learning 不更新状态 | opening-optimization + novel-style-learning |
| WS-5 | competitor-analysis 输出不记录到 workflow-state.files | competitor-analysis |
| UG-4 | novel-style-learning 无用户交互 | novel-style-learning |
| IC-6 | human-ai-collaboration 路径 B 中 release_allowed = false 重复 | human-ai-collaboration |
| IC-4 | 目录编号与执行顺序不匹配（已知，记录即可） | 文档 |

## 修复策略

### 核心设计决策：字段级增量更新替代完整 JSON 模板

**问题**：当前每个阶段展示完整 JSON 模板作为状态更新示例，但各模板省略了不同字段（statistics、guardrails、files.*），执行时会覆盖丢失。

**修复**：将各阶段的 JSON 示例改为字段级增量更新列表格式：

```
更新 workflow-state.json（增量，保留已有字段）：
- completed_stages: 追加 "阶段ID"
- current_stage: 设为 "下一阶段ID"
- project_info.[字段]: 更新值
- files.[文件]: 设为路径
- statistics.last_updated: 更新为当前时间戳
- statistics.total_words: 如有变化则更新
```

### 文件变更清单

| 文件 | 修改内容 |
|------|---------|
| using-writing-workflow/SKILL.md | 状态更新规范改为增量模式；补全目录创建 |
| work-type-selection/SKILL.md | 初始状态加 guardrails；状态更新改为增量模式；补全目录创建 |
| creation-planning/SKILL.md | 存稿数字对齐；状态更新改为增量模式 |
| launch-strategy/SKILL.md | 状态更新改为增量模式；补充状态写入步骤 |
| monetization-strategy/SKILL.md | 状态更新改为增量模式；补充状态写入步骤 |
| genre-selection/SKILL.md | 加载 competitor-analysis 输出；状态更新改为增量模式 |
| competitor-analysis/SKILL.md | 状态更新改为增量模式；统一搜索失败处理 |
| data-monitoring/SKILL.md | 补全 AskUserQuestion；合并重复模板；加状态记录 |
| reader-interaction/SKILL.md | 补全 AskUserQuestion；加状态记录 |
| opening-optimization/SKILL.md | 加用户确认步骤；加状态更新 |
| novel-style-learning/SKILL.md | 加学习完成交互；加状态更新 |
| human-ai-collaboration/SKILL.md | 删除重复 release_allowed 赋值 |
