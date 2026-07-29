> 中文翻译 | [English](hooks-reference.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# 已启用的钩子

钩子(hook)在 `.claude/settings.json` 中配置,并自动触发:

| 钩子 | 事件 | 触发条件 | 动作 |
| ---- | ---- | -------- | ---- |
| `validate-commit.sh` | PreToolUse (Bash) | `git commit` 命令 | 校验设计文档章节、JSON 数据文件、硬编码值、TODO 格式 |
| `validate-push.sh` | PreToolUse (Bash) | `git push` 命令 | 对推送到受保护分支(develop/main)发出警告 |
| `validate-assets.sh` | PostToolUse (Write/Edit) | 资产文件变更 | 检查 `assets/` 中文件的命名规范与 JSON 合法性 |
| `session-start.sh` | SessionStart | 会话开始 | 加载 Sprint 上下文、里程碑、Git 活动;检测并预览活跃会话状态文件以便恢复 |
| `detect-gaps.sh` | SessionStart | 会话开始 | 检测全新项目(建议 /start),以及代码/原型已存在但文档缺失的情况,建议 /reverse-document 或 /project-stage-detect |
| `pre-compact.sh` | PreCompact | 上下文压缩 | 在压缩前将会话状态(active.md、已修改文件、进行中的设计文档)转储到对话中,使其在摘要后仍然保留 |
| `post-compact.sh` | PostCompact | 压缩完成后 | 提醒 Claude 从 `active.md` 检查点恢复会话状态 |
| `notify.sh` | Notification | 通知事件 | 通过 PowerShell 显示 Windows Toast 通知 |
| `session-stop.sh` | Stop | 会话结束 | 总结本次成果并更新会话日志 |
| `log-agent.sh` | SubagentStart | 代理生成 | 审计追踪开始 —— 记录子代理调用及时间戳 |
| `log-agent-stop.sh` | SubagentStop | 代理停止 | 审计追踪结束 —— 补全子代理记录 |
| `validate-skill-change.sh` | PostToolUse (Write/Edit) | 技能文件变更 | 在任何 `.claude/skills/` 文件被写入或编辑后,建议运行 `/skill-test` |

钩子参考文档:`.claude/docs/hooks-reference/`
钩子输入模式(hook input schema)文档:`.claude/docs/hooks-reference/hook-input-schemas.md`
