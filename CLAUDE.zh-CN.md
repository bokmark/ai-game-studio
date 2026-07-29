> 中文翻译 | [English](CLAUDE.md)
> 同步基线:commit `0de6c40`(2026-07-29);如有出入以英文版为准。

# AI Game Studios —— 游戏工作室代理架构

独立游戏开发,由 49 个协同的 Claude Code 子代理管理。
每个代理负责一个特定领域,以此保证关注点分离与质量。

## 技术栈

- **引擎**:[待定:Godot 4 / Unity / Unreal Engine 5]
- **语言**:[待定:GDScript / C# / C++ / 蓝图]
- **版本控制**:Git,主干开发(trunk-based development)
- **构建系统**:[选定引擎后填写]
- **资产管线**:[选定引擎后填写]

> **注意**:Godot、Unity 和 Unreal 都有引擎专家代理,
> 并配有专属的子专家。请使用与你引擎匹配的那一组。

## 项目结构

@.claude/docs/directory-structure.md

## 引擎版本参考

@docs/engine-reference/godot/VERSION.md

## 技术偏好

@.claude/docs/technical-preferences.md

## 协同规则

@.claude/docs/coordination-rules.md

## 协作协议

**用户驱动的协作,而非自治执行。**
每个任务遵循:**提问 -> 选项 -> 决策 -> 草稿 -> 批准**

- 代理在使用 Write/Edit 工具前必须询问「我可以写入 [filepath] 吗?」
- 代理在请求批准前必须展示草稿或摘要
- 多文件变更需要对整个变更集明确批准
- 没有用户指令不做提交

完整协议与示例见 `docs/COLLABORATIVE-DESIGN-PRINCIPLE.md`。

> **第一次会话?** 如果项目还没有配置引擎、也没有游戏概念,
> 运行 `/start` 开始引导式上手流程。

## 编码标准

@.claude/docs/coding-standards.md

## 上下文管理

@.claude/docs/context-management.md
