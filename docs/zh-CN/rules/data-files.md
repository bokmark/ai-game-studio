> 中文翻译 | [English](../../../.claude/rules/data-files.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。英文版含 paths frontmatter(路径作用域声明),中文版从略。

# 数据文件规则

- 所有 JSON 文件必须是合法 JSON——损坏的 JSON 会阻塞整个构建流水线
- 文件命名:仅使用小写字母和下划线,遵循 `[system]_[name].json` 模式
- 每个数据文件必须有文档化的模式(schema)(JSON Schema 或在相应设计文档中记录)
- 数值必须附带注释或配套文档,解释数字的含义
- 使用一致的键命名:JSON 文件内的键使用 camelCase
- 不允许孤立数据条目——每个条目必须被代码或另一个数据文件引用
- 进行破坏性的模式变更时,为数据文件添加版本
- 为所有可选字段提供合理的默认值

## 示例

**正确**的命名与结构(`combat_enemies.json`):

```json
{
  "goblin": {
    "baseHealth": 50,
    "baseDamage": 8,
    "moveSpeed": 3.5,
    "lootTable": "loot_goblin_common"
  },
  "goblin_chief": {
    "baseHealth": 150,
    "baseDamage": 20,
    "moveSpeed": 2.8,
    "lootTable": "loot_goblin_rare"
  }
}
```

**错误**(`EnemyData.json`):

```json
{
  "Goblin": { "hp": 50 }
}
```

违规项:文件名大写、键大写、不符合 `[system]_[name]` 模式、缺少必填字段。
