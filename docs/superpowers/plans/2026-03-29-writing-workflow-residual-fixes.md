# Writing Workflow Residual Fixes Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fix all residual issues from the writing workflow quality overhaul — scoring inconsistencies, hardcoded data, flow contradictions, and markup errors.

**Architecture:** Pure SKILL.md file edits across 7 files. Each task is a self-contained fix to one file, with verification via grep to confirm no regressions. No code logic — only markdown/template content changes.

**Tech Stack:** Markdown (SKILL.md files), grep for verification

---

## File Map

| File | Responsibility | Change |
|------|---------------|--------|
| `writing-workflow/skills/quality-review/SKILL.md` | 质量审查评分 | Replace 4 star-rating remnants with 100-point equivalents |
| `writing-workflow/skills/opening-optimization/SKILL.md` | 黄金三章评分 | Migrate star-based report template to 100-point system |
| `writing-workflow/skills/using-writing-workflow/SKILL.md` | 工作流主控 | Fix PUA fallback contradiction + add quality gate max retries |
| `writing-workflow/skills/outline-writing/SKILL.md` | 大纲生成 | Fix broken nested code fence |
| `writing-workflow/skills/monetization-strategy/SKILL.md` | 变现策略 | Replace hardcoded revenue data with WebSearch templates |
| `writing-workflow/skills/launch-strategy/SKILL.md` | 上架发布 | Add data freshness warnings + WebSearch verification directives |
| `writing-workflow/skills/platform-research/SKILL.md` | 平台调研 | Fix remaining hardcoded value in contract guide |

---

## Chunk 1: Scoring System Unification + Flow Fixes

### Task 1: Fix quality-review star-rating remnants

**Files:**
- Modify: `writing-workflow/skills/quality-review/SKILL.md:70-80, 95-105, 175-185, 450-460`

- [ ] **Step 1: Replace star rating on line 76 (大纲审查)**

Replace the exact text:
```
**总体评分：★★★★☆**
```
with:
```
**总体评分：[X]/100**

| 得分区间 | 判定 |
|---------|------|
| ≥80 | 优秀，可继续 |
| 60-79 | 合格，建议优化 |
| <60 | 不合格，必须修改 |
```

- [ ] **Step 2: Replace star rating on line 103 (细纲审查)**

Replace the exact text:
```
**总体评分：★★★★★**
```
with:
```
**总体评分：[X]/100**
```

- [ ] **Step 3: Replace star rating on line 181 (用户确认模板)**

Replace the exact text:
```
## 总体评分
★★★★☆
```
with:
```
## 总体评分
[X]/100（[优秀/合格/不合格]）
```

- [ ] **Step 4: Replace star rating on line 456 (原创性报告)**

Replace the exact text:
```
总体评估：★★★☆☆
```
with:
```
总体评估：[X]/100（[判定]）
```

- [ ] **Step 5: Verify no star symbols remain**

Run: `grep -n "★" writing-workflow/skills/quality-review/SKILL.md`
Expected: No matches

- [ ] **Step 6: Commit**

```bash
git add writing-workflow/skills/quality-review/SKILL.md
git commit -m "fix: quality-review 统一为100分制，清除星级评分残留"
```

---

### Task 2: Migrate opening-optimization to 100-point scoring

**Files:**
- Modify: `writing-workflow/skills/opening-optimization/SKILL.md:259-289`

- [ ] **Step 1: Replace the entire 黄金三章总检报告 template (lines 259-289)**

Replace the exact block from `## 黄金三章总检报告` through the closing ` ``` ` (line 289) with:

````
## 黄金三章总检报告

```
黄金三章优化报告（100分制）

第一章：生死时速（满分40分）
- 首段钩子：[X]/10 [评价]
- 人设立体：[X]/10 [评价]
- 冲突爆发：[X]/10 [评价]
- 章末悬念：[X]/10 [评价]

第二章：世界观渗透（满分30分）
- 设定渗透：[X]/10 [评价]
- 金手指预埋：[X]/10 [评价]
- 情绪曲线：[X]/10 [评价]

第三章：付费转化（满分30分）
- 能力显化：[X]/10 [评价]
- 首战打脸：[X]/10 [评价]
- 认知颠覆：[X]/10 [评价]

总分：[X]/100

| 得分区间 | 判定 | 处理 |
|---------|------|------|
| ≥80 | 优秀 | 可直接发布 |
| 60-79 | 合格 | 建议优化后发布 |
| <60 | 不合格 | 必须修改后重新审查 |

修改建议：
1. [第一章问题]：[修改建议]
2. [第二章问题]：[修改建议]
3. [第三章问题]：[修改建议]

平台过审概率：[高/中/低]
付费转化预期：[高/中/低]
```
````

- [ ] **Step 2: Verify no star symbols remain**

Run: `grep -n "★" writing-workflow/skills/opening-optimization/SKILL.md`
Expected: No matches

- [ ] **Step 3: Commit**

```bash
git add writing-workflow/skills/opening-optimization/SKILL.md
git commit -m "fix: opening-optimization 迁移到100分制评分体系"
```

---

### Task 3: Fix PUA fallback contradiction + add quality gate max retries

**Files:**
- Modify: `writing-workflow/skills/using-writing-workflow/SKILL.md:91-103, 154-170`

- [ ] **Step 1: Fix PUA fallback to respect quality gates (lines 91-103)**

Locate the `### 降级规则（pua Skill 不存在时）` heading (line 91). Replace from that heading through the line `不抛出错误，不尝试调用不存在的 Skill。` (line 103). The old text spans lines 91-103 and contains: the heading, a paragraph ending with `：`, a code-fenced block with 3 options, and the `不抛出错误` line outside the fence.

with:

````
### 降级规则（pua Skill 不存在时）

若 `pua:pua` 不可用（未安装 superpowers 或相关插件），**跳过该分支**，改为直接向用户说明。

**非质量关键阶段**（work_type_selection, platform_research, competitor_analysis, genre_selection, novel_confirmation, creation_planning）：
```
当前阶段遇到困难，需要您决定下一步：

1. 重新尝试（Claude 使用不同方式重试）
2. 跳过此阶段，进入下一阶段
3. 退出工作流，稍后继续
```

**质量关键阶段**（outline_writing, chapter_outline, content_generation, quality_review, human_ai_collaboration）：
```
当前阶段遇到困难，需要您决定下一步：

1. 重新尝试（Claude 使用不同方式重试）
2. 手动修改后重新审查
3. 保存当前进度，稍后继续
```

> ⚠️ 质量关键阶段不提供"跳过"选项，与质量门禁规则保持一致。

不抛出错误，不尝试调用不存在的 Skill。
````

- [ ] **Step 2: Add max retry limit to quality gate section (after line 169)**

After the line:
```
> ⚠️ 质量关键阶段不提供"跳过"选项。必须通过质量检查才能进入下一阶段。
```

Insert:
```
> ⚠️ 质量门禁最大重试次数：同一阶段连续3次未通过质量检查后，暂停工作流并提示用户：
>
> ```
> 当前阶段已连续3次未通过质量检查。建议：
> 1. 查看历次审查报告，分析共性问题
> 2. 手动大幅修改后重新提交
> 3. 保存进度，寻求外部帮助后继续
> ```
```

- [ ] **Step 3: Verify no unguarded "跳过" in quality-critical context**

Run: `grep -n "跳过" writing-workflow/skills/using-writing-workflow/SKILL.md`
Expected: "跳过" only appears in non-quality-critical contexts (PUA non-critical fallback, 非关键阶段 options, line 170 短篇例外)

- [ ] **Step 4: Commit**

```bash
git add writing-workflow/skills/using-writing-workflow/SKILL.md
git commit -m "fix: PUA降级区分质量关键阶段，添加质量门禁最大重试次数"
```

---

### Task 4: Fix outline-writing broken code fence

**Files:**
- Modify: `writing-workflow/skills/outline-writing/SKILL.md:107-124`

- [ ] **Step 1: Fix the nested code fence**

The problem: Line 107 opens ` ```markdown `, line 112 has a premature ` ``` ` that closes it too early, leaving lines 113-124 outside the code block.

Replace the block from line 107 to line 124:
````
```markdown
# 人物关系图

## 关系总览

```
主角 [姓名]
├── 友情/师徒
│   ├── [配角A]：[关系描述，如"结义兄弟，共同成长"]
│   └── [配角B]：[关系描述，如"师父，传授主角核心技艺"]
├── 感情线
│   └── [女主/男主]：[关系描述，如"青梅竹马，历经磨难"]
├── 对立/敌对
│   ├── [反派A]：[冲突原因，如"夺取主角传承"]
│   └── [反派B]：[冲突原因，如"家仇"]
└── 中立/复杂
    └── [配角C]：[关系描述，如"亦敌亦友，立场多变"]
```
````

with a single properly-closed block that preserves the file headings but removes the problematic inner fence:

````
```
# 人物关系图

## 关系总览

主角 [姓名]
├── 友情/师徒
│   ├── [配角A]：[关系描述，如"结义兄弟，共同成长"]
│   └── [配角B]：[关系描述，如"师父，传授主角核心技艺"]
├── 感情线
│   └── [女主/男主]：[关系描述，如"青梅竹马，历经磨难"]
├── 对立/敌对
│   ├── [反派A]：[冲突原因，如"夺取主角传承"]
│   └── [反派B]：[冲突原因，如"家仇"]
└── 中立/复杂
    └── [配角C]：[关系描述，如"亦敌亦友，立场多变"]
```
````

The fix: Replace ` ```markdown ` with plain ` ``` `, remove the premature inner ` ``` ` on old line 112. The `# 人物关系图` and `## 关系总览` headings are preserved as they are part of the generated file template.

- [ ] **Step 2: Verify no orphaned code fences in the area**

Run: `grep -n '^\`\`\`' writing-workflow/skills/outline-writing/SKILL.md`
Expected: All code fences properly paired (even count of ``` lines)

- [ ] **Step 3: Commit**

```bash
git add writing-workflow/skills/outline-writing/SKILL.md
git commit -m "fix: outline-writing 修复人物关系图代码围栏嵌套问题"
```

---

## Chunk 2: Hardcoded Data Cleanup

### Task 5: Clean monetization-strategy hardcoded revenue data

**Files:**
- Modify: `writing-workflow/skills/monetization-strategy/SKILL.md:78-257`

- [ ] **Step 1: Replace 变现目标 section (lines 78-101)**

Replace the exact block from `### 1. 确认变现目标` through the closing ` ``` ` with:

````
### 1. 确认变现目标

> ⚠️ 以下收益区间为方向性分类，不代表收益承诺。实际收益因平台、题材、更新频率等因素差异极大。

使用AskUserQuestion确认：

```
请确认您的变现目标方向：

1. 稳健起步型（新人推荐）
   - 策略：全勤+稳定更新+基础数据积累
   - 适合：首次创作，积累经验

2. 数据增长型
   - 策略：数据优化+推荐位竞争+粉丝运营
   - 适合：有一定经验，追求增长

3. 全力冲刺型
   - 策略：极致内容+全渠道运营+IP布局
   - 适合：全力以赴冲击头部

请选择：
```
````

- [ ] **Step 2: Replace VIP上架时机 section (lines 103-131)**

Replace the exact block from `### 2. VIP上架时机决策` through `VIP上架检查清单` closing ` ``` ` with:

````
### 2. VIP上架时机决策

> ⚠️ 以下上架策略为通用框架。具体数据门槛（收藏数、追读数、字数要求）请通过 WebSearch 搜索"[平台名称] VIP上架条件 {当前年份}"获取最新标准。

#### 起点VIP上架

```
VIP上架策略框架：

标准方案：积累足够免费章节后进入VIP
- 搜索最新签约字数门槛：WebSearch "[平台] VIP上架 字数要求 {当前年份}"
- 关注核心指标：收藏数、日追读、评论区活跃度

激进方案：数据特别好时提前上架
- 风险：免费读者流失
- 收益：提前开始获得订阅收入
- 需确认数据远超平台平均线

保守方案：长线积累后上架
- 积累大量免费读者
- 上架时首订数据更好
- 适合长线运营

VIP上架检查清单：
□ 收藏数达到平台建议门槛
□ 日追读达到平台建议门槛
□ 存稿够支撑上架后30天日更
□ 上架点在重大剧情高潮/悬念处
□ 免费最后一章设置强力钩子
```
````

- [ ] **Step 3: Replace 番茄模式 section (lines 133-152)**

Replace the exact block from `#### 番茄模式（无需VIP决策）` through closing ` ``` ` with:

````
#### 番茄模式（无需VIP决策）

> ⚠️ 番茄收益机制经常调整。执行前请 WebSearch 搜索"番茄小说 收益机制 {当前年份}"获取最新政策。

```
番茄收益优化重点：

1. 字数优化
   - 总字数越多，广告展示越多，收益越高
   - 搜索最新完读奖门槛：WebSearch "番茄小说 完读奖 字数要求 {当前年份}"

2. 完读率优化
   - 完读率直接影响推荐量
   - 搜索最新推荐阈值：WebSearch "番茄小说 完读率 推荐标准 {当前年份}"

3. 追更人数优化
   - 搜索最新揽星计划门槛：WebSearch "番茄小说 揽星计划 条件 {当前年份}"
   - 每日稳定更新是保持追更的关键
```
````

- [ ] **Step 4: Replace 全勤奖策略 section (lines 185-207)**

Replace the exact block from `### 4. 全勤奖策略` through line 207 (the line before `### 5.`) with:

````
### 4. 全勤奖策略

> ⚠️ 全勤政策频繁调整。执行前必须 WebSearch 搜索"[平台] 全勤奖 最新政策 {当前年份}"。

```
全勤奖调研模板：

对每个目标平台搜索：
- "[平台] 全勤奖 字数要求 {当前年份}"
- "[平台] 全勤奖 金额 最新 {当前年份}"
- "[平台] 全勤 额外奖励 {当前年份}"

将搜索结果填入：
| 平台 | 字数要求 | 全勤奖金 | 额外奖励 | 数据来源 |
|------|----------|----------|----------|----------|
| [平台名] | [搜索结果] | [搜索结果] | [搜索结果] | [URL] |

⚠️ 以上数据获取时间：[搜索日期]，平台政策可能随时调整

全勤保障策略：
1. 存稿池始终保持 >= 7天余量
2. 设置每日更新提醒
3. 准备"应急章节"（2-3章质量较好的存稿）
4. 特殊情况提前请假（部分平台支持）
```
````

- [ ] **Step 5: Replace IP衍生策略 section (lines 229-257)**

Replace the exact block from `### 6. IP衍生策略` through `反转密度是否足够？` closing ` ``` ` with:

````
### 6. IP衍生策略

> ⚠️ IP衍生市场变化快。以下为策略框架，具体版权费范围请通过 WebSearch 获取最新行情。

```
IP衍生路径：

1. 短剧改编（当前热门方向）
   - 搜索最新行情：WebSearch "网文短剧改编 版权费 {当前年份}"
   - 建议：创作时就考虑短剧化结构（单元剧、强冲突、快节奏）

2. 有声书
   - 搜索最新行情：WebSearch "网文有声书 版权授权 {当前年份}"
   - 建议：对话多的作品更适合

3. 漫画改编
   - 搜索最新行情：WebSearch "网文漫画改编 版权费 {当前年份}"
   - 适合：人设鲜明、画面感强的作品

4. 影视改编
   - 搜索最新行情：WebSearch "网文影视改编 版权费 {当前年份}"
   - 门槛最高，需要作品有相当影响力

短剧适配检查：
□ 每2万字是否可独立成篇？
□ 是否有强视觉冲突场景？
□ 对话是否适合台词化？
□ 反转密度是否足够？
```
````

- [ ] **Step 6: Verify no hardcoded monetary amounts or numeric thresholds remain in execution flow**

Run:
```bash
grep -nE "[0-9]+(万字|万元|元/月|元)" writing-workflow/skills/monetization-strategy/SKILL.md
```
Expected: No matches. All specific monetary values and word-count thresholds in the execution flow (lines 78-257) should have been replaced with WebSearch templates.

Additional check:
```bash
grep -nE "[0-9]+%" writing-workflow/skills/monetization-strategy/SKILL.md
```
Expected: No matches in execution flow section. Percentage thresholds (完读率 15% etc.) should now use WebSearch directives.

- [ ] **Step 7: Commit**

```bash
git add writing-workflow/skills/monetization-strategy/SKILL.md
git commit -m "fix: monetization-strategy 清除执行流程硬编码收益数据，改为WebSearch模板"
```

---

### Task 6: Add data freshness directives to launch-strategy

**Files:**
- Modify: `writing-workflow/skills/launch-strategy/SKILL.md:47-67, 275-282`

- [ ] **Step 1: Add WebSearch verification directive to stockpiling table (before line 47)**

Before the line `**各平台存稿要求**：`, insert:

```
> ⚠️ 以下存稿数据为历史参考值。执行前必须通过 WebSearch 搜索"[平台] 签约字数要求 {当前年份}"和"[平台] 首秀规则 {当前年份}"核实最新门槛。若搜索结果与下表不符，以搜索结果为准。

```

- [ ] **Step 2: Add WebSearch verification directive to S/A/B/C tier table (before line 275)**

Before the line `首秀数据达标线：`, insert:

```
> ⚠️ 以下达标线为历史参考值，番茄算法经常调整。执行前必须 WebSearch 搜索"番茄小说 首秀 数据达标 {当前年份}"核实最新标准。

```

- [ ] **Step 3: Add WebSearch directive to the signing flow calculation (before line 56)**

Before the line `**存稿计算公式**：`, insert:

```
> 计算前请先通过 WebSearch 确认目标平台的最新签约字数门槛和推荐期天数。

```

- [ ] **Step 4: Verify directives are in place**

Run: `grep -n "WebSearch" writing-workflow/skills/launch-strategy/SKILL.md`
Expected: At least 4 WebSearch references (original line 39 + 3 new ones)

- [ ] **Step 5: Commit**

```bash
git add writing-workflow/skills/launch-strategy/SKILL.md
git commit -m "fix: launch-strategy 为硬编码平台数据添加WebSearch验证指令"
```

---

### Task 7: Fix platform-research remaining hardcoded value

**Files:**
- Modify: `writing-workflow/skills/platform-research/SKILL.md:456-470`

- [ ] **Step 1: Replace hardcoded value on line 463**

Replace:
```
| 七猫小说 | 保底+分成 | 保底千字20-500元 | 保底有保障，但需注意版权条款 |
```
with:
```
| 七猫小说 | 保底+分成 | 保底千字价格因作品而异（需搜索最新政策） | 保底有保障，但需注意版权条款 |
```

- [ ] **Step 2: Add disclaimer to contract guide examples (before `### 陷阱一：版权归属陷阱` heading)**

Before the `### 陷阱一：版权归属陷阱` heading (line 268 in source, the first trap), insert:

```
> 以下合同条款示例中的具体金额（如违约金数额、分成比例等）仅为**说明性示例**，用于帮助理解陷阱模式，不代表任何平台的实际标准。签约前请以平台实际合同条款为准。

```

- [ ] **Step 3: Verify the fix**

Run: `grep -n "千字20-500" writing-workflow/skills/platform-research/SKILL.md`
Expected: No matches

- [ ] **Step 4: Commit**

```bash
git add writing-workflow/skills/platform-research/SKILL.md
git commit -m "fix: platform-research 清除合同指南中残留硬编码数据"
```

---

## Chunk 3: Cross-Cutting Verification

### Task 8: Full cross-cutting verification

**Files:**
- Read-only verification across all 7 modified files

- [ ] **Step 1: Verify no star symbols in scoring files**

Run:
```bash
grep -rn "★" writing-workflow/skills/quality-review/SKILL.md writing-workflow/skills/opening-optimization/SKILL.md
```
Expected: No matches

- [ ] **Step 2: Verify no unguarded skip options in quality-critical stages**

Run:
```bash
grep -B2 -A2 "跳过" writing-workflow/skills/using-writing-workflow/SKILL.md
```
Expected: Every "跳过" occurrence must appear in one of these contexts only:
- PUA fallback for **非质量关键阶段**
- 非质量关键阶段 user options (line ~148)
- 短篇例外 note (line ~170)
- 阶段跳转规则 section for non-critical stages

Must NOT appear in quality-critical stage options or PUA quality-critical fallback.

- [ ] **Step 3: Verify monetization-strategy has no hardcoded revenue amounts**

Run:
```bash
grep -nE "[0-9]+(万字|万元|元/月|元)" writing-workflow/skills/monetization-strategy/SKILL.md
```
Expected: No matches

Additional:
```bash
grep -nE "[0-9]+%" writing-workflow/skills/monetization-strategy/SKILL.md
```
Expected: No matches in execution flow (lines 78+)

- [ ] **Step 4: Verify launch-strategy has WebSearch directives**

Run:
```bash
grep -c "WebSearch" writing-workflow/skills/launch-strategy/SKILL.md
```
Expected: >= 4

- [ ] **Step 5: Verify platform-research hardcoded value removed**

Run:
```bash
grep -n "千字20-500" writing-workflow/skills/platform-research/SKILL.md
```
Expected: No matches

- [ ] **Step 6: Verify outline-writing fences are balanced**

Run:
```bash
awk '/^```/{c++} END{if(c%2!=0) print "UNBALANCED: "c" fences"; else print "OK: "c" fences (balanced)"}' writing-workflow/skills/outline-writing/SKILL.md
```
Expected: "OK: N fences (balanced)"

- [ ] **Step 7: Final git status check**

Run: `git status`
Expected: Clean working tree (all changes committed)
