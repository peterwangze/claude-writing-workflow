# Writing Workflow Plugin 设计文档

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 创建一个完整的Claude插件，实现AI辅助小说创作的端到端工作流

**Architecture:** 采用多Skill组合架构，每个工作流阶段作为独立skill，通过主协调skill管理流程。使用分层文件存储管理上下文，支持灵活的阶段选择和自动质量检查。

**Tech Stack:** Claude Plugin System, Skills, WebSearch, AskUserQuestion, File Storage

---

## 1. 项目概述

### 1.1 目标

实现一个Claude端到端小说创作工作流插件，参考superpowers软件开发工作流设计。用户通过完整流程得到一个适合目标平台发布、符合用户画像、有爆火潜力的小说。

### 1.2 核心原则

- 以盈利为目的，注重创作约束和质量检查
- 所有决策与用户确认，不擅作主张
- 基于实时数据分析，不捏造数据
- 严格管理上下文，保证创作连贯性

---

## 2. 插件结构

### 2.1 目录结构

```
writing-workflow/
├── .claude-plugin/
│   ├── plugin.json              # 插件元数据
│   └── marketplace.json         # 市场配置
├── skills/
│   ├── using-writing-workflow/
│   │   └── SKILL.md             # 主入口skill
│   ├── work-type-selection/
│   │   └── SKILL.md             # 作品类型选择skill
│   ├── platform-research/
│   │   └── SKILL.md             # 平台调研skill
│   ├── genre-selection/
│   │   └── SKILL.md             # 题材选择skill
│   ├── novel-confirmation/
│   │   └── SKILL.md             # 作品确认skill
│   ├── creation-planning/
│   │   └── SKILL.md             # 创作规划skill
│   ├── outline-writing/
│   │   └── SKILL.md             # 大纲生成skill
│   ├── chapter-outline/
│   │   └── SKILL.md             # 章节细纲skill
│   ├── content-generation/
│   │   └── SKILL.md             # 正文生成skill
│   ├── quality-review/
│   │   └── SKILL.md             # 质量审查skill
│   ├── human-ai-collaboration/
│   │   └── SKILL.md             # AI合规与人机协作skill
│   ├── launch-strategy/
│   │   └── SKILL.md             # 上架发布策略skill
│   ├── monetization-strategy/
│   │   └── SKILL.md             # 变现策略skill
│   ├── competitor-analysis/
│   │   └── SKILL.md             # 竞品深度分析skill
│   ├── opening-optimization/
│   │   └── SKILL.md             # 开篇优化skill（可选）
│   ├── novel-style-learning/
│   │   └── SKILL.md             # 网文风格学习skill（可选）
│   ├── data-monitoring/
│   │   └── SKILL.md             # 数据监控skill（发布后）
│   └── reader-interaction/
│       └── SKILL.md             # 读者互动skill（发布后）
├── agents/
│   └── novel-creator.md         # 子agent配置
├── hooks/
│   ├── hooks.json               # hook配置
│   ├── run-hook.cmd             # Windows hook脚本
│   └── session-start            # 会话启动脚本
└── README.md                    # 插件说明文档
```

### 2.2 插件配置

**plugin.json**:
```json
{
  "name": "writing-workflow",
  "description": "AI辅助小说创作工作流：从平台调研到正文生成的端到端解决方案",
  "version": "1.0.0",
  "author": {
    "name": "User",
    "email": "user@example.com"
  },
  "keywords": ["novel", "writing", "workflow", "creative-writing", "ai-assisted"]
}
```

**marketplace.json**:
```json
{
  "name": "writing-workflow-market",
  "description": "小说创作工作流插件市场",
  "owner": {
    "name": "User"
  },
  "plugins": [
    {
      "name": "writing-workflow",
      "description": "AI辅助小说创作工作流",
      "version": "1.0.0",
      "source": "./"
    }
  ]
}
```

### 2.3 Hooks配置

**hooks.json**:
```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup|resume|clear|compact",
        "hooks": [
          {
            "type": "command",
            "command": "\"${CLAUDE_PLUGIN_ROOT}/hooks/run-hook.cmd\" session-start",
            "async": false
          }
        ]
      }
    ]
  }
}
```

**run-hook.cmd** (Windows):
```batch
@echo off
set SCRIPT_PATH=%~dp0%~2
if exist "%SCRIPT_PATH%" (
    call "%SCRIPT_PATH%"
)
```

**session-start**:
```bash
#!/bin/bash
echo "Writing Workflow Plugin loaded. Use 'writing-workflow' skill to start."
```

### 2.4 Agent配置

**agents/novel-creator.md**:
```markdown
---
name: novel-creator
description: 子agent用于并行处理小说创作任务
---

# Novel Creator Agent

用于并行处理以下任务：
- 多章节细纲生成
- 多章节正文生成
- 并行质量检查

## 能力
- 读取项目文件
- 生成内容
- 执行质量检查

## 限制
- 不能修改工作流状态
- 不能与用户交互
- 必须返回执行结果给主agent
```

### 2.5 README内容

**README.md**:
```markdown
# Writing Workflow Plugin

AI辅助小说创作工作流插件，实现从平台调研到正文生成的端到端解决方案。

## 安装

```bash
# 添加marketplace
/plugin marketplace add <marketplace-url>

# 安装插件
/plugin install writing-workflow
```

## 使用

```bash
# 开始工作流
使用 writing-workflow skill
```

## 工作流阶段

1. 平台调研 - 分析目标平台数据
2. 题材选择 - 选择合适的创作题材
3. 作品确认 - 确定作品基本信息
4. 创作规划 - 制定创作计划
5. 大纲生成 - 生成作品大纲
6. 章节细纲 - 生成章节细纲
7. 正文生成 - 生成章节正文
8. 质量检查 - 自动质量审查

## 特性

- 基于实时数据分析
- 多阶段质量检查
- AI痕迹消除
- 上下文智能管理
- 灵活的阶段选择
```

---

## 3. 工作流阶段设计

### 3.1 阶段概览

| 阶段 | Skill | 职责 | 输入 | 输出 |
|------|-------|------|------|------|
| 0 | work-type-selection | 选择作品类型 | - | 作品类型信息文件 |
| 1 | platform-research | 调研平台数据，推荐平台 | 作品类型 | 平台调研报告 |
| 1.5 | competitor-analysis | 竞品深度分析 | 平台+题材方向 | 竞品分析报告 |
| 2 | genre-selection | 分析题材，推荐选择 | 平台信息+竞品分析 | 题材分析报告 |
| 3 | novel-confirmation | 5个作品概念选择，确定基本信息 | 题材信息 | 作品信息文件 |
| 4 | creation-planning | 制定创作规划 | 作品信息 | 创作规划文件 |
| 5 | outline-writing | 生成作品大纲+人物关系图 | 创作规划 | 大纲文件 |
| 6 | chapter-outline | 生成章节细纲 | 大纲文件 | 细纲文件 |
| 7 | content-generation | 生成正文内容（含平台算法适配） | 细纲+前文 | 章节文件 |
| 7.5 | human-ai-collaboration | AI合规人机协作 | 正文初稿 | 合规内容+创作日志 |
| 8 | quality-review | 质量审查 | 生成内容 | 审查报告 |
| 9 | launch-strategy | 上架发布策略 | 存稿+平台信息 | 发布策略文件 |
| 10 | monetization-strategy | 变现策略 | 发布策略+平台 | 变现策略文件 |

### 3.2 阶段详细设计

#### 3.2.0 using-writing-workflow Skill（主入口）

**触发条件**：用户请求开始小说创作工作流

**职责**：
- 初始化工作流状态
- 引导用户选择执行阶段
- 协调各阶段skill的执行
- 管理工作流上下文

**执行流程**：
1. 检查是否存在工作流状态文件
2. 如果不存在，初始化新项目
3. 显示当前阶段和可选操作
4. 根据用户选择调用对应skill
5. 更新工作流状态
6. 循环直到用户退出或完成

**状态管理**：
```json
{
  "current_stage": "platform_research",
  "completed_stages": [],
  "project_info": {},
  "files": {}
}
```

**用户交互**：
```
欢迎使用小说创作工作流！

当前项目状态：
- 阶段：平台调研
- 已完成：无

可选操作：
1. 开始平台调研
2. 跳过此阶段
3. 查看帮助
4. 退出

请选择：
```

**输出文件**：`novel-project/00-work-type.md`

#### 3.2.1 platform-research Skill

**触发条件**：用户选择作品类型后

**执行流程**：
1. 使用WebSearch搜索目标平台数据
2. 分析热门题材、用户画像、盈利模式
3. 分析红海和蓝海平台
4. 生成调研报告
5. 使用AskUserQuestion让用户确认平台选择

**搜索关键词示例**：
- "起点中文网 2026年3月 热门题材 排行榜"
- "番茄小说 用户画像 付费模式 2026"
- "晋江文学城 女性向小说 热门类型"

**输出文件**：`novel-project/01-platform-research.md`

**报告结构**：
```markdown
# 平台调研报告

## 调研时间
[实时日期]

## 平台分析

### [平台名称]
- 热门题材：[基于搜索数据]
- 用户画像：[基于搜索数据]
- 盈利模式：[基于搜索数据]
- 竞争程度：红海/蓝海
- 推荐指数：★★★★☆

## 平台推荐
[基于分析给出推荐]

## 数据来源
- [来源1 URL]
- [来源2 URL]
```

#### 3.2.2 genre-selection Skill

**触发条件**：平台选择完成后

**执行流程**：
1. 基于平台调研结果，搜索热门和潜力题材
2. 分析红海题材（竞争激烈但流量大）
3. 分析蓝海题材（竞争小但潜力大）
4. 结合用户画像给出推荐
5. 用户确认题材选择

**输出文件**：`novel-project/02-genre-analysis.md`

#### 3.2.3 novel-confirmation Skill

**触发条件**：题材选择完成后

**执行流程**：
1. 基于平台和题材分析，生成5个作品选项
2. 每个选项包含：书名、简介、封面提示词
3. 用户选择后，确定主选和备选方案
4. 生成作品信息文件

**输出文件**：`novel-project/03-novel-info.md`

**作品信息结构**：
```markdown
# 作品信息

## 主选方案
- 书名：[书名]
- 简介：[简介]
- 封面提示词：[AI生成封面用]

## 备选方案
1. [备选1]
2. [备选2]
...

## 分类信息
- 作品类型：[类型]
- 目标平台：[平台]
- 题材分类：[题材]
```

#### 3.2.4 creation-planning Skill

**触发条件**：作品确认后

**执行流程**：
1. 与用户确认小说篇幅（字数目标）
2. 确认发布频率
3. 制定大纲生成指导原则
4. 生成创作规划文件

**输出文件**：`novel-project/04-creation-plan.md`

#### 3.2.5 outline-writing Skill

**触发条件**：创作规划完成后

**执行流程**：
1. 生成世界观设定
2. 生成人物设定和关系图
3. 生成完整大纲
4. 确保逻辑闭环和节奏明确
5. 内嵌自检：世界观完整性、设定逻辑性
6. 调用quality-review进行外部审查
7. 用户确认大纲

**输出文件**：
- `novel-project/05-outline.md`
- `novel-project/08-characters/main-characters.md`
- `novel-project/08-characters/supporting-characters.md`
- `novel-project/09-worldbuilding/world-settings.md`
- `novel-project/09-worldbuilding/power-system.md`（如适用）

**大纲结构**：
```markdown
# 作品大纲

## 世界观
[世界观设定]

## 力量体系（如适用）
[职级/数值体系]

## 主要人物
### 主角
- 姓名：
- 性格：
- 成长线：

### 主要配角
[配角信息]

## 情节主线
[主线情节]

## 分卷大纲
### 第一卷：[卷名]
- 核心冲突：
- 章节规划：
- 爽点分布：

## 时间线
[故事时间线]
```

#### 3.2.6 chapter-outline Skill

**触发条件**：大纲确认后

**执行流程**：
1. 按章节生成细纲
2. 确保与大纲一致性
3. 确保前后章节连续性
4. 分批生成，每批用户确认
5. 内嵌自检：与大纲一致性、章节连贯性
6. 调用quality-review进行审查

**输出文件**：`novel-project/06-chapter-outlines/chapter-XXX.md`

**细纲结构**：
```markdown
# 第X章：[章节名]

## 章节概要
[100-200字概要]

## 场景列表
1. 场景一：[场景描述]
2. 场景二：[场景描述]

## 人物出场
- [人物]：[在本章的作用]

## 情节要点
- 开头：
- 发展：
- 高潮：
- 结尾：

## 伏笔/呼应
- 埋设伏笔：
- 呼应前文：

## 字数目标
[预计字数]
```

#### 3.2.7 content-generation Skill

**触发条件**：细纲生成后

**执行流程**：
1. 加载大纲、细纲、前文内容
2. 按章节生成正文
3. 确保与设定一致性
4. 确保与前文连贯性
5. 内嵌自检：人物一致性、前后文连贯性
6. 调用quality-review进行审查（包含AI痕迹检查）
7. 每章生成后用户确认

**输出文件**：`novel-project/07-content/chapter-XXX.md`

#### 3.2.8 quality-review Skill

**触发条件**：
- 大纲生成后（自动）
- 细纲生成后（自动）
- 每章正文生成后（自动）
- 用户请求时（手动）

**审查角色**：

**大纲阶段**：
- 架构审查员：检查世界观和设定逻辑
- 节奏审查员：检查情节节奏和爽点分布
- 用户画像审查员：检查是否符合目标用户预期

**细纲阶段**：
- 情节审查员：检查与大纲一致性
- 连贯性审查员：检查章节间连贯性

**正文阶段**：
- 连贯性审查员：检查与前文的一致性
- 人物审查员：检查人物行为是否符合设定
- 文风审查员：检查文风是否符合平台用户偏好
- AI痕迹审查员：检查并消除AI生成痕迹

**AI痕迹检查内容**：
- 过于规整的句式结构
- 重复使用的过渡词和连接词
- 过度使用形容词和副词
- 缺乏口语化和个性化表达
- 过于"正确"的价值观表达
- 缺乏细节和感官描写
- 情感表达过于直白

**输出文件**：`novel-project/10-reviews/quality-reports/`

---

## 4. 上下文管理策略

### 4.1 文件层次结构

```
novel-project/
├── workflow-state.json           # 工作流状态
├── 00-work-type.md               # 作品类型信息
├── 01-platform-research.md       # 平台调研报告
├── 02-genre-analysis.md          # 题材分析报告
├── 03-novel-info.md              # 作品信息
├── 04-creation-plan.md           # 创作规划
├── 05-outline.md                 # 作品大纲
├── 06-chapter-outlines/          # 章节细纲目录
│   ├── chapter-001.md
│   ├── chapter-002.md
│   └── ...
├── 07-content/                   # 正文目录
│   ├── chapter-001.md
│   ├── chapter-002.md
│   └── ...
├── 08-characters/                # 人物设定
│   ├── main-characters.md
│   ├── supporting-characters.md
│   └── character-relationships.md
├── 09-worldbuilding/             # 世界观设定
│   ├── world-settings.md
│   └── power-system.md
├── 10-reviews/                   # 审查报告
│   └── quality-reports/
├── 11-data-monitoring/           # 数据监控（发布后）
├── 12-reader-interaction/        # 读者互动记录（发布后）
├── 13-creation-logs/             # 创作日志（AI合规记录）
├── 14-launch-strategy.md         # 上架发布策略
├── 15-monetization-strategy.md   # 变现策略
└── 16-competitor-analysis.md     # 竞品分析报告
```

### 4.2 工作流状态文件

**workflow-state.json**:
```json
{
  "current_stage": "outline_writing",
  "completed_stages": [
    "work_type_selection",
    "platform_research",
    "genre_selection",
    "novel_confirmation",
    "creation_planning"
  ],
  "project_info": {
    "work_type": "长篇小说",
    "platform": "起点中文网",
    "genre": "玄幻",
    "title": "示例书名"
  },
  "files": {
    "platform_research": "novel-project/01-platform-research.md",
    "genre_analysis": "novel-project/02-genre-analysis.md",
    "novel_info": "novel-project/03-novel-info.md",
    "creation_plan": "novel-project/04-creation-plan.md",
    "outline": null
  },
  "statistics": {
    "total_chapters": 0,
    "total_words": 0,
    "last_updated": "2026-03-18T10:00:00Z"
  }
}
```

### 4.3 按需加载策略

| 阶段 | 必须加载 | 可选加载 |
|------|----------|----------|
| work-type-selection | - | - |
| platform-research | work-type | - |
| genre-selection | work-type, platform-research | - |
| novel-confirmation | platform-research, genre-analysis | work-type |
| creation-planning | novel-info | - |
| outline-writing | novel-info, creation-plan | genre-analysis |
| chapter-outline | outline | characters, worldbuilding |
| content-generation | chapter-outline, outline | 前3章内容 |

### 4.4 上下文压缩机制

当文件内容过长时：
1. 保留原始文件完整内容
2. 生成 `.summary.md` 摘要文件
3. 摘要包含：关键设定、人物关系图、情节主线

---

## 5. 交互设计

### 5.1 用户确认原则

- 所有决策与用户确认
- 使用AskUserQuestion工具实现结构化确认
- 提供清晰的选项和说明

### 5.2 确认类型

| 确认类型 | 使用场景 | 示例 |
|----------|----------|------|
| 单选确认 | 平台选择、题材选择 | 选择推荐的平台 |
| 多选确认 | 作品类型、风格标签 | 选择作品特点 |
| 内容确认 | 大纲、细纲、正文 | 确认生成内容是否满意 |
| 路径选择 | 遇到问题时的处理方式 | 修改/跳过/重新生成 |

### 5.3 异常处理

当遇到问题时：
1. 识别问题类型
2. 使用AskUserQuestion提供解决方案选项
3. 用户选择处理方式
4. 执行用户选择

**常见异常**：
- 网络错误：无法获取实时数据
- 上下文超限：内容过长
- 数据缺失：搜索结果不足

---

## 6. 技术实现规范

### 6.1 Skill文件格式

```markdown
---
name: [skill-name]
description: "[skill描述]"
---

# [Skill名称]

[详细说明]

## 触发条件
[何时触发此skill]

## 执行流程
[具体步骤]

## 输入
[需要的输入数据]

## 输出
[生成的输出文件]

## 质量检查
[内嵌的质量检查]

## 用户确认
[需要用户确认的节点]
```

### 6.2 WebSearch使用规范

- 使用具体关键词搜索
- 包含当前日期获取最新数据
- 记录数据来源URL
- 不捏造不存在的数据

### 6.3 文件读写规范

- 使用Write工具创建新文件
- 使用Edit工具修改现有文件
- 遵循Markdown格式规范
- 使用Read工具按需加载

---

## 7. 测试计划

### 7.1 功能测试

| 测试项 | 测试内容 | 预期结果 |
|--------|----------|----------|
| 插件安装 | /plugin marketplace add + /plugin install | 成功安装并加载skills |
| 平台调研 | 执行platform-research skill | 生成调研报告 |
| 题材选择 | 执行genre-selection skill | 生成题材分析 |
| 大纲生成 | 执行outline-writing skill | 生成完整大纲 |
| 正文生成 | 执行content-generation skill | 生成章节内容 |
| 质量检查 | 自动触发quality-review | 生成审查报告 |

### 7.2 集成测试

| 测试项 | 测试内容 | 预期结果 |
|--------|----------|----------|
| 完整工作流 | 从平台选择到正文生成 | 所有阶段顺利执行 |
| 上下文管理 | 长篇小说创作 | 文件正确保存和加载 |
| 用户确认 | 各阶段确认点 | 正确等待用户响应 |
| 异常处理 | 网络错误、数据缺失 | 提供解决方案选项 |

---

## 8. 支持的平台

### 8.1 内置支持

- 起点中文网
- 番茄小说
- 晋江文学城

### 8.2 自定义扩展

用户可通过添加平台配置文件扩展支持更多平台。

---

## 9. 版本规划

### v1.0.0 (当前)
- 基础工作流实现
- 9个核心创作skill + 4个盈利运营skill + 5个辅助skill（共18个）
- 质量检查机制
- 上下文管理

### v1.1.0 (未来)
- 更多平台支持
- 高级质量检查
- 导出功能

### v2.0.0 (未来)
- 多语言支持
- 协作功能
- API集成
