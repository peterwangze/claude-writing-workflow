# Writing Workflow Plugin

面向平台投稿的写作辅助工作流插件。以人类原创为主体，AI 提供研究、灵感、校对等有限辅助。

> 详细安装说明请参见 [项目根目录 README](../README.md)。

---

## 安装

> ⚠️ 以下 `/plugin` 命令均在 **Claude Code 对话框**中输入，不是在终端执行。

**方式一：Marketplace 安装（推荐）**

```
/plugin marketplace add https://raw.githubusercontent.com/peterwangze/claude-writing-workflow/main/writing-workflow/.claude-plugin/marketplace.json
```
```
/plugin install writing-workflow
```

**方式二：本地安装**

克隆仓库后，在 Claude Code 对话框中执行：
```
/plugin add /你的路径/claude-writing-workflow/writing-workflow
```

---

## 使用说明

### 工作目录

插件在 Claude Code 的**当前工作目录**下创建 `novel-project/` 文件夹。**建议为每部小说创建独立目录**，切换到该目录后再启动 Claude Code。

### 启动工作流

在 Claude Code 对话框中输入：

```
开始小说创作工作流
```

系统自动检测当前目录的进度：新项目从头开始，已有项目从上次进度继续。

### Skill 协调机制

本插件包含 18 个 Skill，**用户只需触发主入口 `using-writing-workflow`，无需手动调用其他 Skill**。主 Skill 会根据工作流状态自动调度对应阶段的 Skill。

```
用户："开始小说创作工作流"
        ↓
using-writing-workflow（主协调器）
        ↓ 自动调度
work-type-selection → platform-research → competitor-analysis → ...
```

### 交互示例

```
用户：开始小说创作工作流

Claude：欢迎使用小说创作工作流！
        检测到当前目录：~/novels/my-novel
        未找到已有项目，正在初始化新项目...

        【阶段 0/12】作品类型选择

        请选择您的作品类型：
        ① 长篇小说（50万字以上）— 推荐番茄/起点
        ② 中篇小说（10-50万字）  — 推荐晋江
        ③ 短篇小说（3-10万字）
        ④ 小故事/短篇集（3万字以下）

用户：① 长篇小说

Claude：[执行 WebSearch 获取当前市场数据...]
        [生成 novel-project/00-work-type.md]

        作品类型已确认：长篇小说

        下一步：平台调研
        继续？（是/否/退出）
```

---

## 工作流阶段详解

### 核心创作流程

#### 阶段 0：作品类型选择

**输出**：`novel-project/00-work-type.md`

选择适合的作品类型（长篇/中篇/短篇），系统根据选择调整后续所有阶段的推荐逻辑。

---

#### 阶段 1：平台调研

**输出**：`novel-project/01-platform-research.md`

使用 WebSearch 实时搜索各平台数据，分析热门题材、签约政策、盈利模式，给出平台推荐。

支持平台：番茄小说、起点中文网、晋江文学城、七猫小说

---

#### 阶段 1.5：竞品深度分析

**输出**：`novel-project/16-competitor-analysis.md`

拆解同赛道头部作品：开篇结构、爽点节奏、人设模型、差异化突破口。

---

#### 阶段 2：题材选择

**输出**：`novel-project/02-genre-analysis.md`

结合平台调研和竞品分析，推荐红海/蓝海题材，用户确认创作方向。

---

#### 阶段 3：作品确认

**输出**：`novel-project/03-novel-info.md`

生成 5 个完整作品方案（书名 + 一句话简介 + 300字详介 + 封面提示词），用户选择后确定主选方案。

---

#### 阶段 4：创作规划

**输出**：`novel-project/04-creation-plan.md`

制定字数目标、发布频率、存稿计划、卷数划分。

---

#### 阶段 5：大纲生成

**输出**：
- `novel-project/05-outline.md`
- `novel-project/08-characters/`（主角/配角/关系图）
- `novel-project/09-worldbuilding/`（世界观/力量体系）

生成后建议调用质量审查（架构/节奏/用户画像三角色审查）。

---

#### 阶段 6：章节细纲

**输出**：`novel-project/06-chapter-outlines/chapter-XXX.md`

逐章生成细纲（概要/场景/情节四要素/伏笔），分批确认后继续。

---

#### 阶段 7：正文生成

**输出**：`novel-project/07-content/chapter-XXX.md`

按平台算法适配写法生成正文：

| 平台 | 核心写法 |
|------|---------|
| **番茄** | 前300字冲突、每800字悬念、2000-2500字/章、章末强钩子 |
| **起点** | VIP章即时回报、20秒沉浸点、每章"值回票价"场景 |
| **晋江** | 情感有层次、人设优先、章末引发评论 |

前三章完成后建议调用 `opening-optimization` 进行黄金三章专项优化。

---

#### 阶段 7.5：AI 合规处理

**输出**：`novel-project/13-creation-logs/`

> ⚠️ 各平台 AI 政策持续变化。番茄/七猫已上线官方 AI 辅助工具但打击大篇幅 AI 低质内容；晋江对叙事级 AI 代写限制最严；起点具体阈值请投稿前重新核验。

AI 参与度分级评估 + 路径分流：
- **平台安全路径**（AI 仅做校对/灵感/粗纲辅助）→ 可正常进入上架发布
- **灰区路径**（AI 参与部分初稿）→ 提示仅适合练习/自发平台，不建议直接签约投稿
- **高风险路径**（AI 生成完整正文）→ 阻断上架发布和变现策略

同时生成证据链留存包（人工原稿、AI 对话记录、修改对照、投稿前确认声明）。

---

#### 阶段 8：质量审查

**输出**：`novel-project/10-reviews/quality-reports/`

| 阶段 | 审查角色 | 审查内容 |
|------|----------|----------|
| 大纲 | 架构/节奏/用户画像审查员 | 世界观逻辑、爽点分布、受众匹配 |
| 细纲 | 情节/连贯性审查员 | 与大纲一致、章节连贯 |
| 正文 | 人物/文风/AI痕迹审查员 | 人设一致、平台适配、去AI痕迹 |

---

### 盈利运营流程

#### 阶段 9：上架发布策略

**输出**：`novel-project/14-launch-strategy.md`

存稿计算（各平台建议 10-30 章）、签约流程、最优发布时机、首秀策略。

---

#### 阶段 10：变现策略

**输出**：`novel-project/15-monetization-strategy.md`

VIP 上架时机、付费卡点设计、全勤奖规划、打赏激励、收益预测、IP 衍生规划。

---

#### 阶段 11：数据监控

**输出**：`novel-project/11-data-monitoring/weekly-report-YYYY-MM-DD.md`

监控完读率/留存率/追读趋势，数据异常时由 Claude 遵循工作流规范建议触发优化：

| 信号 | 阈值 | 工作流建议行为 |
|------|------|----------------|
| 完读率低 | 10万字 <10% | 建议触发前3章重审 |
| 章节流失 | 某章读完率 <30% | 章节诊断+重写建议 |
| 追读下降 | 连续3天 >10% | 节奏/爽点分析 |
| 收藏停滞 | 日增 <10（连续7天）| 书名/简介优化 |

> 注：以上触发行为依赖 Claude 在对话中识别数据异常并遵循 Skill 规范执行，非后台自动脚本。

---

#### 阶段 12：读者互动

**输出**：`novel-project/12-reader-interaction/`

评论分类回复策略（催更/提问/差评）、粉丝运营、危机公关。

---

### 辅助工具

**开篇优化**（`opening-optimization`）：前三章完成后建议触发，也可手动触发。首句钩子检测、三章节奏审查、平台差异化优化。

**网文风格学习**（`novel-style-learning`）：任意阶段可调用。爽文结构公式、各类型套路、书名/简介写作技巧。

---

## 生成的文件结构

```
novel-project/
├── workflow-state.json         # 工作流状态（由 Claude 遵循规范更新）
├── 00-work-type.md
├── 01-platform-research.md
├── 02-genre-analysis.md
├── 03-novel-info.md
├── 04-creation-plan.md
├── 05-outline.md
├── 06-chapter-outlines/        # 章节细纲
├── 07-content/                 # 正文
├── 08-characters/              # 人物设定
├── 09-worldbuilding/           # 世界观设定
├── 10-reviews/                 # 质量审查报告
├── 11-data-monitoring/         # 数据监控（发布后）
├── 12-reader-interaction/      # 读者互动（发布后）
├── 13-creation-logs/           # AI合规创作日志
├── 14-launch-strategy.md
├── 15-monetization-strategy.md
└── 16-competitor-analysis.md
```

> `novel-project/` 已加入 `.gitignore`，创作内容仅保存在本地。

---

## 能力范围说明

本插件的能力分为两类：

### 插件层已实现能力

| 能力 | 实现方式 |
|------|----------|
| 会话启动提示 | `SessionStart` Hook 自动执行，打印插件加载提示 |
| Skill 路由 | Claude Code 根据关键词匹配自动调用对应 SKILL.md |
| 状态文件创建 | Claude 遵循 SKILL.md 模板创建和更新 `workflow-state.json` |

### 依赖 Claude 遵循 Skill 规范执行的能力

以下能力依赖 Claude 在对话过程中识别上下文并遵循 SKILL.md 约定，**不是后台脚本或自动化程序**：

- 检测已有项目进度并续写
- 每章正文生成后触发质量审查
- 数据异常时建议触发内容优化
- 子 Agent 失败后的恢复处理
- 各阶段自动质量审查建议

---

## 环境前提

安装前请确认您的 Claude Code 环境支持以下能力：

| 依赖 | 说明 |
|------|------|
| **WebSearch** | 必须。用于获取实时市场数据、热门题材信息。无此能力时，市场分析阶段无法执行 |
| **结构化选项确认** | 必须。用于阶段交互（AskUserQuestion 类工具）。无此能力时交互体验降级 |
| **Plugin 系统** | 必须。需要 Claude Code 支持 `/plugin` 命令 |
| **pua Skill**（可选）| 若已安装 superpowers 插件，可用于失败重试强化。未安装时主流程忽略此分支 |

---

## 已知限制

| 限制项 | 说明 |
|--------|------|
| 短篇路径 | 已支持跳过平台调研直接进入题材选择，工作流约定层面可用 |
| "自动化"行为 | 大多数"自动触发"描述是工作流约定，依赖 Claude 遵循规范，非脚本自动化 |
| 数据监控与异常闭环 | 工作流规范定义，非后台定时任务或数据接口集成 |
| 长篇路径端到端 | 当前 demo 验证了短篇路径；长篇完整路径（含平台调研、竞品分析）未经端到端 smoke test |
| pua Skill 依赖 | 若未安装 superpowers 插件，失败重试增强分支不可用 |

---

## 分支路径说明

### 长篇/中篇标准路径

```
作品类型选择 → 平台调研 → 竞品分析 → 题材选择 → 作品确认 → 创作规划 → ...
```

所有阶段均执行，需要 WebSearch 和平台数据支持。

### 短篇/小故事路径

```
作品类型选择 → [跳过平台调研] → 题材选择 → 作品确认 → 创作规划 → ...
```

选择"短篇小说"或"小故事/短篇集"后，系统提示跳过平台调研。平台设定为"公众号/短篇平台"，后续阶段不依赖 `01-platform-research.md`。

### 可选/跳过阶段

以下阶段为可选，可在对话菜单中选择"跳过此阶段"：

- 竞品分析（`competitor-analysis`）
- 开篇优化（`opening-optimization`）
- 网文风格学习（`novel-style-learning`）

---

## License

MIT
