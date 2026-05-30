# Claude Writing Workflow Plugin

> 面向平台投稿的写作辅助工作流 — 以人类原创为主体，AI 提供有限辅助

一个基于 Claude Code Plugin 系统构建的网文创作辅助插件，覆盖市场调研、选题策划、大纲生成、写作辅助、质量审查、上架准备和数据监控全流程。**默认以人类原创写作为主体**，AI 仅在研究、灵感、校对、资料整理和有限改写方面提供辅助。

> **重要提示**：各大平台（番茄、起点、晋江、七猫）的 AI 政策持续变化。本插件不能保证通过任何平台的 AI 审核。投稿前请通过 WebSearch 核实目标平台最新官方政策。

## 特性

- **全流程覆盖**：26 个 SKILL + 16 个专业 Agent（5 团队），覆盖创作→发布→运营→变现完整链路
- **Agent Team 架构**：创作者与审查者绝对分离，6 个独立审查 Agent 并行审查每章
- **人类原创为主**：默认工作模式为人类主导创作，AI 仅做研究、灵感、校对等有限辅助
- **零容忍连续性**：场景覆盖率=100%，偏离度=0%——任何偏离随章节累积会指数级放大
- **6 维质量审查**：基于行业标准 + 1000+ 作品研究的评分体系，6 个独立审查 Agent 并行审查每章
- **平台写法参考**：番茄/起点/晋江/七猫差异化写法，CCC 开篇架构验证
- **基于实时数据**：WebSearch 驱动的市场调研，1000+ 作品成功模式研究注入
- **正文看护流程**：story bible + context card + continuity ledger 三层约束 + Bible 交叉验证
- **证据链留存**：创作日志记录人机协作过程，支持投稿前自证
- **断点续传**：工作流状态持久化，随时保存/恢复创作进度

## 支持的平台

| 平台 | 核心指标 | 算法适配 |
|------|----------|----------|
| 番茄小说 | 完读率、吸量 | 前300字冲突、每800字悬念、短章节 |
| 起点中文网 | 付费追读 | VIP回报感、沉浸点、周二质量峰值 |
| 晋江文学城 | 积分/收藏 | 情感细腻、人设优先、评论引导 |
| 七猫小说 | 阅读时长 | 通俗易懂、情节密集 |

---

## 安装

> ⚠️ `/plugin` 命令在 **Claude Code 对话框**中输入，不是在终端执行。

### 前提条件

| 依赖 | 说明 |
|------|------|
| Claude Code | 支持 `/plugin` 命令的版本 |
| WebSearch | 必须 — 市场调研阶段需要实时搜索 |
| AskUserQuestion | 必须 — 所有关键决策需要用户确认 |

### 方式一：Marketplace 安装（推荐）

```
/plugin marketplace add peterwangze/claude-writing-workflow
/plugin install writing-workflow
```

### 方式二：本地安装

```bash
git clone https://github.com/peterwangze/claude-writing-workflow.git
```

然后在 **Claude Code 对话框**中执行：

```
/plugin add /你的路径/claude-writing-workflow/writing-workflow
```

### 验证安装

重启 Claude Code 会话，启动时看到以下提示即安装成功：

```
Writing Workflow Plugin loaded. Use 'writing-workflow' skill to start.
```

---

## 快速开始

### 第一步：设置工作目录

插件会在 Claude Code 的**当前工作目录**下创建 `novel-project/` 文件夹保存所有创作文件。建议为每部小说创建独立目录：

```bash
# 在终端中
mkdir ~/novels/我的第一部小说
cd ~/novels/我的第一部小说
# 然后在此目录下启动 Claude Code
```

> 如果你在 Claude Code 中已经打开了某个项目目录，创作文件会生成在那个目录下。

### 第二步：启动工作流

在 Claude Code 对话框中，直接告诉 Claude：

```
开始小说创作工作流
```

Claude 会检测当前目录是否有已有项目进度：
- **新项目**：初始化工作流，从"作品类型选择"开始
- **已有项目**：加载进度，显示当前阶段和可选操作

### 第三步：跟随引导完成创作

工作流由 `using-writing-workflow` 主 Skill 全程协调，**你不需要手动调用其他 Skill**。只需回答 Claude 的问题和确认每个阶段的产出即可。

---

## 工作流概览

```
作品类型选择 → 平台调研 → 竞品分析 → 题材选择 → 作品确认 → 创作规划
                                                              ↓
                                  质量审查 ← AI合规处理 ← 正文生成 ← 章节细纲 ← 大纲生成
                                                              ↓
                              上架发布策略 → 变现策略 → 数据监控 → 读者互动
```

| # | 阶段 | 核心产出 |
|---|------|----------|
| 0 | 作品类型选择 | 长/中/短篇选择 + 约束设定 |
| 1 | 平台调研 | 平台对比报告 + 推荐平台 |
| 1.5 | 竞品深度分析 | 头部作品拆解 + 差异化方向 |
| 2 | 题材选择 | 红海/蓝海分析 + 推荐题材 |
| 3 | 作品确认 | 5个方案 → 选定书名/简介 |
| 4 | 创作规划 | 篇幅/频率/节奏规划 |
| 5 | 大纲生成 | 世界观/人物/情节大纲 |
| 6 | 章节细纲 | 逐章场景/情节/伏笔 + chapter context card |
| 7 | 正文生成 | 平台算法适配正文 + 连续性账本 |
| 7.5 | AI合规处理 | 去AI痕迹 + 创作日志 |
| 8 | 质量审查 | 多维审查报告 |
| 9 | 上架发布策略 | 存稿计划 + 签约指导 |
| 10 | 变现策略 | VIP卡点 + 收益预测 |
| 11 | 数据监控 | 数据周报 + 内容优化闭环 |
| 12 | 读者互动 | 评论运营 + 粉丝管理 |

详细的每个阶段说明参见 [writing-workflow/README.md](./writing-workflow/README.md)。

---

## 常见问题

**Q: `/plugin` 命令在哪里输入？**

在 Claude Code 的对话框（聊天输入框）中输入，以 `/` 开头。不是在系统终端中执行。

**Q: 如何继续上次未完成的创作？**

确保在同一个工作目录下启动 Claude Code，然后说"继续小说创作工作流"，系统会自动加载 `novel-project/workflow-state.json` 中的进度。

**Q: 如何管理多个创作项目？**

为每部小说创建独立目录，在不同目录下启动 Claude Code：
```bash
cd ~/novels/项目A  # 切换到项目A目录，再使用Claude Code
cd ~/novels/项目B  # 切换到项目B目录，再使用Claude Code
```
每个目录下有独立的 `novel-project/` 文件夹。

**Q: 需要手动调用各个 Skill 吗？**

不需要。启动"小说创作工作流"后，`using-writing-workflow` 主 Skill 会根据工作流状态协调所有其他 Skill。你只需回答问题和确认产出即可。

**Q: 可以跳过某个阶段吗？**

可以。每个阶段完成后的确认菜单中可以选择"跳到指定阶段"。竞品分析、风格学习等非关键阶段可以跳过。

**Q: 创作的内容会上传到 GitHub 吗？**

不会。`novel-project/` 目录已加入 `.gitignore`，所有创作内容只保存在本地。

---

## 环境前提

安装前请确认您的 Claude Code 环境支持以下能力：

| 依赖 | 说明 |
|------|------|
| **WebSearch** | 必须。用于获取实时市场数据。无此能力时市场分析阶段无法执行 |
| **结构化问答** | 必须。用于阶段交互确认（AskUserQuestion 类工具） |
| **Plugin 系统** | 必须。需要 Claude Code 支持 `/plugin` 命令 |
| **pua Skill**（可选）| 若已安装 superpowers 插件可用；未安装时主流程自动跳过该分支 |

---

## 已知限制

| 限制项 | 说明 |
|--------|------|
| 约束执行 | 所有质量门禁和连续性检查依赖 Coordinator 遵循 Skill 规范执行，非自动化代码。实际执行密度取决于 LLM 对规范的遵循程度 |
| 数据监控 | 依赖用户手动提供平台数据，无法自动读取平台后台 |
| 成本 | 每章生成+审查约消耗 0.1-0.3 美元 API 费用（方向性参考），长篇创作累计可达数十至数百美元 |
| Subagent 通信 | 当前使用独立 Subagent 模式，审查员发现问题后通过 Coordinator 中转给写作者。Agent Teams 实验稳定后可直接通信 |

---

## 分支路径说明

### 长篇/中篇标准路径

```
作品类型选择 → 平台调研 → 竞品分析 → 题材选择 → 作品确认 → 创作规划 → ...
```

### 短篇/小故事路径

```
作品类型选择 → [跳过平台调研] → 题材选择 → 作品确认 → 创作规划 → ...
```

选择"短篇小说"或"小故事/短篇集"后，系统提示跳过平台调研，平台设定为"公众号/短篇平台"，后续阶段不依赖平台调研文件。

---

## 正文看护流程

为解决正文经常脱离大纲、细纲，以及上下文断裂的问题，插件现在采用三层看护资产：

1. `story-bible.md`
   - 锁定不可变更事实、时间线锚点、人物基线状态、关键伏笔
2. `chapter-XXX-context.md`
   - 锁定本章输入状态、必写场景、禁止偏离项、本章结束状态
3. `continuity-ledger.md`
   - 记录每章通过后生效的事实、人物状态变化和下一章承接点

同时，`workflow-state.json` 会同步记录：

- 最近通过看护流程的章节
- 最近一次偏离度
- 最近一次 AI 路径评级
- 是否允许进入上架发布 / 变现阶段

正文生成阶段必须：

- 先加载看护资产
- 再按场景顺序逐段生成
- 最后执行连续性硬门槛检查

硬门槛（零容忍）包括：

- 场景覆盖率 < 100%（任何必写场景缺失=阻断）
- 偏离度 > 0%（任何偏离=阻断，过程偏离随章节累积指数级放大）
- Bible 不可变更事实被改写
- 人物/时间线/地点硬冲突
- 必写场景缺失
- 本章结束状态与 context card 不一致

命中任一硬门槛 = 本章必须修正至零偏离，不存在"确认偏离合理继续"选项。

---

## 项目结构

```
claude-writing-workflow/
├── writing-workflow/          # 插件目录
│   ├── .claude-plugin/
│   │   ├── plugin.json        # 插件元数据
│   │   └── marketplace.json   # Marketplace 配置
│   ├── skills/                # 26 个工作流 SKILL
│   ├── agents/                # 子 Agent 配置
│   ├── hooks/                 # SessionStart Hook
│   └── README.md              # 插件详细使用指南
├── docs/                      # 设计文档
├── novel-project/             # 示例产物（含 continuity 资产）
├── .gitignore                 # novel-project/ 已排除
└── README.md                  # 本文件
```

## 版本历史

### v3.0.0
- **偏离零容忍**：场景覆盖率=100%、偏离度=0%——任何偏离=阻断，删除所有"可接受偏离"选项
- 质量审查门禁扩展至 15 项机械逐项检查清单
- Context Card 生成后强制 Bible 交叉验证
- Coordinator 审查通过后强制状态同步

### v2.9.x
- 1000+ 作品研究注入：CCC 开篇架构、悬念强度分级、中段防崩、推荐触发点设计
- P0-P2 三级约束落地（13 项强制门禁 + 10 项新能力 + 8 项增强）
- 阅读体验审查员加入审查组（6 Agent 并行审查）
- 9 维评分体系（情感体验权重 5→10%）

### v2.5.x
- 8 维文学成功框架注入（情感契约、回报分级、群像生态、社会共鸣）
- 1000+ 成功作品深度研究

### v2.2.0
- 新增加交互架构定义：三层角色模型（用户/Coordinator/Subagent）
- 定义 Coordinator 的 4 种产出路由（决策型/执行型/审查型/参考型）
- 定义 5 个用户干预时机和进度面板模板
- 明确 Subagent 硬边界：不交互/不改状态/不做最终决策/不相互通信
- 新增工具降级协议：WebSearch 失败后优雅降级为 LLM 推断模式
- 修复 Subagent 绕过 AskUserQuestion 的系统性漏洞

### v2.1.1
- 修复 Subagent 绕过 AskUserQuestion 的系统性漏洞
- 新增加两阶段执行协议：决策型阶段（方案模式）vs 执行型阶段（执行模式）
- 6 个决策型阶段改为"Subagent 生成方案 → Coordinator AskUserQuestion 确认"
- 8 个执行型阶段改为"直接执行 → Coordinator 门禁检查 → AskUserQuestion 展示"

### v2.1.0
- 新增 14 个 Agent 的子 Agent 启动协议模板（标准 prompt + 三层约束注入）
- 审查组 5 个 Agent 支持并行启动
- 每个启动模板包含：角色定义路径 + SKILL 规范路径 + 工作文件绝对路径 + 任务描述
- 内容写作者启动 prompt 明确"只负责写，不自审"
- Agent 启动使用 `isolation: "worktree"` 实现文件隔离

### v2.0.0
- **重大架构变更**：引入 Agent Team 模式，14 个专业 Agent 分属 5 个职能团队
- 市场调研组：市场分析师 + 竞品拆解专家
- 策划创作组：创作策略顾问 + 小说架构师
- 内容生产组：章节设计师 + 内容写作者（创作者与审查者绝对分离）
- 审查组：连续性审查员 + 人物世界观审查员 + 情节逻辑审查员 + 商业编辑 + AI合规官
- 运营组：发布策略师 + 变现顾问 + 数据运营分析师
- 每个 Agent 采用三层角色定位（身份层/职责层/行为层）
- Coordinator 新增 Agent Team 调度规则和阶段→Agent 映射

### v1.5.0
- 新增强制门禁检查系统：Coordinator 在阶段间执行 F1→F4 四级硬门禁
- 全部 16 个阶段技能新增"最低交付清单"章节（结构化可验证）
- 质量关键阶段（大纲/细纲/正文/AI合规/质量审查）不提供跳过选项
- AI 合规闸门嵌入发布和变现阶段的门禁检查（release_allowed/monetization_allowed）
- 门禁失败统一使用 AskUserQuestion 阻断流程

### v1.4.0
- quality-review 评分体系重构为行业标准 8 维度 100 分制
- 修复文件加载链：character-relationships / world-settings / power-system 全下游可读取
- 修复 ledger↔context 字段粒度对齐（逐角色状态 + 主角目标）
- 修复 subagent 审查 prompt 模板（补全 bible/context/ledger 路径）
- 力量体系模板结构化（晋升条件/资源/风险/副作用/实力差距）
- 统一 outline 与 story-bible 的伏笔表字段
- 新增连续性硬门槛：bible 不可变更事实改写检测 + 伏笔逾期检测
- 新增 ledger 重写版本控制和审查反馈修正循环

### v1.3.0
- 体裁选择注入盈利数据（按体裁/按平台收入搜索+盈利潜力评估）
- 新增 5 种合同陷阱保护（自动续约、优先购买权、竞业限制、广告权、独家范围）
- 创作规划新增盈利可行性评估（时间成本+收益预估+盈亏判断）
- 大纲/细纲新增付费卡点强度验证和付费转化验证
- 补齐短篇路径盈利分析
- 数据监控新增财务止损决策框架
- 发布策略推荐阈值增加时效性警告
- 变现策略新增收益降级模板+多作品组合+国际市场变现
- 竞品分析新增货币化模式提取
- 数据监控新增退款率/ARPU指标
- 读者互动新增付费读者维护策略
- 质量审查新增货币化准备度评分维度
- AI合规阻断新增财务后果量化说明
- 跨阶段收益数据传递（平台调研→变现策略）

### v1.2.1
- 全 18 个 Skill 强制使用 AskUserQuestion 进行用户决策交互
- quality-review / opening-optimization / novel-style-learning 从零开始引入 AskUserQuestion
- 统所有用户确认步骤和搜索失败处理为 AskUserQuestion 模式

### v1.2.0
- 状态更新从完整替换改为增量模式，消除逐阶段覆盖导致的数据丢失
- work-type-selection 初始状态补齐 guardrails 对象
- 补全 11-data-monitoring/12-reader-interaction/13-creation-logs 目录创建
- 对齐 creation-planning 与 launch-strategy 的存稿数字
- genre-selection 消费 competitor-analysis 的差异化分析结果
- 补齐 launch-strategy/monetization-strategy/data-monitoring/reader-interaction 的状态更新
- data-monitoring/reader-interaction/opening-optimization/novel-style-learning 补全用户交互
- 统一 WebSearch 搜索失败降级选项为 4 项标准格式
- 合并 data-monitoring 重复报告模板
- 清理 human-ai-collaboration 路径 C 重复赋值

### v1.1.0
- 统一偏离度/场景覆盖率阈值标准（10%/15% 硬门槛），消除 P0 级矛盾
- 补齐短篇/公众号路径平台算法适配
- 对齐 context card 与看护包字段，消除正文生成偏移风险
- novel-creator agent 新增正文看护指令
- 消除 AI 合规闸门在 launch-strategy 和 monetization-strategy 中的代码重复
- 修复 hooks 跨平台兼容性（Unix/macOS）
- 修复 novel-confirmation section 编号重复
- 强化 quality-review 独立 subagent 审查执行保证

### v1.0.0
- 18 个完整 Skill 覆盖创作全链路
- 平台算法适配写法（番茄/起点/晋江）
- AI 合规人机协作流程
- 上架发布 + 变现策略体系
- 数据→内容闭环机制
- 竞品深度分析

## License

MIT
