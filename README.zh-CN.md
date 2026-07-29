> 中文翻译 | [English](README.md)
> 同步基线:commit `0de6c40`(2026-07-29)+ 双平台 README 同步;如有出入以英文版为准。

<p align="center">
  <h1 align="center">AI Game Studios</h1>
  <p align="center">
    把一个 AI 会话变成一个完整的游戏开发工作室。
    <br />
    49 个代理。73 个技能。一支协同的 AI 团队。
    <br />
    同时支持 <strong>Claude Code</strong> 与 <strong>OpenAI Codex</strong>。
  </p>
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License"></a>
  <a href=".claude/agents"><img src="https://img.shields.io/badge/agents-49-blueviolet" alt="49 Agents"></a>
  <a href=".claude/skills"><img src="https://img.shields.io/badge/skills-73-green" alt="73 Skills"></a>
  <a href=".claude/hooks"><img src="https://img.shields.io/badge/hooks-12-orange" alt="12 Hooks"></a>
  <a href=".claude/rules"><img src="https://img.shields.io/badge/rules-11-red" alt="11 Rules"></a>
  <a href="https://docs.anthropic.com/en/docs/claude-code"><img src="https://img.shields.io/badge/built%20for-Claude%20Code-f5f5f5?logo=anthropic" alt="Built for Claude Code"></a>
  <a href="https://developers.openai.com/codex"><img src="https://img.shields.io/badge/also%20runs%20on-OpenAI%20Codex-000000?logo=openai" alt="Also runs on OpenAI Codex"></a>
</p>

---

## 为什么有这个框架

独自用 AI 做游戏很强大——但单个聊天会话没有结构。没人阻止你硬编码魔法数字、跳过设计文档、写出面条代码。没有 QA 把关,没有设计评审,也没有人问「这真的符合游戏愿景吗?」

**AI Game Studios** 通过给你的 AI 会话赋予真实工作室的结构来解决这个问题。你得到的不是一个通用助手,而是 49 个按工作室层级组织的专业化代理——守护愿景的总监、拥有各自领域的部门主管、动手实现的专家。每个代理都有明确的职责、升级路径(escalation path)和质量门。

最终效果:每一个决定仍由你来做,但现在你有一支团队帮你问出正确的问题、尽早发现错误,并让项目从第一次头脑风暴到正式发布都保持井然有序。

---

## 目录

- [包含内容](#包含内容)
- [双平台支持](#双平台支持)
- [工作室层级](#工作室层级)
- [斜杠命令](#斜杠命令)
- [快速上手](#快速上手)
- [升级](#升级)
- [项目结构](#项目结构)
- [工作方式](#工作方式)
- [设计哲学](#设计哲学)
- [自定义](#自定义)
- [平台支持](#平台支持)
- [社区](#社区)
- [来源与致谢](#来源与致谢)
- [许可证](#许可证)

---

## 包含内容

| 类别 | 数量 | 说明 |
|----------|-------|-------------|
| **代理(Agents)** | 49 | 覆盖设计、程序、美术、音频、叙事、QA 和制作的专业化子代理 |
| **技能(Skills)** | 73 | 覆盖各工作流阶段的斜杠命令(`/start`、`/design-system`、`/create-epics`、`/create-stories`、`/dev-story`、`/story-done` 等) |
| **钩子(Hooks)** | 12 | 在提交、推送、资产变更、会话生命周期、代理审计追踪和缺口检测时自动校验 |
| **规则(Rules)** | 11 | 编辑玩法、引擎、AI、UI、网络代码等文件时强制生效的路径作用域编码标准 |
| **模板(Templates)** | 41 | GDD、UX 规格、ADR、Sprint 计划、HUD 设计、无障碍等文档模板 |

## 双平台支持

本工作室可运行在两大主流 AI 编码平台上。两个平台拥有相同的代理、技能与工作流——选择你已经在用的那个即可:

| 能力 | Claude Code | OpenAI Codex |
|------------|-------------|--------------|
| 入口文件 | `CLAUDE.md` | `AGENTS.md` |
| 代理(49 个) | `.claude/agents/`(Markdown + YAML) | `.codex/agents/`(TOML) |
| 技能 | `.claude/skills/`——以 `/skill` 调用 | `.agents/skills/`——以 `$skill` 调用 |
| 配置 | `.claude/settings.json` | `.codex/config.toml` |
| 钩子 | `.claude/hooks/` | `.codex/hooks.json` + `.codex/hooks/` |
| 路径作用域规则 | `.claude/rules/` | 各规则作用域目录中的嵌套 `AGENTS.md` |

两棵平台树保持同步——新功能同时落地两边。`.claude/` 仍是参考实现;Codex 树是它的镜像。Codex 技能多出两个(`$session-save`、`$session-restore`),用于替代 Codex 所没有的压缩(compact)钩子。

> **注意**:上游模板更新(来自原版 Claude-Code-Game-Studios 仓库)只改动 `.claude/`。拉取上游变更后需要重新同步 Codex 树——见 [UPGRADING.md](UPGRADING.md) 中的双平台说明。

## 工作室层级

代理按三个层级组织,与真实工作室的运作方式一致:

```
Tier 1 — 总监(Opus)
  creative-director    technical-director    producer

Tier 2 — 部门主管(Sonnet)
  game-designer        lead-programmer       art-director
  audio-director       narrative-director    qa-lead
  release-manager      localization-lead

Tier 3 — 专家(Sonnet/Haiku)
  gameplay-programmer  engine-programmer     ai-programmer
  network-programmer   tools-programmer      ui-programmer
  systems-designer     level-designer        economy-designer
  technical-artist     sound-designer        writer
  world-builder        ux-designer           prototyper
  performance-analyst  devops-engineer       analytics-engineer
  security-engineer    qa-tester             accessibility-specialist
  live-ops-designer    community-manager
```

### 引擎专家

模板包含三大主流引擎的代理组。请使用与你项目匹配的那一组:

| 引擎 | 主导代理 | 子专家 |
|--------|-----------|-----------------|
| **Godot 4** | `godot-specialist` | GDScript、着色器、GDExtension |
| **Unity** | `unity-specialist` | DOTS/ECS、着色器/VFX、Addressables、UI Toolkit |
| **Unreal Engine 5** | `unreal-specialist` | GAS、蓝图、复制(Replication)、UMG/CommonUI |

## 斜杠命令

在 Claude Code 中输入 `/`(Codex 中输入 `$`)即可使用全部 73 个技能:

**上手与导航**
`/start` `/help` `/project-stage-detect` `/setup-engine` `/adopt`

**游戏设计**
`/brainstorm` `/map-systems` `/design-system` `/quick-design` `/review-all-gdds` `/propagate-design-change`

**美术与资产**
`/art-bible` `/asset-spec` `/asset-audit`

**UX 与界面设计**
`/ux-design` `/ux-review`

**架构**
`/create-architecture` `/architecture-decision` `/architecture-review` `/create-control-manifest`

**故事与 Sprint**
`/create-epics` `/create-stories` `/dev-story` `/sprint-plan` `/sprint-status` `/story-readiness` `/story-done` `/estimate`

**评审与分析**
`/design-review` `/code-review` `/balance-check` `/content-audit` `/scope-check` `/perf-profile` `/tech-debt` `/gate-check` `/consistency-check` `/security-audit`

**QA 与测试**
`/qa-plan` `/smoke-check` `/soak-test` `/regression-suite` `/test-setup` `/test-helpers` `/test-evidence-review` `/test-flakiness` `/skill-test` `/skill-improve`

**制作**
`/milestone-review` `/retrospective` `/bug-report` `/bug-triage` `/reverse-document` `/playtest-report`

**发布**
`/release-checklist` `/launch-checklist` `/changelog` `/patch-notes` `/hotfix` `/day-one-patch`

**创意与内容**
`/prototype` `/onboard` `/localize`

**团队编排**(针对单个 feature 协调多个代理)
`/team-combat` `/team-narrative` `/team-ui` `/team-release` `/team-polish` `/team-audio` `/team-level` `/team-live-ops` `/team-qa`

## 快速上手

### 前置要求

- [Git](https://git-scm.com/)
- 支持的平台二选一:
  - [Claude Code](https://docs.anthropic.com/en/docs/claude-code)(`npm install -g @anthropic-ai/claude-code`),或
  - [OpenAI Codex](https://developers.openai.com/codex/cli)(`npm install -g @openai/codex`)
- **推荐**:[jq](https://jqlang.github.io/jq/)(用于钩子校验)和 Python 3(用于 JSON 校验)

缺少可选工具时所有钩子都会优雅降级——不会出故障,只是失去校验能力。

### 安装

1. **克隆或作为模板使用**:
   ```bash
   git clone https://github.com/bokmark/ai-game-studio.git my-game
   cd my-game
   ```

2. **打开你的平台**并启动会话:
   ```bash
   claude   # Claude Code
   codex    # OpenAI Codex
   ```

3. **运行 `/start`**(Claude Code)或 **`$start`**(Codex)——系统会询问
   你当前的状态(没有想法、概念模糊、设计清晰、已有成果),并引导你
   进入正确的工作流。不做任何假设。

   如果你已经清楚自己要什么,也可以直接跳到某个技能:
   - `/brainstorm` 或 `$brainstorm` ——从零开始探索游戏创意
   - `/setup-engine godot 4.6` 或 `$setup-engine godot 4.6` ——已确定引擎时直接配置
   - `/project-stage-detect` 或 `$project-stage-detect` ——分析已有项目

## 升级

已经在使用旧版本模板?参见 [UPGRADING.md](UPGRADING.md),其中提供
逐步迁移说明、各版本变更明细,以及哪些文件可以安全覆盖、哪些需要
手动合并。

## 项目结构

```
CLAUDE.md                           # 主配置(Claude Code)
AGENTS.md                           # 主配置(Codex)
.claude/
  settings.json                     # 钩子、权限、安全规则
  agents/                           # 49 个代理定义(markdown + YAML frontmatter)
  skills/                           # 73 个斜杠命令(每个技能一个子目录)
  hooks/                            # 12 个钩子脚本(bash,跨平台)
  rules/                            # 11 条路径作用域编码标准
  statusline.sh                     # 状态栏脚本(上下文 %、模型、阶段、Epic 面包屑)
  docs/
    workflow-catalog.yaml           # 7 阶段流水线定义(由 /help 读取)
    templates/                      # 41 个文档模板
.codex/
  config.toml                       # Codex 沙箱、审批与功能设置
  hooks.json                        # Codex 钩子接线
  hooks/                            # Codex 钩子脚本
  agents/                           # 49 个代理定义(TOML)
.agents/
  skills/                           # 75 个 Codex 技能(73 个镜像 + session-save/restore)
src/                                # 游戏源代码
assets/                             # 美术、音频、VFX、着色器、数据文件
design/                             # GDD、叙事文档、关卡设计
docs/                               # 技术文档与 ADR
tests/                              # 测试套件(单元、集成、性能、试玩)
tools/                              # 构建与流水线工具
prototypes/                         # 一次性原型(与 src/ 隔离)
production/                         # Sprint 计划、里程碑、发布跟踪
```

## 工作方式

### 代理协同

代理遵循结构化的委派模型:

1. **垂直委派** ——总监委派给主管,主管委派给专家
2. **横向协商** ——同级代理可以互相咨询,但不能做有约束力的跨领域决定
3. **冲突解决** ——分歧升级至共同的上一级(设计问题找 `creative-director`,技术问题找 `technical-director`)
4. **变更传播** ——跨部门变更由 `producer` 协调
5. **领域边界** ——没有明确委派,代理不修改自己领域之外的文件

### 协作而非自治

这**不是**一个自动驾驶系统。每个代理都遵循严格的协作协议:

1. **提问** ——代理在给出方案前先提问
2. **给出选项** ——代理展示 2-4 个选项及各自利弊
3. **你来决定** ——用户始终做最终拍板
4. **草稿** ——代理在定稿前展示工作内容
5. **批准** ——没有你的签字确认,不会写入任何内容

控制权始终在你手中。代理提供的是结构与专业知识,而非自治权。

### 自动化安全

**钩子**在每次会话中自动运行:

| 钩子 | 触发时机 | 作用 |
|------|---------|--------------|
| `validate-commit.sh` | PreToolUse (Bash) | 检查硬编码数值、TODO 格式、JSON 合法性、设计文档章节——命令不是 `git commit` 时立即退出 |
| `validate-push.sh` | PreToolUse (Bash) | 推送到受保护分支时发出警告——命令不是 `git push` 时立即退出 |
| `validate-assets.sh` | PostToolUse (Write/Edit) | 校验命名规范与 JSON 结构——文件不在 `assets/` 中时立即退出 |
| `session-start.sh` | 会话开始 | 显示当前分支与最近提交,帮助定位上下文 |
| `detect-gaps.sh` | 会话开始 | 检测全新项目(建议运行 `/start`),以及已有代码或原型但缺少设计文档的情况 |
| `pre-compact.sh` | 压缩前 | 保留会话进度笔记 |
| `post-compact.sh` | 压缩后 | 提醒 Claude 从 `active.md` 恢复会话状态 |
| `notify.sh` | 通知事件 | 通过 PowerShell 显示 Windows  toast 通知 |
| `session-stop.sh` | 会话结束 | 将 `active.md` 归档到会话日志并记录 git 活动 |
| `log-agent.sh` | 代理启动 | 审计追踪开始——记录子代理调用 |
| `log-agent-stop.sh` | 代理停止 | 审计追踪结束——补全子代理记录 |
| `validate-skill-change.sh` | PostToolUse (Write/Edit) | `.claude/skills/` 发生任何变更后建议运行 `/skill-test` |

> **注意**:`validate-commit.sh`、`validate-assets.sh` 和 `validate-skill-change.sh` 会在每次 Bash/Write 工具调用时触发,并在命令或文件路径不相关时立即退出(exit 0)。这是正常的钩子行为——不存在性能问题。

> **Codex 钩子**:Codex 平台支持的钩子事件较少,因此 Codex 树通过 `.codex/hooks.json` 接线 `SessionStart`、`PreToolUse`(shell 命令)和 `Stop`。提交/推送校验在 shell 命令上运行,资产与技能变更校验并入 Stop 时的质量检查。覆盖范围等同,触发时机不同。

`settings.json` 中的**权限规则**自动放行安全操作(git status、运行测试),拦截危险操作(强制推送、`rm -rf`、读取 `.env` 文件)。

### 路径作用域规则

编码标准根据文件位置自动强制生效:

| 路径 | 强制要求 |
|------|----------|
| `src/gameplay/**` | 数值数据驱动、使用 delta time、不引用 UI |
| `src/core/**` | 热路径零分配、线程安全、API 稳定 |
| `src/ai/**` | 性能预算、可调试性、参数数据驱动 |
| `src/networking/**` | 服务器权威、消息版本化、安全 |
| `src/ui/**` | 不持有游戏状态、可本地化、无障碍 |
| `design/gdd/**` | 必备 8 章节、公式格式、边界情况 |
| `tests/**` | 测试命名、覆盖率要求、fixture 模式 |
| `prototypes/**` | 标准放宽、要求 README、记录假设 |

## 设计哲学

本模板植根于专业的游戏开发实践:

- **MDA 框架** ——机制(Mechanics)、动态(Dynamics)、美学(Aesthetics)的游戏设计分析
- **自我决定理论** ——自主感、胜任感、归属感的玩家动机模型
- **心流状态设计** ——挑战与技能平衡的玩家投入度设计
- **Bartle 玩家类型** ——受众定位与验证
- **验证驱动开发** ——先写测试,再做实现

## 自定义

这是一个**模板**,不是锁死的框架。一切都可以自定义:

- **增删代理** ——删掉用不到的代理文件,为你的领域新增代理
- **编辑代理 prompt** ——调整代理行为,注入项目专属知识
- **修改技能** ——调整工作流以匹配你的团队流程
- **新增规则** ——为你的项目目录结构创建新的路径作用域规则
- **调整钩子** ——调节校验严格程度,增加新检查
- **选择引擎** ——使用 Godot、Unity 或 Unreal 代理组(或都不用)
- **设置评审强度** ——`full`(全部总监门)、`lean`(仅阶段门)或 `solo`(无)。在 `/start` 中设置,或编辑 `production/review-mode.txt`。任何技能都可用 `--review solo` 按次覆盖。

## 平台支持

主要开发与测试环境为 **Windows 10** + Git Bash。所有钩子使用 POSIX 兼容写法(`grep -E`,而非 `grep -P`)并为缺失工具准备了降级方案,因此应可在 macOS 和 Linux 上运行。`notify.sh` 钩子使用 PowerShell 实现 Windows toast 通知,在其他平台上为空操作——macOS/Linux 的桌面通知尚未接入。跨平台测试仍在进行中;如遇平台相关问题请提交 issue。

## 社区

- **Discussions** ——[GitHub Discussions](https://github.com/bokmark/ai-game-studio/discussions),用于提问、想法和展示你的作品
- **Issues** ——[缺陷报告与功能请求](https://github.com/bokmark/ai-game-studio/issues)

---

## 来源与致谢

本项目复制自 **[Claude-Code-Game-Studios](https://github.com/Donchitos/Claude-Code-Game-Studios.git)**(作者:[@Donchitos](https://github.com/Donchitos)),并在此基础上扩展了 OpenAI Codex 支持与中英双语文档。原始工作室框架——代理、技能、钩子、规则与模板——的全部功劳属于上游作者。如果这个框架帮到了你,欢迎通过原作者的 [GitHub Sponsors](https://github.com/sponsors/Donchitos) 页面支持原版项目。

---

*为 Claude Code 与 OpenAI Codex 而生。持续维护与扩展——欢迎通过 [GitHub Discussions](https://github.com/bokmark/ai-game-studio/discussions) 贡献。*

## 许可证

MIT 许可证。详见 [LICENSE](LICENSE)。
