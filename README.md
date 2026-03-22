# Claude Writing Workflow Plugin

> AI辅助小说创作工作流 — 从平台调研到盈利变现的端到端解决方案

一个基于 Claude Code Plugin 系统构建的完整网文创作插件，覆盖从市场调研、选题策划、大纲生成、正文生成，到 AI 合规处理、上架发布、数据监控的全流程。以**盈利为核心目标**，针对各大平台算法进行适配优化。

## 特性

- **全流程覆盖**：18 个 Skill 覆盖创作→发布→运营→变现完整链路
- **盈利导向**：VIP 卡点设计、付费追读优化、变现策略全套方案
- **平台算法适配**：针对番茄（完读率）、起点（付费追读）、晋江（积分/收藏）差异化写法
- **AI 合规保护**：系统性人机协作流程 + 创作日志，规避平台 AI 检测下架风险
- **基于实时数据**：WebSearch 驱动的市场调研，不捏造数据
- **多维质量审查**：架构/节奏/人物/文风/AI 痕迹多角色审查
- **数据→内容闭环**：发布后数据异常自动触发内容优化建议
- **断点续传**：工作流状态持久化，随时保存/恢复创作进度
- **全程用户确认**：所有关键决策必须用户确认，不擅作主张

## 支持的平台

| 平台 | 核心指标 | 算法适配 |
|------|----------|----------|
| 番茄小说 | 完读率、吸量 | 前300字冲突、每800字悬念、短章节 |
| 起点中文网 | 付费追读 | VIP回报感、沉浸点、周二质量峰值 |
| 晋江文学城 | 积分/收藏 | 情感细腻、人设优先、评论引导 |
| 七猫小说 | 阅读时长 | 通俗易懂、情节密集 |

## 安装

### 前置条件

- [Claude Code](https://claude.ai/claude-code) CLI 已安装
- Claude Code Plugin 功能已启用

### 安装步骤

```bash
# 1. 克隆此仓库
git clone git@github.com:peterwangze/claude-writing-workflow.git
cd claude-writing-workflow

# 2. 在 Claude Code 中安装插件（从仓库目录执行）
/plugin add ./writing-workflow
```

安装完成后，下次启动 Claude Code 时会看到：
```
Writing Workflow Plugin loaded. Use 'writing-workflow' skill to start.
```

## 快速开始

在 Claude Code 中，告诉 Claude：

```
开始小说创作工作流
```

或者：

```
请使用 writing-workflow skill 帮我创作小说
```

Claude 会自动进入工作流，检查现有进度或初始化新项目。

## 工作流阶段

### 核心创作流程（共11步）

```
作品类型选择 → 平台调研 → 竞品分析 → 题材选择 → 作品确认
      ↓
创作规划 → 大纲生成 → 章节细纲 → 正文生成 → AI合规处理 → 质量审查
```

| # | 阶段 | Skill | 核心产出 |
|---|------|-------|----------|
| 0 | 作品类型选择 | `work-type-selection` | 长/中/短篇选择 + 约束设定 |
| 1 | 平台调研 | `platform-research` | 平台对比报告 + 推荐平台 |
| 1.5 | 竞品深度分析 | `competitor-analysis` | 头部作品拆解 + 差异化方向 |
| 2 | 题材选择 | `genre-selection` | 红海/蓝海分析 + 推荐题材 |
| 3 | 作品确认 | `novel-confirmation` | 5个方案 → 选定书名/简介 |
| 4 | 创作规划 | `creation-planning` | 篇幅/频率/节奏规划 |
| 5 | 大纲生成 | `outline-writing` | 世界观/人物/情节大纲 |
| 6 | 章节细纲 | `chapter-outline` | 逐章场景/情节/伏笔 |
| 7 | 正文生成 | `content-generation` | 平台算法适配正文 |
| 7.5 | AI合规处理 | `human-ai-collaboration` | 去AI痕迹 + 创作日志 |
| 8 | 质量审查 | `quality-review` | 多维审查报告 |

### 盈利运营流程（共4步）

| # | 阶段 | Skill | 核心产出 |
|---|------|-------|----------|
| 9 | 上架发布策略 | `launch-strategy` | 存稿计划 + 签约指导 + 首秀准备 |
| 10 | 变现策略 | `monetization-strategy` | VIP卡点 + 全勤收益 + 收益预测 |
| 11 | 数据监控 | `data-monitoring` | 数据周报 + 内容优化闭环 |
| 12 | 读者互动 | `reader-interaction` | 评论运营 + 粉丝管理 |

### 辅助工具

| Skill | 触发时机 | 用途 |
|-------|----------|------|
| `opening-optimization` | 前三章生成后 | 黄金三章专项优化 |
| `novel-style-learning` | 任意阶段 | 网文写作方法论学习 |

## 创作项目文件结构

工作流执行过程中会在工作目录下生成 `novel-project/` 文件夹：

```
novel-project/
├── workflow-state.json         # 工作流状态（自动维护）
├── 00-work-type.md             # 作品类型信息
├── 01-platform-research.md     # 平台调研报告
├── 02-genre-analysis.md        # 题材分析报告
├── 03-novel-info.md            # 作品信息（书名/简介等）
├── 04-creation-plan.md         # 创作规划（篇幅/频率等）
├── 05-outline.md               # 完整大纲
├── 06-chapter-outlines/        # 章节细纲（每章一文件）
│   ├── chapter-001.md
│   └── chapter-002.md
├── 07-content/                 # 正文内容（每章一文件）
│   ├── chapter-001.md
│   └── chapter-002.md
├── 08-characters/              # 人物设定
│   ├── main-characters.md
│   ├── supporting-characters.md
│   └── character-relationships.md
├── 09-worldbuilding/           # 世界观设定
│   ├── world-settings.md
│   └── power-system.md
├── 10-reviews/                 # 质量审查报告
├── 11-data-monitoring/         # 数据监控周报（发布后）
├── 12-reader-interaction/      # 读者互动记录（发布后）
├── 13-creation-logs/           # AI合规创作日志
├── 14-launch-strategy.md       # 上架发布策略
├── 15-monetization-strategy.md # 变现策略
└── 16-competitor-analysis.md   # 竞品分析报告
```

> `novel-project/` 目录已在 `.gitignore` 中排除，用户创作内容不会被提交到版本库。

## 插件结构

```
writing-workflow/
├── .claude-plugin/
│   ├── plugin.json             # 插件元数据
│   └── marketplace.json        # 市场配置
├── skills/                     # 18个工作流 Skill
│   ├── using-writing-workflow/ # 主入口（工作流协调器）
│   ├── work-type-selection/
│   ├── platform-research/
│   ├── competitor-analysis/
│   ├── genre-selection/
│   ├── novel-confirmation/
│   ├── creation-planning/
│   ├── outline-writing/
│   ├── chapter-outline/
│   ├── content-generation/
│   ├── human-ai-collaboration/
│   ├── quality-review/
│   ├── launch-strategy/
│   ├── monetization-strategy/
│   ├── opening-optimization/
│   ├── novel-style-learning/
│   ├── data-monitoring/
│   └── reader-interaction/
├── agents/
│   └── novel-creator.md        # 子 Agent 配置（并行任务）
├── hooks/
│   ├── hooks.json              # SessionStart Hook 配置
│   └── run-hook.cmd            # Windows Hook 脚本
└── README.md                   # 插件说明文档
```

## 常见问题

**Q: 如何继续上次未完成的创作？**

直接告诉 Claude "继续小说创作工作流"，系统会自动加载 `novel-project/workflow-state.json` 中的进度。

**Q: 可以跳过某个阶段吗？**

可以。工作流支持阶段跳转，在每个阶段完成后的确认界面中选择"跳到指定阶段"。非关键阶段（如竞品分析、风格学习）可以跳过。

**Q: 如何管理多个创作项目？**

目前每个工作目录管理一个项目。不同项目建议在不同目录下运行 Claude Code，各自维护独立的 `novel-project/` 文件夹。

**Q: 平台 AI 检测会影响我吗？**

本插件内置了完整的 `human-ai-collaboration` 合规流程，包括系统性去 AI 痕迹改写和创作日志生成。但最终是否通过平台审核取决于平台政策，建议在发布前仔细检查。

**Q: 数据监控需要接入 API 吗？**

不需要。`data-monitoring` skill 使用 WebSearch 搜索公开数据，并提供模板让用户手动填入后台数据。系统根据你填入的数据进行分析和优化建议。

## 版本历史

### v1.0.0
- 18 个完整 Skill 覆盖创作全链路
- 平台算法适配写法（番茄/起点/晋江）
- AI 合规人机协作流程
- 上架发布 + 变现策略体系
- 数据→内容闭环机制
- 竞品深度分析

## License

MIT
