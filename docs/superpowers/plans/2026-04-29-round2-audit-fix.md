# Round 2 Plugin Audit Fix Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan.

**Goal:** 修复第二轮审查发现的 16 个问题（P0x5 + P1x5 + P2x6），核心是统一状态更新为增量模式、补齐目录创建、对齐存稿数据、补全用户交互。

**Architecture:** 分 3 个 Chunk 执行 —— Chunk 1: 基础修复（目录+状态模式+存稿对齐），Chunk 2: 状态补全（各阶段状态更新），Chunk 3: 交互补全（AskUserQuestion+模板去重）。

**Tech Stack:** Markdown SKILL.md 编辑。

---

## Chunk 1: P0 基础修复（using-writing-workflow、work-type-selection、creation-planning、genre-selection）

### Task 1: 修正 using-writing-workflow 的状态更新规范 + 目录创建

**Files:** Modify: `writing-workflow/skills/using-writing-workflow/SKILL.md:260-276`

- [ ] Step 1: 将"状态更新"部分从完整 JSON 示例改为增量更新说明
- [ ] Step 2: mkdir 命令补上三个缺失目录

### Task 2: 修正 work-type-selection 初始状态 + 状态更新

**Files:** Modify: `writing-workflow/skills/work-type-selection/SKILL.md:137-191`

- [ ] Step 1: 添加 guardrails 到初始状态模板
- [ ] Step 2: 状态 JSON 模板改为增量更新格式
- [ ] Step 3: mkdir 命令补上缺失目录

### Task 3: 对齐 creation-planning 存稿数据

**Files:** Modify: `writing-workflow/skills/creation-planning/SKILL.md:280-301`

- [ ] Step 1: 存稿数字与 launch-strategy 对齐
- [ ] Step 2: 状态更新改为增量格式

### Task 4: genre-selection 消费 competitor-analysis 输出

**Files:** Modify: `writing-workflow/skills/genre-selection/SKILL.md:28-56`

- [ ] Step 1: 加载平台信息后检查 16-competitor-analysis.md
- [ ] Step 2: 状态更新改为增量格式

---

## Chunk 2: P1 状态补全（launch-strategy、monetization-strategy、competitor-analysis、data-monitoring、reader-interaction、opening-optimization、novel-style-learning）

### Task 5: launch-strategy + monetization-strategy 补充状态更新

**Files:** Modify: `launch-strategy/SKILL.md` + `monetization-strategy/SKILL.md`

### Task 6: data-monitoring + reader-interaction 补全 AskUserQuestion

**Files:** Modify: `data-monitoring/SKILL.md` + `reader-interaction/SKILL.md`

### Task 7: opening-optimization + novel-style-learning 补充用户交互和状态

**Files:** Modify: `opening-optimization/SKILL.md` + `novel-style-learning/SKILL.md`

### Task 8: 统一 WebSearch 搜索失败降级选项

**Files:** Modify: `competitor-analysis/SKILL.md` + `genre-selection/SKILL.md` + `monetization-strategy/SKILL.md`

---

## Chunk 3: P2 收尾（模板去重、冗余清理、状态补充）

### Task 9: data-monitoring 合并重复报告模板

**Files:** Modify: `data-monitoring/SKILL.md`

### Task 10: competitor-analysis 状态记录 + human-ai-collaboration 去重

**Files:** Modify: `competitor-analysis/SKILL.md` + `human-ai-collaboration/SKILL.md`
