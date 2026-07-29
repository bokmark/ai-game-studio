> 中文翻译 | [English](setup-requirements.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# 安装要求

本模板需要安装少量工具才能获得完整功能。所有钩子(hook)在缺少工具时都会优雅降级——不会有任何损坏,但你会失去校验功能。

## 必需

| 工具 | 用途 | 安装 |
| ---- | ---- | ---- |
| **Git** | 版本控制、分支管理 | [git-scm.com](https://git-scm.com/) |
| **Claude Code** | AI 代理 CLI | `npm install -g @anthropic-ai/claude-code` |

## 推荐

| 工具 | 使用者 | 用途 | 安装 |
| ---- | ---- | ---- | ---- |
| **jq** | 钩子(12 个中的 7 个) | 提交/推送/资产/代理钩子中的 JSON 解析 | 见下文 |
| **Python 3** | 钩子(12 个中的 2 个) | 数据文件的 JSON 校验 | [python.org](https://www.python.org/) |
| **Bash** | 所有钩子 | Shell 脚本执行 | Git for Windows 自带 |

### 安装 jq

**Windows**(任选其一):
```
winget install jqlang.jq
choco install jq
scoop install jq
```

**macOS**:
```
brew install jq
```

**Linux**:
```
sudo apt install jq     # Debian/Ubuntu
sudo dnf install jq     # Fedora
sudo pacman -S jq       # Arch
```

## 平台说明

### Windows
- Git for Windows 自带 **Git Bash**,它提供 `settings.json` 中所有钩子使用的 `bash` 命令
- 确保 Git Bash 在你的 PATH 中(通过 Git 安装程序安装时默认如此)
- 钩子使用 `bash .claude/hooks/[name].sh`——这在 Windows 上可行,因为 Claude Code 通过能找到 `bash.exe` 的 shell 来调用命令

### macOS / Linux
- 原生提供 Bash
- 通过包管理器安装 `jq`,以获得完整的钩子支持

## 验证你的安装

运行以下命令检查先决条件:

```bash
git --version          # Should show git version
bash --version         # Should show bash version
jq --version           # Should show jq version (optional)
python3 --version      # Should show python version (optional)
```

## 缺少可选工具时会发生什么

| 缺少的工具 | 影响 |
| ---- | ---- |
| **jq** | 提交校验、推送保护、资产校验和代理审计钩子会静默跳过检查。提交和推送仍然可用。 |
| **Python 3** | 提交钩子和资产钩子中的 JSON 数据文件校验会被跳过。无效 JSON 可能在无警告的情况下被提交。 |
| **两者都缺** | 所有钩子仍会正常执行(退出码 0),但不提供任何校验。你将在没有安全网的情况下工作。 |

## 推荐 IDE

Claude Code 可与任何编辑器配合,但本模板针对以下环境做了优化:
- 带 Claude Code 扩展的 **VS Code**
- **Cursor**(兼容 Claude Code)
- 基于终端的 Claude Code CLI
