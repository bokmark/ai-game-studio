> 中文翻译 | [English](settings-local-template.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# settings.local.json 模板

创建 `.claude/settings.local.json`,用于存放不应提交到版本控制的个人覆盖配置。请将它加入 `.gitignore`。

## settings.local.json 示例

```json
{
  "permissions": {
    "allow": [
      "Bash(git *)",
      "Bash(npm *)",
      "Read",
      "Glob",
      "Grep"
    ],
    "deny": [
      "Bash(rm -rf *)",
      "Bash(git push --force *)"
    ]
  }
}
```

## 权限模式

Claude Code 支持不同的权限模式。游戏开发推荐:

### 开发期间(默认)
使用**普通模式**——Claude 在运行大多数命令前会先询问。这对生产代码最安全。

### 原型制作期间
使用限定范围的**自动接受模式**——对一次性代码迭代更快。仅在 `prototypes/` 目录中工作时使用。

### 代码评审期间
使用**只读**权限——Claude 可以读取和搜索,但不能修改文件。

## 本地自定义钩子

你可以在 `settings.local.json` 中添加个人钩子(hook),用于扩展(而非覆盖)项目钩子。例如,在构建完成时添加通知:

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "bash -c 'echo Session ended at $(date)'",
            "timeout": 5
          }
        ]
      }
    ]
  }
}
```
