# Writing Workflow Plugin

AI辅助小说创作工作流插件，实现从平台调研到正文生成的端到端解决方案。

## 安装

```bash
# 添加插件（本地路径）
/plugin add ./writing-workflow
```

## 使用

开始工作流：请求使用 `writing-workflow` skill

## 工作流阶段

1. **作品类型选择** - 选择适合的作品类型（长篇/中篇/短篇等）
2. **平台调研** - 分析目标平台数据，推荐适合的发布平台
3. **题材选择** - 分析热门和潜力题材，选择创作方向
4. **作品确认** - 从5个作品方案中选择，确定书名、简介等基本信息
5. **创作规划** - 制定篇幅、发布频率等创作计划
6. **大纲生成** - 生成世界观、人物关系、情节大纲
7. **章节细纲** - 生成详细的章节细纲
8. **正文生成** - 按章节生成正文内容
9. **质量检查** - 自动质量审查，包含AI痕迹消除

## 特性

- 基于实时数据分析，不捏造数据
- 多阶段质量检查
- AI痕迹消除
- 上下文智能管理
- 灵活的阶段选择
- 所有决策用户确认

## 支持的平台

- 起点中文网
- 番茄小说
- 晋江文学城
- 七猫小说
- 自定义扩展

## 项目结构

创作过程中会生成以下文件结构：

```
novel-project/
├── workflow-state.json       # 工作流状态
├── 00-work-type.md           # 作品类型信息
├── 01-platform-research.md   # 平台调研报告
├── 02-genre-analysis.md      # 题材分析报告
├── 03-novel-info.md          # 作品信息
├── 04-creation-plan.md       # 创作规划
├── 05-outline.md             # 作品大纲
├── 06-chapter-outlines/      # 章节细纲
├── 07-content/               # 正文内容
├── 08-characters/            # 人物设定
├── 09-worldbuilding/         # 世界观设定
├── 10-reviews/               # 审查报告
├── 11-data-monitoring/       # 数据监控（发布后）
└── 12-reader-interaction/    # 读者互动记录（发布后）
```

## License

MIT
