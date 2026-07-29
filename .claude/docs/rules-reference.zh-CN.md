> 中文翻译 | [English](rules-reference.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# 路径特定规则

`.claude/rules/` 中的规则会在编辑匹配路径下的文件时自动强制执行:

| 规则文件 | 路径模式 | 强制执行内容 |
| ---- | ---- | ---- |
| `gameplay-code.md` | `src/gameplay/**` | 数据驱动的数值、增量时间(delta time)、不引用 UI |
| `engine-code.md` | `src/core/**` | 热路径零分配、线程安全、API 稳定性 |
| `ai-code.md` | `src/ai/**` | 性能预算、可调试性、数据驱动的参数 |
| `network-code.md` | `src/networking/**` | 服务器权威、带版本号的消息、安全 |
| `ui-code.md` | `src/ui/**` | 不持有游戏状态、可本地化、无障碍 |
| `design-docs.md` | `design/gdd/**` | 必需的 8 个章节、公式格式、边缘情况 |
| `narrative.md` | `design/narrative/**` | 设定一致性、角色口吻、正史(canon)层级 |
| `data-files.md` | `assets/data/**` | JSON 有效性、命名约定、schema 规则 |
| `test-standards.md` | `tests/**` | 测试命名、覆盖率要求、测试夹具(fixture)模式 |
| `prototype-code.md` | `prototypes/**` | 宽松标准、必须有 README、记录假设 |
| `shader-code.md` | `assets/shaders/**` | 命名约定、性能目标、跨平台规则 |
