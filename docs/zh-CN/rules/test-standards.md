> 中文翻译 | [English](../../../.claude/rules/test-standards.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。英文版含 paths frontmatter(路径作用域声明),中文版从略。

# 测试标准

- 测试命名:`test_[system]_[scenario]_[expected_result]` 模式
- 每个测试必须有清晰的 arrange/act/assert(准备/执行/断言)结构
- 单元测试不得依赖外部状态(文件系统、网络、数据库)
- 集成测试必须自行清理
- 性能测试必须指定可接受的阈值,超过则失败
- 测试数据必须在测试中或专用夹具(fixture)中定义,绝不使用共享可变状态
- 对外部依赖使用 mock——测试应快速且确定
- 每个 bug 修复必须配有一个能捕获原 bug 的回归测试

## 示例

**正确**(规范命名 + Arrange/Act/Assert):

```gdscript
func test_health_system_take_damage_reduces_health() -> void:
    # Arrange
    var health := HealthComponent.new()
    health.max_health = 100
    health.current_health = 100

    # Act
    health.take_damage(25)

    # Assert
    assert_eq(health.current_health, 75)
```

**错误**:

```gdscript
func test1() -> void:  # VIOLATION: no descriptive name
    var h := HealthComponent.new()
    h.take_damage(25)  # VIOLATION: no arrange step, no clear assert
    assert_true(h.current_health < 100)  # VIOLATION: imprecise assertion
```
