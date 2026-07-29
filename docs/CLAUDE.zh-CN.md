> 中文翻译 | [English](CLAUDE.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# Docs 目录

在本目录中撰写或编辑文件时,遵循以下标准。

## 架构决策记录(`docs/architecture/`)

使用 ADR 模板:`.claude/docs/templates/architecture-decision-record.md`

**必需章节:** 标题(Title)、状态(Status)、背景(Context)、决策(Decision)、后果(Consequences)、ADR 依赖(ADR Dependencies)、引擎兼容性(Engine Compatibility)、覆盖的 GDD 需求(GDD Requirements Addressed)

**状态生命周期:** `Proposed` → `Accepted` → `Superseded`
- 绝不跳过 `Accepted`——引用 `Proposed` ADR 的故事会被自动阻塞
- 用 `/architecture-decision` 通过引导流程创建 ADR

**TR 注册表:** `docs/architecture/tr-registry.yaml`
- 稳定的需求 ID(如 `TR-MOV-001`),把 GDD 需求链接到故事
- 绝不对既有 ID 重新编号——只能追加新 ID
- 由 `/architecture-review` 第 8 阶段更新

**控制清单:** `docs/architecture/control-manifest.md`
- 扁平的程序员规则清单:按层组织必需(Required)/ 禁用(Forbidden)/ 护栏(Guardrails)
- 头部带日期戳的 `Manifest Version:`
- 故事内嵌此版本;`/story-done` 会检查是否过期

**验证:** 完成一组 ADR 后运行 `/architecture-review`。

## 引擎参考(`docs/engine-reference/`)

版本锁定的引擎 API 快照。**使用任何引擎 API 之前务必先查这里**——LLM 的训练数据早于锁定的引擎版本。

当前引擎:见 `docs/engine-reference/godot/VERSION.md`
