> 中文翻译 | [English](../../../.claude/rules/gameplay-code.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。英文版含 paths frontmatter(路径作用域声明),中文版从略。

# 玩法代码规则

- 所有玩法数值必须来自外部配置/数据文件,绝不硬编码
- 所有与时间相关的计算必须使用 delta time(帧率无关)
- 禁止直接引用 UI 代码——跨系统通信使用事件/信号
- 每个玩法系统必须实现明确的接口
- 状态机必须有显式的转换表,并记录各状态
- 为所有玩法逻辑编写单元测试——逻辑与表现分离
- 在代码注释中注明每个功能实现的是哪份设计文档
- 游戏状态不使用静态单例——使用依赖注入

## 示例

**正确**(数据驱动):

```gdscript
var damage: float = config.get_value("combat", "base_damage", 10.0)
var speed: float = stats_resource.movement_speed * delta
```

**错误**(硬编码):

```gdscript
var damage: float = 25.0   # VIOLATION: hardcoded gameplay value
var speed: float = 5.0      # VIOLATION: not from config, not using delta
```
