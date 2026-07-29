> 中文翻译 | [English](CONTRIBUTING.md)
> 同步基线:commit `0de6c40`(2026-07-29);如有出入以英文版为准。

# 为 Claude Code Game Studios 做贡献

CCGS 是一个用 Claude Code 进行独立游戏开发的协同框架。
欢迎贡献——缺陷修复、填补真实空白的新技能、代理改进、钩子修复。
不符合框架发展方向的 PR 会被直接关闭,不做长篇解释。

## 什么样的 PR 是好 PR

- **缺陷修复** ——某个东西坏了,这是修复方案
- **新技能** ——解决尚未覆盖的工作流空白
- **改进** 现有代理、技能或钩子
- **文档勘误** ——信息错误、引用失效、步骤过时

以 PR 形式提交的功能请求会被关闭。请改为开 issue。

**本仓库不收纳什么:**
CCGS 是帮你做游戏的系统,不是存放你用它做出来的游戏的地方。
GDD、ADR、PRD、游戏概念、关卡设计、叙事文档,或任何 CCGS 为你自己
项目生成的产物,都不会被合并到这里——请把它们放在你自己的仓库里。

## 不可妥协的技术规则

以下事项没做到会直接导致 PR 被拒。

**技能文件**
- 技能位于 `.claude/skills/<name>/SKILL.md` ——子目录格式是硬性要求。
  扁平的 `.md` 文件会被 Claude Code 静默忽略。
- SKILL.md 必须包含 YAML frontmatter:`name`、`description`、
  `argument-hint`、`allowed-tools` 和 `model`
- 模型层级:只读状态检查用 `haiku`;多文档综合与阶段门用 `opus`;
  其余一律用 `sonnet`

**钩子**
- 使用 `grep -E` ——绝不用 `grep -P`(Perl 正则在 Windows Git Bash 上会坏)
- 为没有安装 `jq` 或 `python` 的系统准备降级方案
- 钩子每次会话启动都会运行——不适用时必须快速优雅地退出
  (`exit 0`)

**代理**
- 新代理必须包含 **Collaboration Protocol(协作协议)** 章节,说明
  该代理如何提问、如何把决策交还给用户
- 没有用户的明确委派,代理不得修改其文档声明领域之外的文件

**参考文档**
- 如果你的 PR 新增或改动了技能、代理或钩子,必须同步更新对应的
  参考文档(agent-roster、skills-reference、hooks-reference 或
  rules-reference)。只加东西不更新索引的 PR 会被打回。

## 协作原则

CCGS 不是自治系统。每个工作流都遵循:
**提问 → 选项 → 决策 → 草稿 → 批准 → 写入**

技能和代理必须先问再做。没有用户的明确确认,不写任何文件。
如果你的贡献里有代理自作主张地做决定或写文件,不会被合并。

## 测试你的改动

在 Claude Code 会话中实际运行,确认端到端可用。对技能:调用该技能
并验证输出与技能声明的行为一致。对钩子:触发相关事件,确认钩子
正确触发并干净退出。

在 PR 描述中附一段简短说明:你测试了什么、输出是什么样。

## 提交格式

使用[约定式提交(Conventional Commits)](https://www.conventionalcommits.org/):

```
feat: add /retrospective skill for end-of-sprint reviews
fix: correct grep -P usage in session-start hook
docs: update skills-reference with new /qa-plan entry
```

类型:`feat`、`fix`、`docs`、`chore`、`refactor`、`test`

## PR 流程

- 你的 PR 会通过 CODEOWNERS 自动指派给维护者
- 评审随缘进行——这是单人维护的项目
- 如果 PR 放了几周没有反馈,可以留言催一下
- 被合并的贡献者会在发布说明中署名

## 平台兼容性

CCGS 必须能在 Windows(Git Bash)、macOS 和 Linux 上运行。如果你的
钩子或脚本使用了平台相关特性,会被拒绝。拿不准时,在 Windows 上测试。
