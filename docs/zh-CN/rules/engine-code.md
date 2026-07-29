> 中文翻译 | [English](../../../.claude/rules/engine-code.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。英文版含 paths frontmatter(路径作用域声明),中文版从略。

# 引擎代码规则

- 热路径(更新循环、渲染、物理)中零内存分配——预分配、池化、复用
- 所有引擎 API 必须线程安全,或明确文档注明仅限单线程
- 每次优化前后都要进行性能分析——记录实测数据
- 引擎代码绝不能依赖玩法代码(严格依赖方向:engine <- gameplay)
- 每个公共 API 必须在其文档注释中包含用法示例
- 公共接口的变更需要弃用期和迁移指南
- 对所有资源使用 RAII / 确定性清理
- 所有引擎系统必须支持优雅降级
- 编写引擎 API 代码前,查阅 `docs/engine-reference/` 确认当前引擎版本,并对照参考文档核实 API

## 示例

**正确**(零分配热路径):

```gdscript
# Pre-allocated array reused each frame
var _nearby_cache: Array[Node3D] = []

func _physics_process(delta: float) -> void:
    _nearby_cache.clear()  # Reuse, don't reallocate
    _spatial_grid.query_radius(position, radius, _nearby_cache)
```

**错误**(在热路径中分配内存):

```gdscript
func _physics_process(delta: float) -> void:
    var nearby: Array[Node3D] = []  # VIOLATION: allocates every frame
    nearby = get_tree().get_nodes_in_group("enemies")  # VIOLATION: tree query every frame
```
