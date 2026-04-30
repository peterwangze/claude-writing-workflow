# Writing Workflow Quality Overhaul Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fix 4 critical quality problems discovered in production usage: research data fabrication, missing profit/compliance orientation in outlines, outline adherence drift in content generation, and ineffective quality review.

**Architecture:** Surgical modifications to 11 existing SKILL.md files. No new files created. Changes are additive sections or replacements of existing sections within each skill file.

**Tech Stack:** Markdown skill files (SKILL.md format), JSON workflow state

---

## Chunk 1: Research Quality Hardening (Problem 1)

Fix data fabrication and stale hardcoded data in research-stage skills.

### Task 1: Strip hardcoded data from platform-research SKILL.md

**Files:**
- Modify: `writing-workflow/skills/platform-research/SKILL.md:72-163` (签约政策详解 + 推荐位规则详解)
- Modify: `writing-workflow/skills/platform-research/SKILL.md:165-196` (收益模式详解)

- [ ] **Step 1: Replace hardcoded 签约政策 section with WebSearch-driven template**

In `writing-workflow/skills/platform-research/SKILL.md`, replace lines 72-163 (from `## 签约政策详解` to the end of `### 推荐位竞争策略`, inclusive of trailing blank line) with:

```markdown
## 签约政策调研（必须实时搜索）

> ⚠️ 以下为调研模板，所有数据必须通过 WebSearch 实时获取，**禁止使用任何预设数值**。

### 每个平台必须搜索的签约信息

对每个目标平台执行以下搜索（动态日期）：

| 搜索项 | 关键词模板 | 必须获取的信息 |
|--------|-----------|---------------|
| 签约门槛 | "[平台] 签约条件 {当前年份}" | 字数要求、审核流程、签约类型 |
| 签约流程 | "[平台] 新人签约流程 {当前年份}" | 具体步骤、时间线、注意事项 |
| 推荐机制 | "[平台] 推荐位规则 {当前年份}" | 推荐类型、触发条件、核心指标 |

### 数据分类标注规则

搜索结果必须按以下分类标注：

| 分类 | 标注格式 | 含义 |
|------|---------|------|
| **官方公告** | 📌 官方来源：[URL] | 平台官方发布的政策 |
| **作者经验** | 📝 作者分享：[URL] | 作者博客/论坛分享，仅供参考 |
| **未验证** | ⚠️ 未找到官方来源 | 无法确认的信息，明确标记不确定性 |

### 搜索验证规则

每个平台的签约数据必须满足：
1. **至少1个官方来源**（平台公告/帮助中心/签约页面）
2. 若无官方来源，必须标注"⚠️ 公开规则不充分，以下为作者社区经验，不应作强结论"
3. **禁止输出无来源的具体数值**（如"千字X元"、"分成X%"等）
```

- [ ] **Step 2: Replace hardcoded 收益模式 section with WebSearch-driven template**

In the same file, replace lines 165-196 (from `## 收益模式详解` to `**典型收益**：日更6000字，保底月入3000+，优秀作品更高。`) with:

```markdown
## 收益模式调研（必须实时搜索）

> ⚠️ 收益数据变动频繁，**禁止使用任何预设收益数值**。所有收益信息必须通过 WebSearch 获取并标注来源。

### 每个平台必须搜索的收益信息

| 搜索项 | 关键词模板 |
|--------|-----------|
| 收益模式 | "[平台] 作者收益模式 {当前年份}" |
| 分成比例 | "[平台] 作者分成比例 最新 {当前年份}" |
| 全勤奖 | "[平台] 全勤奖 金额 {当前年份}" |
| 新人收益 | "[平台] 新人作者 收入 真实 {当前年份}" |

### 收益数据呈现规则

1. **禁止给出具体收益承诺**（如"月入X元"）
2. 只呈现搜索到的、有来源的数据范围
3. 必须包含"实际收益因人而异，以上数据仅供参考"的免责声明
4. 对于"新人首月预期"等诱导性表述，改为"新人作者收益差异极大，取决于作品质量、更新频率和平台推荐"
```

- [ ] **Step 3: Verify changes are syntactically correct**

Read the modified file and confirm:
- No broken markdown structure
- All template placeholders use `{当前年份}` format
- No residual hardcoded numbers remain in the replaced sections

- [ ] **Step 4: Commit**

```bash
git add writing-workflow/skills/platform-research/SKILL.md
git commit -m "fix(platform-research): strip hardcoded data, enforce WebSearch-only policy"
```

### Task 2: Remove unsourced statistics from genre-selection SKILL.md

**Files:**
- Modify: `writing-workflow/skills/genre-selection/SKILL.md:214-295` (高风险题材避坑指南中的具体题材分析)

- [ ] **Step 1: Replace fabricated statistics with WebSearch-driven risk assessment**

In `writing-workflow/skills/genre-selection/SKILL.md`, replace lines 214-295 (from `#### 1. 慢热型文青文学（扑街概率 >95%）` through `| 纪实文学 | 完读率极低 |` and its trailing content). Preserve everything from line 296 (`### 平台算法"隐形黑名单"`) onward. Replace with:

```markdown
#### 1. 慢热型文青文学（高风险）

**典型特征**：
- 前10章无明确主线
- 侧重心理描写 > 情节推进
- 大量环境描写和内心独白

**风险原因**：
- 网文读者普遍追求快节奏、爽感
- 文青风格与网文平台主流阅读期待不匹配

> 具体留存率和数据表现请通过 WebSearch 搜索 "[平台] 慢热文 数据表现 {当前年份}" 获取。

**替代方案**：如果喜欢深度内容，可以尝试"爽文皮+深度核"。

#### 2. 高认知门槛题材（高风险）

**典型特征**：
- 需要专业知识背景才能理解
- 大量术语和复杂设定

**高风险示例**：
| 题材类型 | 问题 | 改进方向 |
|----------|------|----------|
| 硬科幻 | 物理概念过于深奥 | 加入科普解释，降低门槛 |
| 专业职场 | 行业术语过多 | 用通俗语言替代专业术语 |
| 历史正剧 | 考据要求高 | 融入轻松元素，降低历史负担 |

> 具体完读率数据请通过 WebSearch 搜索获取，不使用预设数值。

#### 3. 政策高风险题材（随时面临下架）

**⚠️ 极度危险，强烈不建议尝试**

| 题材类型 | 政策红线 | 替代方案 |
|----------|----------|----------|
| 灵异鬼怪 | 不能出现具体鬼魂形象 | 改为精神疾病/人为阴谋/科幻解释 |
| 官场黑幕 | 严禁描写市级以上干部 | 只写村斗级别/架空世界观 |
| 校园暴力 | 反击尺度受限 | 改为智斗而非肢体冲突 |
| 涉政题材 | 敏感政治人物/事件 | 完全避免，改用架空设定 |
| 涉黄涉暴 | 过度描写性行为/暴力场面 | 适可而止，留白处理 |

#### 4. 情感代偿薄弱题材（读者代入困难）

**高风险示例**：
| 题材类型 | 问题 |
|----------|------|
| 中年危机 | 年轻用户无法共鸣 |
| 精英职场 | 与普通读者生活脱节 |
| 家庭伦理 | 短视频分流严重 |
| 纯悲剧 | 网文读者追求爽感 |

> 具体差评率、流量等数据请通过 WebSearch 搜索 "[题材] 网文 数据表现 {当前年份}" 获取，不使用预设百分比。

#### 5. 非虚构类内容（平台算法不适配）

非虚构类内容（诗歌集、散文随笔、人物传记、纪实文学）在网文平台天然获得较少推荐。

> 具体表现数据请通过 WebSearch 获取，不使用预设数值。
```

- [ ] **Step 2: Verify no fabricated percentages remain**

Search the modified file for patterns like `>XX%`, `<XX%`, `XX%` to ensure no unsourced statistics remain.

- [ ] **Step 3: Commit**

```bash
git add writing-workflow/skills/genre-selection/SKILL.md
git commit -m "fix(genre-selection): remove fabricated statistics, require WebSearch for all data"
```

### Task 3: Make competitor-analysis requirements realistic

**Files:**
- Modify: `writing-workflow/skills/competitor-analysis/SKILL.md:100-161` (章节级深度拆解)

- [ ] **Step 1: Replace unrealistic "前30章结构拆解" with achievable analysis**

In `writing-workflow/skills/competitor-analysis/SKILL.md`, replace lines 100-161 (from `### 3. 章节级深度拆解` through the end of `主角成功要素：[分析为什么读者喜欢这个主角]`) with:

```markdown
### 3. 公开信息深度分析

> ⚠️ AI 无法访问小说正文全文。以下分析基于 WebSearch 可获取的公开信息（书评、读者讨论、平台公开数据、作者访谈等）。

**搜索关键词**：
- "《[书名]》 书评 分析 {当前年份}"
- "《[书名]》 读者评论 优缺点"
- "《[书名]》 爽点 节奏 分析"
- "《[书名]》 作者 创作谈 访谈"

**分析模板**：

```markdown
## 公开信息分析：《[书名]》

### 读者反馈分析
基于书评区/讨论区/社交媒体的读者评价：

**读者最喜欢的要素**：
1. [要素1] - 来源：[URL]
2. [要素2] - 来源：[URL]

**读者最常吐槽的问题**：
1. [问题1] - 来源：[URL]
2. [问题2] - 来源：[URL]

### 成功要素推测
基于公开信息推测的成功要素（非基于原文拆解）：

| 要素 | 推测依据 | 可信度 |
|------|---------|--------|
| [要素1] | [依据：读者评论/排名数据等] | 高/中/低 |
| [要素2] | [依据] | 高/中/低 |

### 可借鉴方法论
基于公开信息提取的方法论（标注推测程度）：

1. **[方法1]**：[描述] — 📌 基于：[来源]
2. **[方法2]**：[描述] — 📌 基于：[来源]

> ⚠️ 以上分析基于公开信息推测，非基于原文逐章拆解。实际创作时需结合自身阅读体验验证。
```

### 数据诚实性要求

- **禁止虚构**："爽点分布图"、"节奏曲线"等需要逐章阅读原文才能生成的内容，如果 AI 无法实际阅读，必须明确标注"无法生成，需作者自行阅读分析"
- **标注推测**：所有非直接来源的结论必须标注"推测"
- **鼓励用户自行阅读**：建议用户亲自阅读竞品前30章并记录爽点/钩子，AI 可提供记录模板
```

- [ ] **Step 2: Add user self-reading template**

After the replaced section, add:

```markdown
### 作者自行阅读记录模板

建议用户亲自阅读竞品并使用以下模板记录：

```markdown
## 我的竞品阅读笔记：《[书名]》

| 章节 | 爽点类型 | 章末钩子 | 我的感受 | 可借鉴点 |
|------|---------|---------|---------|---------|
| 第1章 | | | | |
| 第2章 | | | | |
| ... | | | | |

### 总结
- 最吸引我的地方：
- 我能学到的技巧：
- 我要避开的问题：
```

> 用户提交阅读笔记后，AI 可协助分析并整合到差异化策略中。
```

- [ ] **Step 3: Verify changes**

Read the modified file and confirm:
- No references to "前30章结构拆解" remain
- No templates claim AI can read novel full text
- "爽点分布图" and "节奏曲线" are either removed or marked as requiring user self-reading

- [ ] **Step 4: Commit**

```bash
git add writing-workflow/skills/competitor-analysis/SKILL.md
git commit -m "fix(competitor-analysis): replace unrealistic chapter analysis with achievable public-info analysis"
```

### Task 4: Remove revenue promises from monetization-strategy SKILL.md

**Files:**
- Modify: `writing-workflow/skills/monetization-strategy/SKILL.md:36-99` (收益模式总览 + 各平台收益详解)

- [ ] **Step 1: Replace hardcoded revenue tables with WebSearch-driven template**

In `writing-workflow/skills/monetization-strategy/SKILL.md`, replace lines 36-99 (from `### 收益模式总览` through the end of the 番茄收益公式) with:

```markdown
### 收益模式调研（必须实时搜索）

> ⚠️ 以下收益结构为框架模板。所有具体数值（分成比例、全勤金额、收益预期）必须通过 WebSearch 获取最新数据，**禁止使用预设数值**。

### 每个平台必须搜索的收益信息

| 搜索项 | 关键词模板 |
|--------|-----------|
| 收益结构 | "[平台] 作者收益构成 {当前年份}" |
| 分成比例 | "[平台] 订阅/广告 分成比例 最新政策 {当前年份}" |
| 全勤政策 | "[平台] 全勤奖 政策 {当前年份}" |
| 新人真实收益 | "[平台] 新人作者 真实收入 经验分享 {当前年份}" |

### 收益信息呈现规则

1. **禁止给出"新人首月预期X元"等具体收益承诺**
2. 只呈现有来源的数据，标注来源 URL
3. 必须附加免责声明："实际收益因作品质量、更新频率、平台推荐等因素差异极大，以上数据仅供参考"
4. 若搜索结果中出现收益范围，呈现为"据[来源]，收益范围为X-Y元（数据时间：[日期]）"

### 各平台收益结构框架

对每个平台，按以下结构呈现搜索到的收益信息：

```
平台：[平台名称]
收益模式：[付费订阅/广告分成/保底+分成]（基于搜索结果）

收益构成：
1. [核心收益类型]：[搜索到的最新政策描述，标注来源]
2. [辅助收益类型]：[搜索到的最新政策描述，标注来源]
3. [奖励机制]：[搜索到的最新政策描述，标注来源]

数据来源：
- [来源1标题](URL)
- [来源2标题](URL)

⚠️ 以上数据获取时间：[搜索日期]，实际收益因人而异
```
```

- [ ] **Step 2: Verify changes**

Search the modified file for hardcoded revenue values (月入, 首月预期, 分成XX%, 千字XX元) to ensure no revenue promises remain.

- [ ] **Step 3: Commit**

```bash
git add writing-workflow/skills/monetization-strategy/SKILL.md
git commit -m "fix(monetization-strategy): remove hardcoded revenue promises, enforce WebSearch-only policy"
```

---

## Chunk 2: Profit & Compliance Orientation in Outlines (Problem 2)

Inject profitability review, platform algorithm adaptation, and compliance pre-screening into outline and planning stages.

### Task 5: Add profitability review to outline-writing SKILL.md

**Files:**
- Modify: `writing-workflow/skills/outline-writing/SKILL.md:281-355` (大纲自检 + 质量标准)

- [ ] **Step 1: Replace self-check and quality standards with profit-aware version**

In `writing-workflow/skills/outline-writing/SKILL.md`, replace lines 281-355 (from `### 7. 内嵌自检` through `| 差异化 | 有独特的卖点 |`) with:

```markdown
### 7. 内嵌自检（含盈利维度）

生成大纲后执行自检：

```
大纲自检报告：

一、世界观与设定完整性
✓ 主要区域已定义
✓ 势力关系清晰
✓ 规则法则明确

二、人物设定
✓ 主角成长线完整
✓ 配角作用明确
✓ 人物关系清晰

三、情节逻辑
✓ 主线清晰
✓ 冲突合理
✓ 高潮设计到位

四、盈利适配检查（新增）
□ 付费卡点预设：大纲中是否标注了建议的VIP上架位置？
  - 付费起始章应设置在重大悬念/高潮前
  - 免费部分是否足够让读者"上钩"？
□ 爽点商业价值：爽点是否与平台核心指标对齐？
  - 起点：爽点是否能产生"停留20秒+"的沉浸感？
  - 番茄：爽点是否在每800字内出现以维持完读率？
  - 晋江：情感高潮是否足以引发评论区讨论？
□ 章末钩子密度：每章结尾是否预设了钩子类型？
□ 短剧/IP 适配：是否有强视觉冲突场景？是否可拆分为独立单元？

五、平台合规预检（新增）
□ AI 参与度预估：大纲阶段的 AI 使用是否在路径 A（平台安全）范围内？
□ 政策红线：是否涉及平台禁止的题材元素？
□ 原创性：核心创意是否有足够的差异化，不会被认定为"套路化"？

⚠ 需要确认
  - [某设定]是否符合预期？
```

### 8. 调用质量审查

调用 quality-review skill 进行大纲质量审查。

### 9. 用户确认

使用AskUserQuestion确认大纲：

```
大纲生成完成！

主要内容包括：
- 世界观设定：[简要描述]
- 主角设定：[简要描述]
- 分卷规划：[卷数]卷
- 建议VIP上架位置：第[X]章（[理由]）

请选择：
1. 确认大纲，继续下一步
2. 查看详细大纲
3. 修改部分内容
4. 重新生成大纲
```

### 10. 更新工作流状态

```json
{
  "current_stage": "chapter_outline",
  "completed_stages": [..., "outline_writing"],
  "files": {
    ...
    "outline": "novel-project/05-outline.md",
    "characters": "novel-project/08-characters/",
    "character_relationships": "novel-project/08-characters/character-relationships.md",
    "worldbuilding": "novel-project/09-worldbuilding/"
  }
}
```

## 大纲质量标准

| 维度 | 要求 |
|------|------|
| 完整性 | 所有设定文件齐全 |
| 逻辑性 | 无自相矛盾的设定 |
| 可执行性 | 能指导细纲和正文生成 |
| 节奏感 | 爽点分布合理 |
| 差异化 | 有独特的卖点 |
| **盈利适配** | **付费卡点已预设，爽点与平台指标对齐** |
| **合规预检** | **无政策红线，AI参与度在安全范围** |
```

- [ ] **Step 2: Add 付费卡点 field to outline template**

In the same file, in the `### 第一卷：[卷名]` section (around line 246-258), add a `#### 付费策略` subsection after `#### 人物发展`:

Find:
```markdown
#### 人物发展
- 主角：[本卷发展]
- 配角：[本卷发展]
```

Replace with:
```markdown
#### 人物发展
- 主角：[本卷发展]
- 配角：[本卷发展]

#### 付费策略预设
- 建议VIP上架章节：第[X]章
- 上架理由：[此处有重大悬念/高潮，读者付费意愿最高]
- 免费部分钩子：[最后一个免费章的悬念设计]
```

- [ ] **Step 3: Verify changes**

Read the modified file and confirm sections 7-10 and quality table are intact, with the new 盈利适配 and 合规预检 dimensions present.

- [ ] **Step 4: Commit**

```bash
git add writing-workflow/skills/outline-writing/SKILL.md
git commit -m "feat(outline-writing): add profitability review and compliance pre-check to outline stage"
```

### Task 6: Add platform algorithm adaptation to chapter-outline SKILL.md

**Files:**
- Modify: `writing-workflow/skills/chapter-outline/SKILL.md:74-129` (细纲模板)
- Modify: `writing-workflow/skills/chapter-outline/SKILL.md:131-150` (连贯性检查)
- Modify: `writing-workflow/skills/chapter-outline/SKILL.md:187-195` (细纲质量标准)

- [ ] **Step 1: Add platform-specific fields to chapter outline template**

In `writing-workflow/skills/chapter-outline/SKILL.md`, find the chapter outline template (lines 78-129). After line 129 (the closing code fence ` ``` ` of the template), add a new section:

```markdown
## 平台算法适配（新增）

### 目标平台：[从workflow-state读取]

#### 番茄适配检查
- [ ] 前300字是否有冲突/异常事件？
- [ ] 每800字是否设置了微型悬念？
- [ ] 章节长度是否控制在2000-2500字？
- [ ] 章节标题是否有吸引力（悬念型/反转型）？

#### 起点适配检查
- [ ] VIP章开头是否有即时回报（非过渡/回顾）？
- [ ] 章内是否有让读者停留20秒+的沉浸点？
- [ ] 是否有"值回票价"的场景？

#### 晋江适配检查
- [ ] 情感描写是否有层次？
- [ ] 角色是否有独特魅力展现？
- [ ] 章末是否有引发读者讨论的话题？

> 以上检查项根据 workflow-state.json 中的 platform 字段自动选择对应平台。
```

- [ ] **Step 2: Enhance consistency check with platform and profit dimensions**

Replace lines 131-150 (the `### 5. 连贯性检查` section) with:

```markdown
### 5. 多维度检查

每批生成后检查：

```
多维度检查报告：

一、与大纲一致性
  - 情节走向符合大纲规划：[是/否]
  - 人物发展符合设定：[是/否]
  - VIP上架点设计已落实：[是/否]

二、章节间连贯性
  - 时间线连续：[是/否]
  - 场景转换合理：[是/否]
  - 情绪过渡自然：[是/否]

三、平台算法适配（新增）
  - [平台名]核心指标已覆盖：[是/否]
  - 爽点密度符合平台要求：[是/否]
  - 章末钩子设计完整：[是/否]

四、盈利节点检查（新增）
  - 付费卡点章节内容是否足够吸引：[是/否]
  - 免费最后章钩子强度：[强/中/弱]

⚠ 发现问题
  - 第X章与第Y章存在[问题]
  - 建议调整：[建议]
```
```

- [ ] **Step 3: Update quality standards table**

Replace lines 187-195 (the `## 细纲质量标准` section) with:

```markdown
## 细纲质量标准

| 维度 | 要求 |
|------|------|
| 详细程度 | 能指导正文生成 |
| 一致性 | 与大纲、人物设定一致 |
| 连贯性 | 前后章节连贯 |
| 爽点分布 | 符合节奏规划 |
| 可执行性 | 场景、对话具体 |
| **平台适配** | **符合目标平台算法核心指标** |
| **盈利设计** | **付费卡点、钩子已预设** |
```

- [ ] **Step 4: Verify changes**

Read the modified file and confirm:
- Platform adaptation section is outside (after) the code fence template, not inside it
- Quality standards table includes the two new rows
- Consistency check section has 4 dimensions (大纲一致性, 连贯性, 平台适配, 盈利节点)

- [ ] **Step 5: Commit**

```bash
git add writing-workflow/skills/chapter-outline/SKILL.md
git commit -m "feat(chapter-outline): add platform algorithm adaptation and profit checkpoints"
```

### Task 7: Add profitability awareness to creation-planning SKILL.md

**Files:**
- Modify: `writing-workflow/skills/creation-planning/SKILL.md:96-121` (大纲生成指导)

- [ ] **Step 1: Add platform-driven rhythm guidance**

In `writing-workflow/skills/creation-planning/SKILL.md`, replace lines 96-121 (from `### 4. 大纲生成指导` through `2. 调整（请说明需要调整的部分）`) with:

```markdown
### 4. 大纲生成指导

确认大纲生成的指导原则：

```
大纲生成指导原则：

1. 节奏控制（基于目标平台）
   - 爽点频率：每3-5章一个爽点
   - 高潮间隔：每卷一个大高潮
   - 铺垫比例：20%铺垫 + 80%推进

2. 平台算法适配（新增）
   - 番茄：每章前300字必须有冲突，每800字设微型悬念，章节≤2500字
   - 起点：VIP章开头必须有即时回报，章内设"沉浸点"（停留20秒+）
   - 晋江：情感描写要有层次，章末设讨论话题
   - 七猫：节奏稳健，情节密集，通俗易懂
   > 以上为各平台写法要点概要，正文生成阶段会进行详细适配

3. 付费模型意识（新增）
   - VIP上架预估：约在第[X]章（基于平台惯例和故事节奏）
   - 免费部分目标：让读者"上钩"，积累足够追读基数
   - 付费首章：必须立刻给出回报，不能继续吊胃口
   - 付费后爽点密度：应高于免费部分

4. 人物发展
   - 主角成长线：[基于题材的建议]
   - 配角出场频率：主要配角每5章出场
   - 感情线进度：[基于题材的建议]

5. 世界观展开
   - 信息释放：循序渐进，避免信息倾倒
   - 地图扩展：随剧情逐步开放新地图
   - 力量体系：[基于题材的建议]

是否接受以上指导原则？
1. 接受
2. 调整（请说明需要调整的部分）
```
```

- [ ] **Step 2: Verify changes**

Read the modified file and confirm the 大纲生成指导 section now includes 5 items (节奏控制, 平台算法适配, 付费模型意识, 人物发展, 世界观展开).

- [ ] **Step 3: Commit**

```bash
git add writing-workflow/skills/creation-planning/SKILL.md
git commit -m "feat(creation-planning): add platform algorithm adaptation and monetization awareness"
```

---

## Chunk 3: Outline Adherence Enforcement (Problem 3)

Add structured enforcement mechanisms to prevent content generation from drifting 30%+ from outlines.

### Task 8: Add scene-by-scene adherence tracking to content-generation SKILL.md

**Files:**
- Modify: `writing-workflow/skills/content-generation/SKILL.md:58-116` (生成正文 + 内嵌自检)

- [ ] **Step 1: Replace loose self-check with structured scene-by-scene verification**

In `writing-workflow/skills/content-generation/SKILL.md`, replace lines 90-116 (from `### 5. 内嵌自检` through the end of the self-check section) with:

```markdown
### 5. 内嵌自检（逐场景对照）

生成后执行逐场景对照自检：

```
正文自检报告：

一、字数达标
  - 目标：[目标]字
  - 实际：[实际]字
  - 状态：[达标/不达标]

二、细纲场景逐项对照（核心检查）

| 细纲场景 | 正文是否覆盖 | 偏离描述 | 偏离程度 |
|----------|-------------|---------|---------|
| 场景一：[细纲中的场景名] | ✅ 已覆盖 / ❌ 缺失 / ⚠️ 偏离 | [如有偏离，描述差异] | 无/轻微/中等/严重 |
| 场景二：[细纲中的场景名] | ✅/❌/⚠️ | [描述] | [程度] |
| ... | ... | ... | ... |

场景覆盖率：[已覆盖数]/[细纲总场景数] = [百分比]%

三、新增内容检查（细纲中没有但正文中出现的）

| 新增内容 | 合理性 | 是否需要回溯更新细纲 |
|---------|--------|-------------------|
| [描述] | 合理/不合理 | 是/否 |

四、偏离度综合评估

偏离度 = (缺失场景数 + 严重偏离场景数) / 细纲总场景数

| 偏离度 | 判定 | 处理 |
|--------|------|------|
| ≤10% | ✅ 合格 | 继续 |
| 10%-20% | ⚠️ 警告 | 提示用户确认偏离是否合理，建议修正 |
| 20%-30% | 🔴 严重 | 必须修正或重新生成，不允许直接通过 |
| >30% | 🚫 不合格 | 强制重新生成，当前版本不保存为正式稿 |

本章偏离度：[X]% — [判定结果]

五、人物一致性
  - 行为符合人设：[是/否，列出问题]
  - 对话风格一致：[是/否，列出问题]

六、前后文连贯
  - 承接自然：[是/否]
  - 无矛盾：[是/否，列出矛盾]
```
```

- [ ] **Step 2: Add deviation handling to user confirmation flow**

In the same file, replace lines 124-140 (from the `### 7. 用户确认` header through the end of the confirmation block) with:

```markdown
### 7. 用户确认

根据偏离度不同，展示不同的确认选项：

**偏离度 ≤10%（合格）**：
```
第X章正文生成完成！

章节信息：
- 字数：[字数]字
- 场景覆盖率：[X]%
- 偏离度：[X]%（合格）

请选择：
1. 确认，继续下一章
2. 查看正文内容
3. 修改本章内容
4. 重新生成
```

**偏离度 10%-20%（警告）**：
```
⚠️ 第X章正文与细纲存在偏离

偏离详情：
- [偏离场景1描述]
- [偏离场景2描述]

请选择：
1. 偏离合理，确认并继续
2. 修正偏离部分
3. 重新生成
```

**偏离度 >20%（严重/不合格）**：
```
🚫 第X章正文与细纲严重偏离（偏离度：[X]%）

偏离详情：
- [缺失场景列表]
- [严重偏离场景列表]

必须处理后才能继续：
1. 重新生成（推荐）
2. 修正偏离部分
3. 更新细纲以匹配正文（需说明理由）
```

> 注意：偏离度>20%时，**不提供"忽略并继续"选项**。
```

- [ ] **Step 3: Verify changes**

Read the modified file and confirm:
- Self-check section includes 逐场景对照 table with 偏离度 calculation
- User confirmation section has 3 tiers (合格/警告/严重) with no "忽略并继续" option for >20%
- The fields `场景覆盖率` and `偏离度` are present (these are referenced by quality-review)

- [ ] **Step 4: Commit**

```bash
git add writing-workflow/skills/content-generation/SKILL.md
git commit -m "feat(content-generation): add scene-by-scene adherence tracking with deviation thresholds"
```

---

## Chunk 4: Quality Review Overhaul (Problem 4)

Replace lenient quality review with rigorous scoring, independent review, and removal of bypass options.

### Task 9: Overhaul quality-review SKILL.md scoring system

**Files:**
- Modify: `writing-workflow/skills/quality-review/SKILL.md:108-146` (正文审查)
- Modify: `writing-workflow/skills/quality-review/SKILL.md:178-192` (用户确认)
- Modify: `writing-workflow/skills/quality-review/SKILL.md:215-233` (质量标准)

- [ ] **Step 1: Replace star-based scoring with weighted numerical scoring**

In `writing-workflow/skills/quality-review/SKILL.md`, replace lines 108-146 (the `#### 正文审查` section) with:

```markdown
#### 正文审查

```
## 正文质量审查报告

### 评分体系（100分制，60分及格）

| 维度 | 权重 | 得分 | 扣分明细 |
|------|------|------|---------|
| 细纲一致性 | 25% | [X]/25 | [场景覆盖率：X%，偏离度：X%，引用content-generation自检报告] |
| 人物一致性 | 15% | [X]/15 | [具体问题列表] |
| 前后文连贯 | 15% | [X]/15 | [具体矛盾列表] |
| 平台算法适配 | 20% | [X]/20 | [平台核心指标检查结果] |
| AI痕迹程度 | 15% | [X]/15 | [逐段检测结果] |
| 文学质量 | 10% | [X]/10 | [句式、描写、对话检查结果] |
| **总分** | **100%** | **[X]/100** | |

### 评分标准

| 总分 | 判定 | 处理 |
|------|------|------|
| ≥80 | ✅ 优秀 | 直接通过 |
| 60-79 | ⚠️ 合格 | 列出优化建议，用户可选择优化或通过 |
| 40-59 | 🔴 不合格 | 必须修改后重新审查 |
| <40 | 🚫 严重不合格 | 必须重新生成 |

### 连贯性审查
[具体检查结果，列出每个发现的问题]

### 人物审查
[具体检查结果，逐人物对照设定]

### 文风审查
[具体检查结果，对照平台风格要求]

### AI痕迹审查（逐段检测）

| 段落位置 | 痕迹类型 | 原文摘录 | 问题描述 | 修改建议 |
|----------|---------|---------|---------|---------|
| 第X段 | [类型] | "[原文前20字...]" | [问题] | [建议] |
| ... | ... | ... | ... | ... |

AI痕迹统计：
- 检测段落总数：[X]
- 发现痕迹段落：[Y]
- 痕迹密度：[Y/X × 100]%
- 痕迹密度判定：[≤5%优秀 / 5-15%合格 / 15-30%需优化 / >30%不合格]
```
```

- [ ] **Step 2: Remove "忽略，继续下一步" option from user confirmation**

Replace lines 178-192 (the `### 5. 用户确认` section) with:

```markdown
### 5. 用户确认

根据审查得分展示不同选项：

**得分 ≥80（优秀）**：
```
质量审查完成！总分：[X]/100（优秀）

请选择：
1. 查看详细报告
2. 确认，继续下一步
3. 仍要优化（追求更高质量）
```

**得分 60-79（合格）**：
```
质量审查完成！总分：[X]/100（合格）

需优化项：
- [项目1]：[具体建议]
- [项目2]：[具体建议]

请选择：
1. 查看详细报告
2. 应用优化建议后重新审查
3. 确认当前质量，继续下一步
```

**得分 <60（不合格）**：
```
质量审查完成！总分：[X]/100（不合格）

必改项：
- [项目1]：[具体问题和修改方案]
- [项目2]：[具体问题和修改方案]

请选择：
1. 查看详细报告
2. 应用修改建议（推荐）
3. 手动修改后重新审查
```

> ⚠️ 不合格内容不提供"忽略并继续"选项。必须修改后重新审查达到60分以上才能继续。
```

- [ ] **Step 3: Update quality standards with explicit thresholds**

Replace lines 215-233 (the `## 质量标准` sections) with:

```markdown
## 质量标准（含明确阈值）

### 正文质量标准

| 维度 | 合格标准 | 不合格标准 |
|------|---------|-----------|
| 细纲一致性 | 场景覆盖率≥80%，偏离度≤20% | 场景覆盖率<80%或偏离度>20% |
| 人物一致性 | 无行为/对话与设定矛盾 | 存在明显矛盾 |
| 前后文连贯 | 无时间线/情节矛盾 | 存在矛盾 |
| 平台算法适配 | 平台核心指标检查≥80%通过 | 核心指标检查<60%通过 |
| AI痕迹 | 痕迹密度≤15% | 痕迹密度>30% |
| 文学质量 | 句式多样、感官描写丰富 | 句式单一、描写抽象 |

### 大纲质量标准
- 世界观完整，无矛盾
- 人物设定清晰
- 情节逻辑合理
- 节奏规划明确
- **盈利节点已预设**
- **平台合规预检通过**

### 细纲质量标准
- 与大纲一致
- 场景描述具体
- 人物行为合理
- 爽点设计到位
- **平台算法适配检查通过**
```

- [ ] **Step 4: Verify changes**

Read the modified file and confirm:
- Scoring uses 100-point system with 6 weighted dimensions
- 细纲一致性 dimension references `场景覆盖率` and `偏离度` from content-generation
- No "忽略，继续下一步" option exists for scores <60
- Quality standards have explicit合格/不合格 thresholds

- [ ] **Step 5: Commit**

```bash
git add writing-workflow/skills/quality-review/SKILL.md
git commit -m "feat(quality-review): overhaul to 100-point scoring with explicit thresholds, remove bypass option"
```

### Task 10: Add independent review mechanism to quality-review SKILL.md

**Files:**
- Modify: `writing-workflow/skills/quality-review/SKILL.md` (add new section at end)

- [ ] **Step 1: Add independent subagent review section**

At the end of `writing-workflow/skills/quality-review/SKILL.md`, add:

```markdown
## 独立审查机制

### 问题：自我审查偏差

同一个 AI 会话生成内容并审查自己的输出，存在"自我审查偏差"——倾向于对自己生成的内容评分偏高。

### 解决方案：使用独立 subagent 审查

正文审查阶段，**必须**使用 Agent 工具启动独立的审查 subagent：

```
审查流程：
1. 正文由当前会话生成
2. 调用 Agent 工具，启动新的 subagent 执行审查
3. subagent 加载细纲 + 正文 + 人物设定，独立执行评分
4. subagent 返回审查报告
5. 当前会话展示报告给用户
```

### subagent 审查 prompt 模板

```
你是一位独立的小说质量审查员。你没有参与这篇内容的创作，你的唯一任务是严格按标准评分。

审查对象：
- 正文文件：[路径]
- 对应细纲：[路径]
- 人物设定：[路径]
- 目标平台：[平台名称]

请按以下维度评分（100分制）：
1. 细纲一致性（25分）：逐场景对照，计算覆盖率和偏离度
2. 人物一致性（15分）：逐人物对照设定，检查行为和对话
3. 前后文连贯（15分）：检查时间线、情节、情绪连贯
4. 平台算法适配（20分）：检查[平台]核心指标
5. AI痕迹程度（15分）：逐段检测AI典型表达
6. 文学质量（10分）：句式多样性、感官描写、对话自然度

输出格式：严格按照 quality-review skill 中的"正文质量审查报告"格式输出。
不要手软，不要客气，发现问题直接指出。
```

### 审查一致性验证

如果主会话自检评分与独立 subagent 评分差异超过15分，以**较低分**为准，并标注"审查一致性差异"。
```

- [ ] **Step 2: Verify changes**

Read the end of the modified file and confirm the independent review section is properly added with subagent prompt template and consistency verification rule.

- [ ] **Step 3: Commit**

```bash
git add writing-workflow/skills/quality-review/SKILL.md
git commit -m "feat(quality-review): add independent subagent review mechanism"
```

### Task 11: Add quality gates to using-writing-workflow SKILL.md

**Files:**
- Modify: `writing-workflow/skills/using-writing-workflow/SKILL.md:137-153` (用户交互)

- [ ] **Step 1: Remove "跳过" option for quality-critical stages**

In `writing-workflow/skills/using-writing-workflow/SKILL.md`, replace lines 137-153 (the `### 3. 用户交互` section) with:

```markdown
### 3. 用户交互

每次阶段完成后，使用AskUserQuestion确认下一步：

**非质量关键阶段**（work_type_selection, platform_research, competitor_analysis, genre_selection, novel_confirmation, creation_planning）：
```
当前阶段：[阶段名称] 已完成

可选操作：
1. 继续下一阶段
2. 重新执行当前阶段
3. 跳过此阶段，进入下一阶段
4. 跳到指定阶段
5. 查看当前进度
6. 保存并退出
```

**质量关键阶段**（outline_writing, chapter_outline, content_generation, quality_review, human_ai_collaboration）：
```
当前阶段：[阶段名称] 已完成

质量检查结果：[通过/未通过]

可选操作：
1. 继续下一阶段（仅质量检查通过时可选）
2. 重新执行当前阶段
3. 查看质量审查报告
4. 手动修改后重新审查
5. 查看当前进度
6. 保存并退出
```

> ⚠️ 质量关键阶段不提供"跳过"选项。必须通过质量检查才能进入下一阶段。
> 唯一例外：短篇用户可跳过 platform_research 和 competitor_analysis。
```

- [ ] **Step 2: Verify changes**

Read the modified file and confirm:
- Non-critical stages have "跳过" option
- Critical stages (outline_writing, chapter_outline, content_generation, quality_review, human_ai_collaboration) do NOT have "跳过" option
- Quality check result is displayed for critical stages

- [ ] **Step 3: Commit**

```bash
git add writing-workflow/skills/using-writing-workflow/SKILL.md
git commit -m "feat(using-writing-workflow): add quality gates, remove skip for critical stages"
```

---

## Chunk 5: Cross-cutting Verification

### Task 12: Verify all changes are consistent

- [ ] **Step 1: Check no broken markdown across all modified files**

Read each modified file and verify:
- No unclosed code blocks
- No broken table formatting
- All section headers properly nested

Files to verify:
1. `writing-workflow/skills/platform-research/SKILL.md`
2. `writing-workflow/skills/genre-selection/SKILL.md`
3. `writing-workflow/skills/competitor-analysis/SKILL.md`
4. `writing-workflow/skills/monetization-strategy/SKILL.md`
5. `writing-workflow/skills/outline-writing/SKILL.md`
6. `writing-workflow/skills/chapter-outline/SKILL.md`
7. `writing-workflow/skills/creation-planning/SKILL.md`
8. `writing-workflow/skills/content-generation/SKILL.md`
9. `writing-workflow/skills/quality-review/SKILL.md`
10. `writing-workflow/skills/using-writing-workflow/SKILL.md`

- [ ] **Step 2: Check cross-references are valid**

Verify that:
- quality-review references to content-generation deviation data are consistent (field names: `场景覆盖率`, `偏离度`)
- chapter-outline platform adaptation fields match content-generation platform rules
- outline-writing profitability checks reference correct workflow-state fields
- using-writing-workflow quality gate stage list matches actual quality-critical stages
- human-ai-collaboration SKILL.md already outputs a pass/fail signal (A/B/C rating) compatible with the quality gate in using-writing-workflow

- [ ] **Step 3: Final commit**

```bash
git add -A
git commit -m "chore: verify cross-file consistency for writing workflow quality overhaul"
```
