# CLAUDE.md — Claude Writing Workflow Plugin

## 项目概要

面向平台投稿的写作辅助工作流插件 — 以人类原创为主体，AI 提供有限辅助。覆盖市场调研、选题策划、大纲生成、写作辅助、质量审查、上架准备和数据监控全流程。

## 治理系统

本项目使用 software-project-governance 治理系统。

### 关键路径

- 治理记录: `.governance/` (plan-tracker / evidence-log / decision-log / risk-log)
- 插件源码: `writing-workflow/` (skills/ / agents/ / hooks/ / commands/)
- 治理配置: profile=lightweight, trigger_mode=always-on, permission_mode=maximum-autonomy
- 当前阶段: G6 — 开发实现

### 干活动作

每次 session:
- 读取 `.governance/plan-tracker.md` 了解当前状态
- 修改产品代码前确认任务已在 plan-tracker 中记录
- 完成后更新 plan-tracker 状态并记录证据到 evidence-log

### 收工纪律

- 完成的任务 → plan-tracker 标记 completed
- 重要决策 → decision-log 新增记录
- 发现风险 → risk-log 新增/更新记录

## 技术架构

- 平台: Claude Code Plugin
- 架构: Agent Team — 创作者与审查者绝对分离
- 技能: 25 个 SKILL (18 个生产 + 审查分离)
- Agent: 16 个专业 Agent (5 团队)
- 质量体系: 9 维质量审查 + 6 独立审查 Agent 并行

## 测试

- 集成验证项目: `test-novel-project/`
- 无单元测试套件
- 验证方式: 在 test-novel-project 上完整运行工作流
