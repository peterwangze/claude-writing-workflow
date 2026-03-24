# Writing Workflow Plugin 项目检视报告

- 检视日期：2026-03-24
- 检视范围：当前目录下 `writing-workflow/` 插件资产、根文档、示例产物、设计与 demo 文档
- 检视方式：静态审查，对照文档说明、Skill 定义、Hook 配置、示例状态文件与样例产物
- 重点关注：
  - 文档与实现一致性
  - 实现完整性
  - 工具易用性
  - 指导文档完整性

---

## 一、总体结论

该项目已经具备比较完整的插件资产形态，包括：

- 18 个 Skill
- 1 个子 Agent 定义
- 1 个 SessionStart Hook
- 根 README、插件 README、设计文档、计划文档、demo 文档
- 一套示例 `novel-project/` 产物

从“内容覆盖面”看，项目设计较完整，主流程从选题、写作、质量审查，到上架、变现、数据监控都有定义；从“实际可交付度”看，当前主要问题不在于缺文档，而在于以下三类断层：

1. 阶段依赖未完全闭合，存在前置条件冲突。
2. README 中的“自动化”和“完整工作流”表述强于当前可验证实现。
3. 短篇分支、AI 合规分支、失败恢复分支的说明与样例产物之间存在不一致。

综合判断：

- 文档与实现一致性：中等偏弱
- 实现完整性：中等
- 工具易用性：中等
- 指导文档完整性：中等偏弱

---

## 二、核心发现

## 1. 严重问题

### 1.1 阶段依赖存在冲突，主流程无法严格按文档顺序闭环

文档与主协调 Skill 均描述流程为：

`作品类型选择 -> 平台调研 -> 竞品分析 -> 题材选择 -> 作品确认`

但 `competitor-analysis` Skill 的前置依赖却要求：

- 平台已确定
- `01-platform-research.md` 存在
- `02-genre-analysis.md` 存在

这意味着它实际上依赖“题材选择已完成”，与“竞品分析在题材选择之前”这一流程定义矛盾。

影响：

- 用户按 README 理解执行顺序时，会在竞品分析阶段遇到逻辑冲突。
- 主 Skill 的阶段编排难以稳定复用。
- demo 即使跑通，也不能证明标准主路径可稳定运行。

证据：

- `README.md`
- `writing-workflow/README.md`
- `writing-workflow/skills/using-writing-workflow/SKILL.md`
- `writing-workflow/skills/competitor-analysis/SKILL.md`

建议：

- 二选一统一设计：
  - 方案 A：将 `competitor-analysis` 明确调整到 `genre-selection` 之后。
  - 方案 B：保留当前位置，但修改其前置依赖，只要求平台和候选题材方向，不再依赖 `02-genre-analysis.md`。
- 同步修正所有 README、demo、状态流转说明。

### 1.2 短篇路径没有真正实现闭环，只在文档和样例中“部分放行”

`work-type-selection` 已写入“短篇/小故事建议跳过平台调研”的提示，但它创建的状态文件模板仍固定把下一阶段设为 `platform_research`。

同时：

- `genre-selection` 要求 `platform` 已设置且 `01-platform-research.md` 存在。
- `novel-confirmation` 也要求 `01-platform-research.md` 和 `02-genre-analysis.md` 存在。
- demo 和样例 `workflow-state.json` 却直接跳过了 `platform_research`，并把平台写成 `公众号/短篇平台`。

这说明：

- 短篇路径在说明层面已经被接受。
- 但在 Skill 前置依赖和状态模板层面还没有完全重构。

影响：

- 短篇用户是当前最容易触发断裂的一类用户。
- demo 给出“完整工作流验证通过”的结论，但无法证明这一分支在通用规则下成立。

证据：

- `writing-workflow/skills/work-type-selection/SKILL.md`
- `writing-workflow/skills/genre-selection/SKILL.md`
- `writing-workflow/skills/novel-confirmation/SKILL.md`
- `docs/demo/2026-03-22-short-story-demo.md`
- `novel-project/workflow-state.json`

建议：

- 为短篇路径单独定义合法阶段流：
  - `work_type_selection -> genre_selection -> novel_confirmation -> ...`
- 将短篇平台抽象为“发布场景”而非长篇平台调研结果。
- 放宽或条件化 `genre-selection` / `novel-confirmation` 对 `01-platform-research.md` 的依赖。
- 在 README 中明确区分“长中篇路径”和“短篇路径”。

## 2. 中等问题

### 2.1 AI 合规阶段被作为核心卖点宣传，但样例未能证明该阶段真实执行

项目对外强调：

- AI 合规保护
- 创作日志
- 每章自动触发 AI 合规处理

但当前样例产物中：

- `workflow-state.json` 没有 `human_ai_collaboration`
- `files` 中没有 `13-creation-logs`
- 示例目录中也没有对应创作日志目录或文件

同时 demo 最终仍然给出“完整工作流逻辑验证通过”的结论。

影响：

- 削弱项目最关键差异化卖点的可信度。
- 用户会默认认为 AI 合规步骤已内建并有验证支撑。

证据：

- `README.md`
- `writing-workflow/README.md`
- `writing-workflow/skills/using-writing-workflow/SKILL.md`
- `writing-workflow/skills/human-ai-collaboration/SKILL.md`
- `novel-project/workflow-state.json`
- `docs/demo/2026-03-22-short-story-demo.md`

建议：

- 如果当前仅完成“规范定义”，应在 README 中改为“支持 AI 合规工作流规范”而不是“已自动执行”。
- 如果希望保留当前表述，应补齐一组真实样例：
  - `13-creation-logs/chapter-001-log.md`
  - 状态文件中的 `human_ai_collaboration`
  - demo 中对应阶段记录

### 2.2 “自动化”表述明显强于当前仓库中可验证实现

文档多处使用“自动检测”“自动触发”“自动调用”“自动维护”等措辞，例如：

- 自动检测已有项目进度
- 自动调用质量审查
- 数据异常自动触发优化闭环
- 自动维护 `workflow-state.json`

但当前仓库里真正可验证的自动化只有一个：

- `SessionStart` Hook
- 其实际行为只是打印插件加载提示

没有发现与以下能力对应的脚本或机制：

- 状态驱动调度器
- 自动质量审查触发器
- 数据监控异常触发器
- 子 Agent 失败自动重试逻辑

说明当前“自动化”主要依赖 Claude 在对话中遵循 `SKILL.md` 的提示执行，而不是仓库中存在明确的可验证实现。

影响：

- 易用性预期过高。
- 用户可能把“提示词工作流”理解成“插件层自动编排”。

证据：

- `writing-workflow/README.md`
- `writing-workflow/skills/using-writing-workflow/SKILL.md`
- `writing-workflow/hooks/hooks.json`
- `writing-workflow/hooks/run-hook.cmd`

建议：

- 在 README 中区分两类能力：
  - 插件层已实现能力
  - 依赖主 Agent 按 Skill 约定执行的能力
- 避免把“对话式约定”描述成“底层自动化”。

### 2.3 外部依赖和运行前提说明不完整

当前安装和快速开始文档给人的感受是“装完即可直接使用”，但项目实际依赖以下宿主能力：

- `WebSearch`
- `AskUserQuestion`
- Skill 自动触发/路由能力

此外，主 Skill 还引入了 `pua:pua` 这一外部 Skill 分支，但当前仓库中并未打包对应资产。

这意味着：

- 用户安装本插件后是否可完整使用，依赖宿主环境是否支持这些能力。
- 当前文档没有明确这些前提条件，也没有给出缺失能力时的降级行为。

影响：

- 容易出现“已安装但无法按文档使用”的情况。
- 问题定位成本高，用户难判断是插件问题还是宿主环境问题。

证据：

- `README.md`
- `writing-workflow/README.md`
- `writing-workflow/skills/work-type-selection/SKILL.md`
- `writing-workflow/skills/using-writing-workflow/SKILL.md`

建议：

- 在安装前新增“环境前提”章节，明确说明：
  - 需要支持 WebSearch
  - 需要支持结构化问答/选项确认
  - 若 `pua` Skill 不存在，主流程将忽略该分支或退化为普通错误处理
- 将外部依赖写成“可选集成”，不要写成默认可用。

## 3. 轻微问题

### 3.1 发布元数据仍是占位信息

当前插件与 marketplace 元数据中仍存在占位字段：

- `author.name = "User"`
- `author.email = "user@example.com"`
- `owner.name = "User"`

影响：

- 对外发布形象不完整。
- 降低 marketplace 安装可信度。

证据：

- `writing-workflow/.claude-plugin/plugin.json`
- `writing-workflow/.claude-plugin/marketplace.json`

建议：

- 发布前替换为真实作者与仓库维护信息。

### 3.2 示例结论过于乐观

demo 文档只把“短篇路径缺失”列为中等问题，把其他问题降为轻微或未纳入问题清单，但从仓库现状看，至少还存在：

- 阶段依赖冲突
- AI 合规样例缺失
- 自动化表述过强

影响：

- 让读者误以为主流程已基本稳定，只剩轻微 UX 问题。

建议：

- 将 demo 从“完整验证结论”改为“单条演示路径验证”。
- 单独增加“当前已知限制”章节。

---

## 三、专项评价

## 1. 文档与实现一致性

评价：`中等偏弱`

优点：

- 根 README 和插件 README 结构清晰。
- 多数 Skill 都有完整触发条件、输入输出和示例模板。
- 目录结构与文档总体对应。

问题：

- 阶段顺序与 Skill 前置条件不一致。
- demo 结论与样例产物不完全匹配。
- “自动执行”与当前可验证实现存在落差。

## 2. 实现完整性

评价：`中等`

优点：

- 主流程资产覆盖完整。
- 各阶段输出模板和状态文件设计较系统化。
- 已有样例项目可作为演示基础。

问题：

- 短篇路径未完全闭环。
- AI 合规分支未在样例中落地。
- 失败恢复、上下文超限、自动重试等逻辑主要停留在说明层。

## 3. 工具易用性

评价：`中等`

优点：

- 安装方式明确。
- 启动入口简单，符合对话式使用习惯。
- 工作目录和多项目管理说明比较直观。

问题：

- 用户预期会被“自动调度”“自动触发”表述抬高。
- 短篇用户路径容易迷失。
- 缺少“环境不满足时怎么办”的指导。

## 4. 指导文档完整性

评价：`中等偏弱`

优点：

- 主 README 与插件 README 内容覆盖广。
- 设计文档与计划文档保留了完整的设计上下文。

问题：

- 缺少显式“环境前提/限制说明”。
- 缺少“哪些能力是约定执行，哪些是实际自动化”的边界说明。
- 缺少“已知限制”章节。

---

## 四、修复优先级建议

建议按以下顺序处理：

### P0

- 统一 `competitor-analysis` 的阶段位置与前置依赖
- 打通短篇分支的状态流转与依赖条件
- 修正文档中“完整工作流验证通过”的表述

### P1

- 明确 AI 合规阶段当前是否真正落地
- 若已落地，补齐样例日志与状态文件
- 若未完全落地，降低 README 中的承诺强度

### P2

- 区分“宿主能力依赖”和“插件已实现能力”
- 补充“环境前提”“已知限制”“降级行为”文档
- 修复占位 metadata

---

## 五、建议新增的文档内容

建议在根 README 或 `writing-workflow/README.md` 中新增以下章节：

### 1. 环境前提

- 需要 Claude Code 支持 Plugin
- 需要支持 WebSearch
- 需要支持结构化问答能力
- 某些增强分支依赖额外 Skill

### 2. 已知限制

- 短篇路径仍在完善
- 某些“自动化”依赖主 Agent 遵循 Skill 规范执行
- 数据监控、异常闭环属于流程规范，不是底层脚本自动任务

### 3. 分支路径说明

- 长篇/中篇标准路径
- 短篇/小故事路径
- 可跳过阶段及其影响

### 4. 示例说明

- demo 是单条演示路径，不代表所有路径已完全验证

---

## 六、最终结论

该项目已经具备较好的“工作流产品化雏形”，资产齐全，结构完整，写作场景聚焦明确。当前最大问题不是“内容不够多”，而是“承诺边界不够清晰”与“部分关键路径未完全闭合”。

如果目标是作为内部试验型插件使用，当前仓库已经具备较强参考价值。

如果目标是作为面向外部用户的稳定插件发布，建议至少先完成以下三项：

1. 修正阶段依赖冲突。
2. 打通短篇路径。
3. 收敛 README 中关于自动化与完整性的表述。

完成这三项后，项目的可信度、可用性和维护成本都会明显改善。

---

## 七、附注

本报告基于静态审查得出，未在真实 Claude Code 环境中执行完整 `/plugin add`、`/plugin install` 与全流程对话验证。

因此，本报告重点识别的是：

- 文档与资产定义之间的显性不一致
- 样例产物与流程声明之间的断层
- 用户使用时最可能遇到的可用性与完整性风险

对于宿主环境实际路由行为、Skill 调度细节和运行时体验，仍建议在目标环境中补做一次端到端 smoke test。
