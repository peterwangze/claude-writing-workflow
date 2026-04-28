# 写作工作流插件审查与修复实施计划

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax.

**Goal:** 修复插件审查中发现的 P0 阻塞性问题和 P1 高风险问题，统一阈值标准，补齐短篇路径和正文看护链路的缺口。

**Architecture:** 按优先级分批修复 —— P0 先修阈值冲突（content-generation 和 quality-review 的统一），P1 再修结构性缺口（短篇路径、agent 看护、合规闸门去重），P2 最后修体验问题。

**Tech Stack:** Markdown SKILL.md 文件编辑，项目管理通过 git 追踪。

---

## 发现的问题清单

### P0 阻塞性问题

| # | 问题 | 位置 | 详情 |
|---|------|------|------|
| P0-1 | 偏离度阈值双重标准 | content-generation/SKILL.md:214-242 | 自检分级用 10%/20%/30% 三级，但硬失败用 >15%。15%-20% 区间既被标记为"警告"又被标记为"硬失败" |
| P0-2 | 场景覆盖率标准冲突 | quality-review/SKILL.md:122 vs :273 | 硬门槛写 <90% 不通过，但质量标准表写 ≥80% 合格。80%-90% 区间存在两个标准 |
| P0-3 | 偏离度标准冲突 | quality-review/SKILL.md:123 vs :273 | 硬门槛写 >15% 不通过，但质量标准表写 ≤20% 合格。15%-20% 区间冲突 |

### P1 高风险问题

| # | 问题 | 位置 | 详情 |
|---|------|------|------|
| P1-1 | 短篇路径平台算法适配缺失 | content-generation/SKILL.md | platform="公众号/短篇平台" 时，平台算法适配检查无法匹配任何已知规则 |
| P1-2 | context card 与看护包字段偏移 | chapter-outline/SKILL.md vs content-generation/SKILL.md | 两个 Skill 独立定义 context card 和看护包结构，存在字段不一致风险 |
| P1-3 | novel-creator agent 缺少正文看护指令 | agents/novel-creator.md | agent 用于批量生成内容，但指令中无加载 story-bible、context-card、continuity-ledger 的要求 |
| P1-4 | AI 合规闸门代码重复 | launch-strategy/SKILL.md + monetization-strategy/SKILL.md | 两份完全相同的 AI 合规闸门逻辑分别定义 |

### P2 体验优化问题

| # | 问题 | 位置 | 详情 |
|---|------|------|------|
| P2-1 | section 编号重复 | novel-confirmation/SKILL.md | 两个 "5." 章节标题 |
| P2-2 | hooks/run-hook.cmd 仅限 Windows | writing-workflow/hooks/ | .cmd 脚本在 macOS/Linux 不可用 |
| P2-3 | quality-review subagent 审查缺少执行保证 | quality-review/SKILL.md:495-534 | 要求使用独立 subagent 审查但无强制执行机制 |

---
## Chunk 1: P0 阈值统一

### Task 1: 统一 content-generation 偏离度阈值

**Files:** Modify: `writing-workflow/skills/content-generation/SKILL.md:210-304`

- [ ] **Step 1: 将自检分级表与硬失败阈值对齐**

当前问题: 自检分级(10%/20%/30%)和硬失败(15%)使用了不同的阈值刻度，15%-20%区间冲突。

修复:
1. 将自检分级调整为与硬失败阈值一致：≤10% 合格, 10%-15% 警告, >15% 硬失败
2. 删除 20%-30% 和 >30% 分级（因为 >15% 已经是硬失败，不需要更多分级）
3. 统一用户确认路径的阈值分支条件

具体修改 content-generation/SKILL.md:

第 214-219 行，将:
```markdown
| 偏离度 | 判定 | 处理 |
|--------|------|------|
| ≤10% | ✅ 合格 | 继续 |
| 10%-20% | ⚠️ 警告 | 提示用户确认偏离是否合理，建议修正 |
| 20%-30% | 🔴 严重 | 必须修正或重新生成，不允许直接通过 |
| >30% | 🚫 不合格 | 强制重新生成，当前版本不保存为正式稿 |
```

改为:
```markdown
| 偏离度 | 判定 | 处理 |
|--------|------|------|
| ≤10% | ✅ 合格 | 继续 |
| 10%-15% | ⚠️ 警告 | 提示用户确认偏离是否合理，建议修正 |
| >15% | 🚫 不合格 | 硬失败，必须修正或重新生成，不允许进入下一阶段 |
```

第 260-304 行，将用户确认路径从三档（≤10%/10-20%/>20%）改为两档（≤10%/10-15%/>15%）：
- 删除 "偏离度 10%-20%（警告）" 改为 "偏离度 10%-15%（警告）"
- 删除 "偏离度 >20%（严重/不合格）" 改为 "偏离度 >15%（硬失败）"
- 更新所有相关文字描述

- [ ] **Step 2: 验证 P0-1 修复后阈值一致性**

检查确认:
- 自检分级表与硬失败条件使用相同阈值 (>15%)
- 用户确认路径的阈值分界与硬失败对齐
- 用三个场景验证: 偏离度 8%（合格）、12%（警告）、18%（硬失败）

---

### Task 2: 统一 quality-review 场景覆盖率与偏离度标准

**Files:** Modify: `writing-workflow/skills/quality-review/SKILL.md:119-278`

- [ ] **Step 1: 将正文质量标准表与硬门槛阈值对齐**

当前问题: 硬门槛(第119-127行)用 90%/15%，质量标准表(第271-278行)用 80%/20%。两个标准不一致。

修复 quality-review/SKILL.md:

第 271-278 行，将:
```markdown
| 维度 | 合格标准 | 不合格标准 |
|------|---------|-----------|
| 细纲一致性 | 场景覆盖率≥80%，偏离度≤20% | 场景覆盖率<80%或偏离度>20% |
```

改为:
```markdown
| 维度 | 合格标准 | 不合格标准 |
|------|---------|-----------|
| 细纲一致性 | 场景覆盖率≥90%，偏离度≤15% | 场景覆盖率<90%或偏离度>15% |
```

- [ ] **Step 2: 验证 P0-2/P0-3 修复后全文件阈值一致**

检查确认 quality-review/SKILL.md 中:
- 第122行硬门槛: 场景覆盖率 < 90%
- 第123行硬门槛: 偏离度 > 15%
- 第273行质量标准: 场景覆盖率 ≥ 90%, 偏离度 ≤ 15%
- 这三处阈值完全一致

- [ ] **Step 3: 提交 P0 修复**

```bash
git add writing-workflow/skills/content-generation/SKILL.md writing-workflow/skills/quality-review/SKILL.md
git commit -m "fix: unify deviation and coverage thresholds across content-generation and quality-review"
```

---
## Chunk 2: P1 结构性缺口修复

### Task 3: 补齐短篇路径平台算法适配

**Files:** Modify: `writing-workflow/skills/content-generation/SKILL.md:480-608`

- [ ] **Step 1: 添加短篇/公众号平台的算法适配说明**

在 content-generation/SKILL.md 的平台算法适配写法部分（"### 晋江文学城" 之后），新增 "### 短篇/公众号平台" 适配说明。

添加内容:
```markdown
### 短篇/公众号平台：内容驱动适配

短篇作品发布于公众号、短篇投稿平台或社交媒体时，不需要适配长篇平台的算法机制。

```
短篇写法要点：

1. 开篇必须在300字内建立核心冲突或情感钩子
   - 短篇读者注意力更短，没有"追更"预期
   - 一上来就要让读者知道"这篇写的是什么"

2. 节奏紧凑，无废话
   - 3000-10000字内完成完整故事弧
   - 不做大段世界观铺垫
   - 每个场景都必须推进情节或塑造人物

3. 结尾必须有明确的情绪收束
   - 反转、温情、震撼——至少要有一个
   - 短篇靠结尾打动读者，烂尾是致命伤

4. 标题必须有传播力
   - 公众号标题：制造好奇心（"那个每天给我送外卖的人，不是人"）
   - 短篇平台：标注题材+亮点（"都市怪谈 | 606的外卖"）

5. 适合碎片化阅读
   - 段落短（手机屏幕3-4行以内）
   - 对话占比可高于长篇
   - 少用复杂句式
```

**短篇写法自检**：
```
□ 300字内是否建立了核心冲突/情感钩子？
□ 故事弧是否完整（起承转合）？
□ 结尾是否有情绪收束？
□ 标题是否有传播力？
□ 段落是否适合手机阅读？
```
```

- [ ] **Step 2: 更新平台文风对照表**

在第 480 行的文风对照表中添加短篇行:
```markdown
| 短篇/公众号 | 紧凑、情感集中、结尾有力 | 3000-10000字完整故事弧 |
```

- [ ] **Step 3: 提交**

---

### Task 4: 对齐 chapter-outline context card 与 content-generation 看护包

**Files:** Modify: `writing-workflow/skills/chapter-outline/SKILL.md:132-159` and `writing-workflow/skills/content-generation/SKILL.md:62-93`

- [ ] **Step 1: 统一 context card 和看护包字段**

当前 context card 字段:
- 本章输入状态（承接事件、主角目标、关键人物状态、时间地点锁定）
- 本章必写场景
- 本章禁止偏离项
- 本章必须回收/推进
- 本章结束状态

当前看护包字段:
- 不可变更事实（来自 story bible）
- 本章输入状态
- 本章必写场景
- 本章允许发挥范围
- 本章禁止偏离项
- 本章结束状态

看护包比 context card 多出: "不可变更事实" 和 "允许发挥范围"。

修复: 在 chapter-outline 的 context card 模板中添加 "本章允许发挥范围" 字段，与看护包对齐。同时在 context card 说明中引用 story bible 的不可变更事实。

在 chapter-outline/SKILL.md 第132-159行，在 "## 本章禁止偏离项" 之后、"## 本章必须回收/推进" 之前添加:
```markdown
## 本章允许发挥范围
- 可补充的细节方向
- 可扩写的情绪段落
- 可增加的环境描写
```

同时更新 content-generation 看护包的引用说明，明确标注各字段的来源（哪些来自 context card，哪些来自 story bible）。

- [ ] **Step 2: 提交**

---

### Task 5: 补充 novel-creator agent 正文看护指令

**Files:** Modify: `writing-workflow/agents/novel-creator.md`

- [ ] **Step 1: 在 agent 定义中添加看护资产加载要求**

在 novel-creator.md 的 "## 能力" 部分之后、"## 限制" 部分之前，添加:

```markdown
## 正文看护要求（Content Generation 专用）

当 task_type 为 "content_generation" 时，必须执行以下看护流程:

1. **加载看护资产（强制）**
   - 读取 `novel-project/17-continuity/story-bible.md`
   - 读取目标章节的 `novel-project/17-continuity/chapter-XXX-context.md`
   - 读取 `novel-project/17-continuity/continuity-ledger.md`（检查上一章结束状态）

2. **生成前看护预检（强制）**
   - 确认本章输入状态与上一章 continuity-ledger 一致
   - 确认本章必写场景完整
   - 确认禁止偏离项明确

3. **场景级逐段生成**
   - 按 context card 中的必写场景顺序逐一生成
   - 每场景完成后检查是否命中本场景目标
   - 不得跳过必写场景

4. **连续性硬门槛（生成后）**
   - 场景覆盖率必须 ≥ 90%
   - 偏离度必须 ≤ 15%
   - 不可变更事实不得被改写
   - 必写场景不得缺失
   - 本章结束状态必须与 context card 一致

若命中任一硬门槛，标记 status 为 "failure" 并说明原因，不返回正文内容。
```

- [ ] **Step 2: 提交**

---

### Task 6: 消除 AI 合规闸门代码重复

**Files:** Modify: `writing-workflow/skills/launch-strategy/SKILL.md:27-39` and `writing-workflow/skills/monetization-strategy/SKILL.md:20-33`

- [ ] **Step 1: 在 human-ai-collaboration 中集中定义闸门逻辑**

在 `human-ai-collaboration/SKILL.md` 中已有风险闸门机制（第93-107行）。现在需要在 monetization-strategy 和 launch-strategy 中将重复的闸门逻辑替换为引用。

在 launch-strategy 中，将第 27-39 行（完整的 AI 合规闸门表格）替换为简洁引用:
```markdown
## AI 参与度合规闸门

> 闸门规则详见 [human-ai-collaboration skill](../human-ai-collaboration/SKILL.md) 中的"风险闸门机制"。

进入本阶段前，必须检查 `workflow-state.json.guardrails`：
- `latest_ai_path`：当前 AI 参与度评级
- `release_allowed`：是否允许进入上架发布阶段

若 `release_allowed = false`，阻断本阶段执行并提示用户。
```

在 monetization-strategy 中做同样处理。

- [ ] **Step 2: 提交**

---
## Chunk 3: P2 体验优化

### Task 7: 修复 novel-confirmation section 编号重复

**Files:** Modify: `writing-workflow/skills/novel-confirmation/SKILL.md:99-118`

- [ ] **Step 1: 将第二个 "5." 改为 "6."，后续编号顺延**

当前: 第99行 "### 5. 展示主选方案" 和第119行 "### 5. 展示备选方案" 都标为 5。

将第119行 "### 5. 展示备选方案" 改为 "### 6. 展示备选方案"。

同时将后续章节编号顺延:
- 第143行 "### 6. 生成作品信息文件" → "### 7. 生成作品信息文件"
- 第223行 "### 7. 更新工作流状态" → "### 8. 更新工作流状态"

- [ ] **Step 2: 提交**

---

### Task 8: 修复 hooks 跨平台兼容性

**Files:** Modify: `writing-workflow/hooks/run-hook.cmd` and create Unix shim

- [ ] **Step 1: 添加 Unix shell 脚本**

在 `writing-workflow/hooks/` 下创建 `run-hook.sh`:
```bash
#!/bin/bash
# Writing Workflow Plugin Hook Runner (Unix)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"${SCRIPT_DIR}/$1"
```

- [ ] **Step 2: 更新 hooks.json 支持跨平台**

修改 hooks.json 的 command，使用环境变量判断操作系统:
```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup|resume|clear|compact",
        "hooks": [
          {
            "type": "command",
            "command": "if [ -n \"$WINDIR\" ]; then \"${CLAUDE_PLUGIN_ROOT}/hooks/run-hook.cmd\" session-start; else bash \"${CLAUDE_PLUGIN_ROOT}/hooks/run-hook.sh\" session-start; fi",
            "async": false
          }
        ]
      }
    ]
  }
}
```

---

### Task 9: 强化 quality-review 独立 subagent 审查的执行说明

**Files:** Modify: `writing-workflow/skills/quality-review/SKILL.md:491-534`

- [ ] **Step 1: 增强 subagent 调用说明的强制性**

在 "独立审查机制" 部分开头添加明确的执行检查清单:
```markdown
### 执行检查清单

正文审查前必须确认:
- [ ] 正在启动**独立 subagent** 进行审查（非当前会话）
- [ ] subagent prompt 中包含了: 正文文件路径、细纲文件路径、人物设定路径、目标平台
- [ ] subagent 返回了完整的审查报告

> ⚠️ 如果在当前会话中自我审查，评分偏差 >=15 分时以较低分计并标注"审查一致性差异"。
```

---

## 验证策略

修复完成后:
1. 遍历所有 18 个 SKILL.md，确认无残留的旧阈值（搜索 "80%"、"20%" 关键词）
2. 验证 content-generation → quality-review → using-writing-workflow 的阈值传递链路无断层
3. 验证短篇路径从 work-type-selection → genre-selection → novel-confirmation → creation-planning → outline-writing → chapter-outline → content-generation 全链路可走通
4. 验证 novel-creator agent 在看护流程下能正确生成内容
