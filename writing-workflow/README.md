# Writing Workflow Plugin

AI辅助小说创作工作流插件，实现从平台调研到盈利变现的端到端解决方案。

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

生成后自动调用质量审查（架构/节奏/用户画像三角色审查）。

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

前三章自动调用 `opening-optimization` 进行黄金三章专项优化。

---

#### 阶段 7.5：AI 合规处理

**输出**：`novel-project/13-creation-logs/`

> ⚠️ 主流平台（起点/番茄/七猫）已全面禁止 AI 内容，AI 占比 >15% 可能下架。

系统性去除 AI 痕迹（句式多样化、过渡词自然化、情感具体化、对话口语化），同时生成创作日志作为人工创作证明。

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

监控完读率/留存率/追读趋势，数据异常自动触发内容优化闭环：

| 信号 | 阈值 | 自动执行 |
|------|------|----------|
| 完读率低 | 10万字 <10% | 触发前3章重审 |
| 章节流失 | 某章读完率 <30% | 章节诊断+重写建议 |
| 追读下降 | 连续3天 >10% | 节奏/爽点分析 |
| 收藏停滞 | 日增 <10（连续7天）| 书名/简介优化 |

---

#### 阶段 12：读者互动

**输出**：`novel-project/12-reader-interaction/`

评论分类回复策略（催更/提问/差评）、粉丝运营、危机公关。

---

### 辅助工具

**开篇优化**（`opening-optimization`）：前三章自动建议，或手动触发。首句钩子检测、三章节奏审查、平台差异化优化。

**网文风格学习**（`novel-style-learning`）：任意阶段可调用。爽文结构公式、各类型套路、书名/简介写作技巧。

---

## 生成的文件结构

```
novel-project/
├── workflow-state.json         # 工作流状态（自动维护）
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

## License

MIT
