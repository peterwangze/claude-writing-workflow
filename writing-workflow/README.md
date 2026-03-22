# Writing Workflow Plugin

AI辅助小说创作工作流插件，实现从平台调研到盈利变现的端到端解决方案。

## 安装

```bash
# 克隆仓库后，在仓库根目录执行
/plugin add ./writing-workflow
```

## 快速开始

安装后，在 Claude Code 中输入：

```
开始小说创作工作流
```

Claude 会自动检测 `novel-project/workflow-state.json`：
- **新项目**：初始化工作流，从"作品类型选择"开始
- **已有项目**：加载进度，显示当前阶段和可选操作

---

## 使用指南

### 启动工作流

以下任意表达都能触发工作流：

```
开始小说创作
创作小说
写作工作流
请使用 writing-workflow skill
```

### 工作流交互模式

每个阶段完成后，系统会提供操作菜单：

```
当前阶段：平台调研 已完成

可选操作：
1. 继续下一阶段（题材选择）
2. 重新执行当前阶段
3. 跳到指定阶段
4. 查看当前进度
5. 保存并退出
```

### 断点续传

随时退出，下次运行时自动恢复进度。所有阶段产出以 Markdown 文件保存在 `novel-project/` 目录中。

---

## 工作流阶段详解

### 阶段 0：作品类型选择（work-type-selection）

**触发**：工作流启动
**输出**：`novel-project/00-work-type.md`

选择适合的作品类型：
- 长篇网文（50万字以上，适合连载平台）
- 中篇小说（10-30万字，适合完结市场）
- 短篇/系列（单篇1-5万字）

---

### 阶段 1：平台调研（platform-research）

**触发**：作品类型确定后
**输出**：`novel-project/01-platform-research.md`

使用 WebSearch 实时搜索各平台数据，分析：
- 热门题材排行和用户画像
- 签约政策和流量分配机制
- 平台竞争程度（红海/蓝海）
- 盈利模式（付费/广告/全勤奖）

支持平台：番茄小说、起点中文网、晋江文学城、七猫小说

---

### 阶段 1.5：竞品深度分析（competitor-analysis）

**触发**：平台确定后、题材选择前
**输出**：`novel-project/16-competitor-analysis.md`

拆解同赛道头部作品，提取：
- 开篇钩子设计和前三章结构
- 爽点节奏曲线和高潮分布
- 人设模板和关系模型
- 差异化突破口（你的作品如何与头部拉开距离）

---

### 阶段 2：题材选择（genre-selection）

**触发**：平台调研完成后
**输出**：`novel-project/02-genre-analysis.md`

结合平台调研和竞品分析，推荐题材：
- 红海题材（高流量但竞争激烈）
- 蓝海题材（低竞争但潜力大）
- 结合用户画像的个性化推荐

---

### 阶段 3：作品确认（novel-confirmation）

**触发**：题材选择完成后
**输出**：`novel-project/03-novel-info.md`

生成 5 个完整作品方案，每个方案包含：
- 书名（吸引力测试）
- 一句话简介（爽点核心）
- 详细内容简介（300字）
- 封面提示词（AI生图用）

用户选择后确定主选方案和备选方案。

---

### 阶段 4：创作规划（creation-planning）

**触发**：作品确认后
**输出**：`novel-project/04-creation-plan.md`

制定创作计划：
- 字数目标（总字数、单章字数）
- 发布频率（每日/每周更新量）
- 存稿计划（首发前需要多少存稿）
- 卷数划分和节奏规划

---

### 阶段 5：大纲生成（outline-writing）

**触发**：创作规划完成后
**输出**：
- `novel-project/05-outline.md`（主大纲）
- `novel-project/08-characters/main-characters.md`
- `novel-project/08-characters/supporting-characters.md`
- `novel-project/08-characters/character-relationships.md`
- `novel-project/09-worldbuilding/world-settings.md`
- `novel-project/09-worldbuilding/power-system.md`（如适用）

包含世界观设定、力量体系、人物设定、人物关系图、分卷情节大纲。
生成后自动调用 `quality-review` 进行架构/节奏/用户画像审查。

---

### 阶段 6：章节细纲（chapter-outline）

**触发**：大纲确认后
**输出**：`novel-project/06-chapter-outlines/chapter-XXX.md`

逐章生成细纲，每章包含：
- 章节概要（100-200字）
- 场景列表
- 人物出场
- 情节四要素（开头/发展/高潮/结尾）
- 伏笔/呼应
- 预计字数

分批生成，每批需用户确认后继续。

---

### 阶段 7：正文生成（content-generation）

**触发**：细纲生成后
**输出**：`novel-project/07-content/chapter-XXX.md`

按照平台算法适配写法生成正文：

| 平台 | 核心写法要点 |
|------|-------------|
| **番茄小说** | 前300字必须有冲突、每800字一个悬念、2000-2500字/章、章末强钩子 |
| **起点中文网** | VIP章开头即时回报、制造20秒沉浸点、每章"值回票价"场景 |
| **晋江文学城** | 情感描写有层次、人设优先于情节、章末引发评论讨论 |

前三章生成时，自动调用 `opening-optimization` 进行黄金三章专项优化。

---

### 阶段 7.5：AI 合规处理（human-ai-collaboration）

**触发**：每章正文生成后（自动）
**输出**：`novel-project/13-creation-logs/`

系统性去除 AI 痕迹：
- 句式多样化（避免重复句式结构）
- 过渡词自然化
- 情感具体化（细节描写代替直白表达）
- 对话口语化
- 场景感官化

同时生成**创作日志**作为人工创作证明（用于应对平台质疑）。

> ⚠️ 主流平台（起点、番茄、七猫）已全面禁止 AI 内容，AI 内容占比超过 15-20% 可能导致下架。

---

### 阶段 8：质量审查（quality-review）

**触发**：大纲/细纲/正文生成后（自动），或用户手动触发
**输出**：`novel-project/10-reviews/quality-reports/`

多角色审查体系：

| 审查阶段 | 审查角色 | 审查内容 |
|----------|----------|----------|
| 大纲 | 架构审查员 | 世界观完整性、设定逻辑 |
| 大纲 | 节奏审查员 | 情节节奏、爽点分布 |
| 大纲 | 用户画像审查员 | 是否符合目标读者预期 |
| 细纲 | 情节审查员 | 与大纲一致性 |
| 细纲 | 连贯性审查员 | 章节间连贯性 |
| 正文 | 人物审查员 | 人物行为是否符合设定 |
| 正文 | 文风审查员 | 是否符合平台用户偏好 |
| 正文 | AI痕迹审查员 | 识别并消除AI生成特征 |

---

### 阶段 9：上架发布策略（launch-strategy）

**触发**：存稿达标后
**输出**：`novel-project/14-launch-strategy.md`

- **存稿计算**：首发需要多少存稿（各平台建议 10-30 章）
- **签约指导**：各平台签约流程和条件
- **上架时机**：最优发布时间点（节假日/平台活动）
- **首秀策略**：首日推荐位竞争策略
- **上新推广**：读者引流和初期互动策略

---

### 阶段 10：变现策略（monetization-strategy）

**触发**：上架策略确定后
**输出**：`novel-project/15-monetization-strategy.md`

- **VIP 上架时机**：最佳转 VIP 章节位置
- **付费卡点设计**：在哪里放高潮让读者付费追读
- **全勤奖规划**：如何保持更新频率拿全勤奖
- **打赏激励机制**：引导读者打赏的话术和技巧
- **收益预测**：基于同类作品数据的收益预估
- **IP 衍生规划**：有声书、动漫授权等变现路径

---

### 阶段 11：数据监控（data-monitoring）

**触发**：作品发布后，建议每周执行一次
**输出**：`novel-project/11-data-monitoring/weekly-report-YYYY-MM-DD.md`

**核心监控指标**：
- 完读率（10万字 >15%，20万字 >8%）
- 三日留存率（>10%）
- 追读趋势（持续上升为健康）
- 章节读完率（每章 >50%）

**数据→内容自动闭环**：

| 数据信号 | 触发阈值 | 自动执行 |
|----------|----------|----------|
| 完读率低 | 10万字 <10% | 重审前3章，触发 opening-optimization |
| 章节流失 | 某章读完率 <30% | 章节诊断 + 重写建议 |
| 追读下降 | 连续3天 >10%降幅 | 最新3章节奏和爽点分析 |
| 收藏停滞 | 日增收藏 <10（连续7天）| 书名/简介/封面优化 |

---

### 阶段 12：读者互动（reader-interaction）

**触发**：作品发布后持续运营
**输出**：`novel-project/12-reader-interaction/`

- 评论回复策略（分类：催更/提问/差评）
- 粉丝群运营（话题互动、投票参与）
- 读者反馈转化（将读者建议转化为创作调整）
- 危机公关（处理差评和负面舆情）

---

### 辅助工具

#### 开篇优化（opening-optimization）

**触发**：前三章生成后自动建议，或手动调用

针对黄金三章的专项优化：
- 首句钩子检测（前50字内必须抓住读者）
- 三章节奏审查（爽点密度、悬念设置）
- 番茄/起点/晋江 差异化优化建议

#### 网文风格学习（novel-style-learning）

**触发**：任意阶段，用户主动调用

提供网文写作方法论：
- 爽文结构公式
- 系统文/穿越文/都市文各自的标准套路
- 高点击书名和简介的写作技巧

---

## 项目文件结构

工作流生成的所有文件保存在 `novel-project/` 目录：

```
novel-project/
├── workflow-state.json         # 工作流状态（自动维护）
├── 00-work-type.md             # 作品类型
├── 01-platform-research.md     # 平台调研报告
├── 02-genre-analysis.md        # 题材分析
├── 03-novel-info.md            # 作品信息
├── 04-creation-plan.md         # 创作规划
├── 05-outline.md               # 大纲
├── 06-chapter-outlines/        # 章节细纲
├── 07-content/                 # 正文
├── 08-characters/              # 人物设定
├── 09-worldbuilding/           # 世界观设定
├── 10-reviews/                 # 质量审查报告
├── 11-data-monitoring/         # 数据监控（发布后）
├── 12-reader-interaction/      # 读者互动记录（发布后）
├── 13-creation-logs/           # AI合规创作日志
├── 14-launch-strategy.md       # 上架发布策略
├── 15-monetization-strategy.md # 变现策略
└── 16-competitor-analysis.md   # 竞品分析报告
```

> `novel-project/` 已加入 `.gitignore`，创作内容不会提交到仓库。

## License

MIT
