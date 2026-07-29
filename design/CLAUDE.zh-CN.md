> 中文翻译 | [English](CLAUDE.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# 设计目录

在本目录撰写或编辑文件时,遵循以下标准。

## GDD 文件(`design/gdd/`)

每份 GDD 必须按以下顺序包含全部 **8 个必需章节**:
1. Overview(概述)——一段话总结
2. Player Fantasy(玩家幻想)——预期的感受与体验
3. Detailed Rules(详细规则)——无歧义的机制
4. Formulas(公式)——所有数学定义及变量
5. Edge Cases(边界情况)——异常情况的处理
6. Dependencies(依赖)——涉及的其他系统
7. Tuning Knobs(调优旋钮)——可配置数值
8. Acceptance Criteria(验收标准)——可测试的成功条件

**文件命名:** `[system-slug].md`(例如 `movement-system.md`、`combat-system.md`)

**系统索引:** `design/gdd/systems-index.md`——新增 GDD 时更新。

**设计顺序:** Foundation → Core → Feature → Presentation → Polish

**校验:** 撰写任何 GDD 后运行 `/design-review [path]`。
完成一组相关 GDD 后运行 `/review-all-gdds`。

## 快速规格(`design/quick-specs/`)

用于调优变更、小型机制或平衡调整的轻量级规格。
使用 `/quick-design` 撰写。

## UX 规格(`design/ux/`)

- 单屏规格:`design/ux/[screen-name].md`
- HUD 设计:`design/ux/hud.md`
- 交互模式库:`design/ux/interaction-patterns.md`
- 无障碍要求:`design/ux/accessibility-requirements.md`

使用 `/ux-design` 撰写。交给 `/team-ui` 前用 `/ux-review` 校验。
