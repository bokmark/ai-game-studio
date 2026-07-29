> 中文翻译 | [English](UPGRADING.md)
> 同步基线:commit `0de6c40`(2026-07-29);如有出入以英文版为准。

# 升级 Claude Code Game Studios

本指南介绍如何把现有游戏项目仓库从模板的一个版本升级到下一个版本。

**查找当前版本**,在 git log 中:
```bash
git log --oneline | grep -i "release\|setup"
```
或查看 `README.md` 中的版本徽章。

---

## 目录

- [升级策略](#升级策略)
- [v1.0.0-beta → v1.0](#v100-beta--v10)
- [v0.4.x → v1.0](#v04x--v10)
- [v0.4.0 → v0.4.1](#v040--v041)
- [v0.3.0 → v0.4.0](#v030--v040)
- [v0.2.0 → v0.3.0](#v020--v030)
- [v0.1.0 → v0.2.0](#v010--v020)

---

## 升级策略

拉取模板更新有三种方式。根据你的仓库设置选择。

### 策略 A —— Git 远程合并(推荐)

适用场景:你克隆了模板,并在其上有自己的提交。

```bash
# 把模板添加为远程仓库(一次性设置)
git remote add template https://github.com/Donchitos/Claude-Code-Game-Studios.git

# 拉取新版本
git fetch template main

# 合并到你的分支
git merge template/main --allow-unrelated-histories
```

Git 只会在模板*和你*都改过的文件上标记冲突。逐个解决——你的游戏
内容保留,结构性改进顺带合入。然后提交合并。

**提示:** 最容易冲突的文件是 `CLAUDE.md` 和
`.claude/docs/technical-preferences.md`,因为你已经往里面填了引擎和
项目设置。保留你的内容;接受结构性变更。

---

### 策略 B —— 拣选特定提交(Cherry-pick)

适用场景:你只想要某一个特性(比如只要新技能,不要完整更新)。

```bash
git remote add template https://github.com/Donchitos/Claude-Code-Game-Studios.git
git fetch template main

# 拣选你想要的特定提交
git cherry-pick <commit-sha>
```

各版本对应的提交 SHA 列在下面的版本章节中。

---

### 策略 C —— 手动复制文件

适用场景:你当初不是用 git 安装模板的(只是下载了 zip)。

1. 在你的仓库旁边下载或克隆新版本。
2. 直接复制 **"可安全覆盖"** 下列出的文件。
3. 对于 **"谨慎合并"** 下的文件,并排打开两个版本,手动合并结构性
   变更,同时保留你的内容。

---

## v0.4.1

**发布日期:** 2026-04-02
**关键主题:** 美术指导整合、资产规格管线

### 变更内容

| 类别 | 变更 |
|----------|---------|
| **新技能** | `/art-bible` ——引导式的逐节视觉身份创作(9 个章节)。每节强制派生 art-director 任务。AD-ART-BIBLE 签字门。Technical Setup 阶段必需。 |
| **新技能** | `/asset-spec` ——逐资产的视觉规格与 AI 生成提示词生成器。读取美术圣经 + GDD/关卡/角色文档。写入 `design/assets/specs/` 文件和 `design/assets/asset-manifest.md`。支持 full/lean/solo 模式。 |
| **新总监门(3 个)** | `AD-CONCEPT-VISUAL`(brainstorm 第 4 阶段)、`AD-ART-BIBLE`(美术圣经签字)、`AD-PHASE-GATE`(gate-check 评审团) |
| **`/brainstorm` 更新** | 在 allowed-tools 中新增 `Task`(之前缺失——阻塞了所有总监派生)。pillars 锁定后 art-director 现在与 creative-director 并行派生。Visual Identity Anchor 写入 game-concept.md。 |
| **`/gate-check` 更新** | art-director 成为第 4 位并行总监(AD-PHASE-GATE)。视觉产物检查:Visual Identity Anchor(Concept 门)、美术圣经(Technical Setup 门)、AD-ART-BIBLE 签字 + 角色视觉档案(Pre-Production 门)。 |
| **`/team-level` 更新** | art-director 加入第 1 步并行派生(布局前先定视觉方向)。level-designer 现在把 art-director 的目标作为显式约束接收。第 4 步 art-director 的角色更正为仅制作概念图。 |
| **`/team-narrative` 更新** | art-director 加入第 2 阶段并行派生(角色视觉设计、环境叙事、影视化基调)。 |
| **`/design-system` 更新** | 路由表扩展:Combat、UI、Dialogue、Animation/VFX、Character 类别新增 art-director + technical-artist。7 个系统类别的 Visual/Audio 章节变为强制(含 art-director 任务派生)。 |
| **`workflow-catalog.yaml`** | `/art-bible` 加入 Technical Setup(必需)。`/asset-spec` 加入 Pre-Production(可选,可重复)。 |

### 文件:可安全覆盖

**需要新增的文件:**
```
.claude/skills/art-bible/SKILL.md
.claude/skills/asset-spec/SKILL.md
.claude/docs/director-gates.md
```

**需要覆盖的已有文件(无用户内容):**
```
.claude/skills/brainstorm/SKILL.md
.claude/skills/gate-check/SKILL.md
.claude/skills/team-level/SKILL.md
.claude/skills/team-narrative/SKILL.md
.claude/skills/design-system/SKILL.md
.claude/docs/workflow-catalog.yaml
README.md
UPGRADING.md
```

### 文件:谨慎合并

无——所有变更都在基础设施文件上,不含用户内容。

---

## v1.0.0-beta → v1.0

**发布日期:** 2026-05-13
**提交范围:** `49d1e45..HEAD`
**关键主题:** 新 `/vertical-slice` 门、技能打磨与缺陷修复、贡献者文档

### 变更内容

| 类别 | 变更 |
|----------|---------|
| **新技能** | `/vertical-slice` ——Pre-Production 门,在进入 Production 前用制作级质量的端到端构建验证完整游戏循环。与大改后的 `/prototype` 搭配使用(在 `/brainstorm` 之后立即做概念验证)。 |
| **新流程** | `/map-systems` 新增实体盘点步骤——预先列出所有命名实体,让下游 GDD 写作更干净。 |
| **UX 打磨** | 为 7 个技能补上缺失的 `AskUserQuestion` 组件;对所有技能做一致性、提示语与流程缺口的全面审计;为所有 `team-*` 技能在 `argument-hints` 中暴露 `--review` 标志。 |
| **缺陷修复** | `#21` log-agent 钩子把 `agent_type` 记成 "unknown";`#36` `/architecture-decision` 和 `/story-done` 缺少 `allowed-tools`;`#42` `rg --type gdscript` 无效(改用 `--glob *.gd`);`#43` session-start 预览显示最旧状态而非最新;`#45` `/architecture-decision` 中重复的 `## 0.` 标题与断裂的步骤编号。 |
| **项目文档** | 新增 `CONTRIBUTING.md`(框架贡献准则)和 `SECURITY.md`(协同披露政策)。 |
| **计数/引用** | 同步 `WORKFLOW-GUIDE.md`、`README.md` 与代理名册中的代理/技能/钩子计数;修正过时的代理名与技能模型层级字段。 |

---

### 文件:可安全覆盖

**需要新增的文件:**
```
.claude/skills/vertical-slice/SKILL.md
CONTRIBUTING.md
SECURITY.md
```

**需要覆盖的已有文件(无用户内容):**
- 提交范围内 `.claude/skills/` 下所有被修改的文件(技能审计 + AskUserQuestion 组件 + `--review` argument-hints)
- `.claude/hooks/log-agent.sh`(修复 #21)
- `README.md`、`docs/WORKFLOW-GUIDE.md`、`docs/examples/skill-flow-diagrams.md`
- `UPGRADING.md`

---

### 文件:谨慎合并

无——所有变更都在基础设施文件上,不含用户内容。

---

## v0.4.x → v1.0

**发布日期:** 2026-03-29
**提交范围:** `6c041ac..HEAD`
**关键主题:** 总监门系统、门强度模式、Godot C# 专家

### 变更内容

| 类别 | 变更 |
|----------|---------|
| **新系统** | 总监门——所有工作流技能共享的命名评审检查点。定义于 `.claude/docs/director-gates.md` |
| **新特性** | 门强度模式:`full`(全部总监门)、`lean`(仅阶段门)、`solo`(无总监)。在 `/start` 中通过 `production/review-mode.txt` 全局设置,或在任何使用门的技能上用 `--review [mode]` 按次覆盖 |
| **新代理** | `godot-csharp-specialist` ——Godot 4 项目中的 C# 代码质量 |
| **技能更新(13 个)** | 所有使用门的技能现在解析 `--review [full\|lean\|solo]` 并包含在 argument-hint 中:`brainstorm`、`map-systems`、`design-system`、`architecture-decision`、`create-architecture`、`create-epics`、`create-stories`、`sprint-plan`、`milestone-review`、`playtest-report`、`prototype`、`story-done`、`gate-check` |
| **`/start` 更新** | 新增第 3b 阶段——上手时设置评审模式,写入 `production/review-mode.txt` |
| **`/setup-engine` 更新** | Godot 的语言选择步骤(GDScript vs C#) |
| **文档** | `director-gates.md`——完整门类目录;`WORKFLOW-GUIDE.md`——总监评审模式章节;`README.md`——评审强度自定义 |

---

### 文件:可安全覆盖

**需要新增的文件:**
```
.claude/agents/godot-csharp-specialist.md
.claude/docs/director-gates.md
```

**需要覆盖的已有文件(无用户内容):**
```
.claude/skills/brainstorm/SKILL.md
.claude/skills/map-systems/SKILL.md
.claude/skills/design-system/SKILL.md
.claude/skills/architecture-decision/SKILL.md
.claude/skills/create-architecture/SKILL.md
.claude/skills/create-epics/SKILL.md
.claude/skills/create-stories/SKILL.md
.claude/skills/sprint-plan/SKILL.md
.claude/skills/milestone-review/SKILL.md
.claude/skills/playtest-report/SKILL.md
.claude/skills/prototype/SKILL.md
.claude/skills/story-done/SKILL.md
.claude/skills/gate-check/SKILL.md
.claude/skills/start/SKILL.md
.claude/skills/quick-design/SKILL.md
.claude/skills/setup-engine/SKILL.md
README.md
docs/WORKFLOW-GUIDE.md
UPGRADING.md
```

---

### 文件:谨慎合并

本版本没有需要手动合并的文件。所有变更都在基础设施文件上,不含用户内容。

---

### 新特性

#### 总监门系统

所有主要工作流技能现在引用 `.claude/docs/director-gates.md` 中定义的
命名门检查点。门由领域前缀 + 名称标识(如 `CD-CONCEPT`、
`TD-ARCHITECTURE`、`LP-CODE-REVIEW`)。每个门定义了派生哪位总监、
传入什么输入、裁决含义,以及 lean/solo 模式对它的影响。

技能通过 `Task` 传入门 ID 与文档化输入来派生门,而不是在技能体内
内联总监 prompt。这让技能体保持干净,并保证门行为在所有工作流阶段
一致。

#### 门强度模式

三种模式控制你接受总监评审的强度:

- **`full`**(默认)——每个评审检查点都运行全部总监门
- **`lean`** ——跳过技能级总监评审;`/gate-check` 的阶段门仍运行
- **`solo`** ——完全无总监门;`/gate-check` 只检查产物是否存在

在 `/start` 中全局设置(写入 `production/review-mode.txt`)。在任何
使用门的技能上用 `--review [mode]` 覆盖单次运行:

```
/design-system combat --review lean
/gate-check concept --review full
/brainstorm my-game-idea --review solo
```

---

### 升级后

1. 运行一次 `/start` 设置你偏好的评审模式——或手动创建
   `production/review-mode.txt`,内容为 `full`、`lean` 或 `solo`。
2. 如果项目进行中,查阅 `.claude/docs/director-gates.md` 了解当前
   阶段适用哪些门。
3. 运行 `/skill-test static all` 验证所有技能通过结构检查。

---

## v0.4.0 → v0.4.1

**发布日期:** 2026-03-26
**提交范围:** `04ed5d5..HEAD`
**关键主题:** 流派无关的代理、新技能、技能修复

### 变更内容

| 类别 | 变更 |
|----------|---------|
| **新技能(1 个)** | `/consistency-check` ——跨 GDD 实体一致性扫描器 |
| **技能修复(全部 team-*)** | 新增无参数保护、正式的 `Verdict: COMPLETE / BLOCKED` 关键字、逐步 AskUserQuestion 门、相邻领域依赖检查(team-level)、伦理约束(team-live-ops)、带阶段跳过的 NO-GO 路径(team-release) |
| **代理修复(4 个)** | game-designer、systems-designer、economy-designer、live-ops-designer 改为流派无关的表述——移除 RPG 专属术语 |

---

### 文件:可安全覆盖

**需要新增的文件:**
```
.claude/skills/consistency-check/SKILL.md
```

**需要覆盖的已有文件(无用户内容):**
```
.claude/skills/team-combat/SKILL.md      ← 无参数保护、裁决关键字、门改进
.claude/skills/team-narrative/SKILL.md   ← 无参数保护、裁决关键字、门改进
.claude/skills/team-ui/SKILL.md          ← 无参数保护、裁决关键字、门改进
.claude/skills/team-release/SKILL.md     ← 无参数保护、裁决关键字、NO-GO 路径
.claude/skills/team-polish/SKILL.md      ← 无参数保护、裁决关键字、门改进
.claude/skills/team-audio/SKILL.md       ← 无参数保护、裁决关键字、门改进
.claude/skills/team-level/SKILL.md       ← 无参数保护、裁决关键字、相邻领域检查
.claude/skills/team-live-ops/SKILL.md    ← 无参数保护、裁决关键字、伦理约束
.claude/skills/team-qa/SKILL.md          ← 无参数保护、裁决关键字、门改进
.claude/skills/map-systems/SKILL.md      ← 裁决关键字
.claude/skills/create-epics/SKILL.md     ← "May I write" 协议修复、裁决关键字
.claude/skills/create-stories/SKILL.md   ← 裁决关键字
.claude/agents/game-designer.md          ← 流派无关表述
.claude/agents/systems-designer.md       ← 流派无关表述
.claude/agents/economy-designer.md       ← 流派无关表述
.claude/agents/live-ops-designer.md      ← 流派无关表述
```

---

### 文件:谨慎合并

本版本没有需要手动合并的文件。所有变更都在基础设施文件上,不含用户内容。

---

### 升级后

1. 运行 `/skill-test catalog` 验证所有技能已编入索引。
2. 任何技能编辑后运行 `/skill-test lint [skill-name]` 检查结构合规性。
3. 如果你自定义过任何 team-* 技能,请审阅更新后的版本——无参数保护
   与 `Verdict:` 关键字现在是所有 team-* 技能的必备项。

---

## v0.3.0 → v0.4.0

**发布日期:** 2026-03-21
**提交范围:** `b1cad29..HEAD`
**关键主题:** 完整 UX/UI 管线、完整故事生命周期、既有项目(brownfield)接入、全面的 QA/测试框架、流水线完整性、29 个新技能

### 变更内容

| 类别 | 变更 |
|----------|---------|
| **新技能(17 个)** | `/ux-design`、`/ux-review`、`/help`、`/quick-design`、`/review-all-gdds`、`/story-readiness`、`/story-done`、`/sprint-status`、`/adopt`、`/create-architecture`、`/create-control-manifest`、`/create-epics`、`/create-stories`、`/dev-story`、`/propagate-design-change`、`/content-audit`、`/architecture-review` |
| **新 QA 技能(12 个)** | `/qa-plan`、`/smoke-check`、`/soak-test`、`/regression-suite`、`/test-setup`、`/test-helpers`、`/test-evidence-review`、`/test-flakiness`、`/skill-test`、`/bug-triage`、`/team-live-ops`、`/team-qa` |
| **新钩子(4 个)** | `log-agent-stop.sh`——代理审计追踪结束;`notify.sh`——Windows toast 通知;`post-compact.sh`——压缩后的会话恢复提醒;`validate-skill-change.sh`——技能编辑后建议运行 `/skill-test` |
| **新模板(8 个)** | `ux-spec.md`、`hud-design.md`、`accessibility-requirements.md`、`interaction-pattern-library.md`、`player-journey.md`、`difficulty-curve.md` 及 2 个接入计划模板 |
| **新基础设施** | `workflow-catalog.yaml`(7 阶段流水线,由 `/help` 读取)、`docs/architecture/tr-registry.yaml`(稳定的 TR-ID)、`production/sprint-status.yaml` 模式 |
| **技能更新** | `/gate-check` ——3 个门现在要求 UX 产物;Pre-Production 门要求垂直切片(硬性门) |
| **技能更新** | `/sprint-plan` ——写入 `sprint-status.yaml`;`/sprint-status` 读取它 |
| **技能更新** | `/story-done` ——8 阶段完成评审,更新故事文件,浮现下一个就绪故事 |
| **技能更新** | `/design-review` ——移除架构缺口检查(阶段不对) |
| **技能更新** | `/team-ui` ——完整 UX 管线(ux-design → ux-review → 团队阶段) |
| **代理更新** | 14 个专家代理——新增 `memory: project` |
| **代理更新** | `prototyper` ——`isolation: worktree`(一次性工作在隔离的 git 分支中进行) |
| **模型路由** | 协同规则中写明 Haiku/Sonnet/Opus 层级分配;技能在 frontmatter 中声明自己的层级 |
| **目录级 CLAUDE.md** | 搭建 `design/CLAUDE.md`、`src/CLAUDE.md`、`docs/CLAUDE.md`——各目录的路径作用域指令 |
| **流水线完整性** | TR-ID 稳定性、清单版本化、ADR 状态门、TR-ID 引用而非转述 |
| **GDD 模板** | 新增 `## Game Feel` 章节(输入响应、动画目标、打击感时刻) |

---

### 文件:可安全覆盖

**需要新增的文件:**
```
.claude/skills/ux-design/SKILL.md
.claude/skills/ux-review/SKILL.md
.claude/skills/help/SKILL.md
.claude/skills/quick-design/SKILL.md
.claude/skills/review-all-gdds/SKILL.md
.claude/skills/story-readiness/SKILL.md
.claude/skills/story-done/SKILL.md
.claude/skills/sprint-status/SKILL.md
.claude/skills/adopt/SKILL.md
.claude/skills/create-architecture/SKILL.md
.claude/skills/create-control-manifest/SKILL.md
.claude/skills/create-epics/SKILL.md
.claude/skills/create-stories/SKILL.md
.claude/skills/dev-story/SKILL.md
.claude/skills/propagate-design-change/SKILL.md
.claude/skills/content-audit/SKILL.md
.claude/skills/architecture-review/SKILL.md
.claude/skills/qa-plan/SKILL.md
.claude/skills/smoke-check/SKILL.md
.claude/skills/soak-test/SKILL.md
.claude/skills/regression-suite/SKILL.md
.claude/skills/test-setup/SKILL.md
.claude/skills/test-helpers/SKILL.md
.claude/skills/test-evidence-review/SKILL.md
.claude/skills/test-flakiness/SKILL.md
.claude/skills/skill-test/SKILL.md
.claude/skills/bug-triage/SKILL.md
.claude/skills/team-live-ops/SKILL.md
.claude/skills/team-qa/SKILL.md
.claude/hooks/log-agent-stop.sh
.claude/hooks/notify.sh
.claude/hooks/post-compact.sh
.claude/hooks/validate-skill-change.sh
.claude/docs/workflow-catalog.yaml
.claude/docs/templates/ux-spec.md
.claude/docs/templates/hud-design.md
.claude/docs/templates/accessibility-requirements.md
.claude/docs/templates/interaction-pattern-library.md
.claude/docs/templates/player-journey.md
.claude/docs/templates/difficulty-curve.md
design/CLAUDE.md
src/CLAUDE.md
docs/CLAUDE.md
```

**需要覆盖的已有文件(无用户内容):**
```
.claude/skills/gate-check/SKILL.md
.claude/skills/sprint-plan/SKILL.md
.claude/skills/sprint-status/SKILL.md
.claude/skills/design-review/SKILL.md
.claude/skills/team-ui/SKILL.md
.claude/skills/story-readiness/SKILL.md
.claude/skills/story-done/SKILL.md
.claude/docs/templates/game-design-document.md    ← 新增 Game Feel 章节
README.md
docs/WORKFLOW-GUIDE.md
UPGRADING.md
```

**需要覆盖的代理文件**(如果你没有往里写过自定义 prompt):
```
.claude/agents/prototyper.md         ← 新增 isolation: worktree
.claude/agents/art-director.md       ← 新增 memory: project
.claude/agents/audio-director.md     ← 新增 memory: project
.claude/agents/economy-designer.md   ← 新增 memory: project
.claude/agents/game-designer.md      ← 新增 memory: project
.claude/agents/gameplay-programmer.md ← 新增 memory: project
.claude/agents/lead-programmer.md    ← 新增 memory: project
.claude/agents/level-designer.md     ← 新增 memory: project
.claude/agents/narrative-director.md ← 新增 memory: project
.claude/agents/systems-designer.md   ← 新增 memory: project
.claude/agents/technical-artist.md   ← 新增 memory: project
.claude/agents/ui-programmer.md      ← 新增 memory: project
.claude/agents/ux-designer.md        ← 新增 memory: project
.claude/agents/world-builder.md      ← 新增 memory: project
```

---

### 文件:谨慎合并

#### `.claude/settings.json`

本版本注册了四个新钩子。如果你没有自定义过 `settings.json`,直接
覆盖是安全的。否则请手动添加以下钩子条目:

- `log-agent-stop.sh` —— `SubagentStop` 事件(代理审计追踪结束)
- `notify.sh` —— `Notification` 事件(Windows toast 通知)
- `post-compact.sh` —— `PostCompact` 事件(会话恢复提醒)
- `validate-skill-change.sh` —— `PostToolUse` 事件,过滤 `.claude/skills/` 写入

#### 自定义过的代理文件

如果你往代理 `.md` 文件里加过项目专属知识,请做 diff,并在合适的
位置手动把 `memory: project` 加进 YAML frontmatter。创意与技术总监
代理有意保持 `memory: user` ——只有专家代理用 `memory: project`。

---

### 新特性

#### 完整故事生命周期

故事现在有两个技能强制的正式生命周期:

- **`/story-readiness`** ——在开发者领走故事前验证其已达到可实施状态。
  检查设计(GDD 需求已链接)、架构(ADR 已接受)、范围(验收标准可
  测试)和 DoD(清单版本为最新)。裁决:READY / NEEDS WORK / BLOCKED。
- **`/story-done`** ——实现后的 8 阶段完成评审。逐条验证验收标准,
  检查 GDD/ADR 偏差,提示代码评审,把故事文件更新为 `Status: Complete`,
  并浮现下一个就绪故事。

流程:`/story-readiness` → 实现 → `/story-done` → 下一个故事

#### 完整 UX/UI 管线

- **`/ux-design`** ——引导式逐节 UX 规格创作。三种模式:屏幕/流程、
  HUD、交互模式库。读取 GDD UI 需求与玩家旅程。输出到 `design/ux/`。
- **`/ux-review`** ——对照 GDD 一致性、无障碍等级与模式库验证 UX 规格。
  裁决:APPROVED / NEEDS REVISION / MAJOR REVISION。
- **`/team-ui`** 更新:第 1 阶段现在以 `/ux-design` + `/ux-review` 作为
  视觉设计开始前的硬性门。

#### 既有项目接入(Brownfield Adoption)

**`/adopt`** 把已有项目接入模板格式。审计 GDD、ADR、故事、
systems-index 和基础设施的内部结构。把缺口分类(BLOCKING/HIGH/
MEDIUM/LOW)。构建有序的迁移计划。绝不重新生成已有产物——只补缺口。

参数模式:`full | gdds | adrs | stories | infra`

另外:`/design-system retrofit [path]` 和 `/architecture-decision
retrofit [path]` 会检测已有文件并只补缺失章节。

#### Sprint 跟踪 YAML

`production/sprint-status.yaml` 现在是权威的故事跟踪格式:
- 由 `/sprint-plan` 写入(初始化所有故事)和 `/story-done` 写入
  (把状态设为 `done`)
- 由 `/sprint-status`(快速快照)和 `/help`(生产阶段的逐故事状态)读取
- 状态值:`backlog | ready-for-dev | in-progress | review | done | blocked`
- 文件不存在时优雅降级为 markdown 扫描

#### `/help` ——上下文感知的下一步

`/help` 读取你当前所处的阶段和进行中的工作,检查哪些产物已完成,
并明确告诉你下一步做什么——一个主要必需步骤,加上可选的机会。
与 `/start`(仅首次)和 `/project-stage-detect`(全面审计)不同。

#### 全面的 QA 与测试框架

九个覆盖完整测试生命周期的新 QA/测试技能:

- **`/test-setup`** ——为你的引擎搭建测试框架与 CI/CD 管线
- **`/test-helpers`** ——生成引擎专属的测试辅助库(GDUnit4、NUnit 等)
- **`/qa-plan`** ——为 Sprint 或特性生成 QA 测试计划,按测试类型给故事分类
- **`/smoke-check`** ——QA 交接前运行关键路径冒烟测试门
- **`/soak-test`** ——为长时间试玩会话生成浸泡测试协议(稳定性、内存泄漏)
- **`/regression-suite`** ——把测试覆盖映射到 GDD 关键路径,找出缺少回归测试的已修复缺陷
- **`/test-evidence-review`** ——测试文件与手动测试证据文档的质量评审
- **`/test-flakiness`** ——通过读取 CI 运行日志检测非确定性测试
- **`/skill-test`** ——验证技能文件的结构合规与行为正确性(三种模式:lint、spec、catalog)

另有新技能:**`/bug-triage`** 重新评估所有未关闭缺陷的优先级、
严重度与归属。

#### 技能验证器(`/skill-test`)

`/skill-test` 是验证框架本身的元技能。编辑任何技能文件后运行它。
三种模式:
- `lint` ——验证 YAML frontmatter 与必填字段
- `spec [skill-name]` ——对特定技能运行行为规格测试
- `catalog` ——检查 `.claude/skills/` 中的所有技能都已编入目录

新的 `validate-skill-change.sh` 钩子会在技能文件被修改时自动提醒你
运行 `/skill-test`。

#### 团队在线运营与团队 QA 编排

- **`/team-live-ops`** ——协调 live-ops-designer + economy-designer +
  community-manager + analytics-engineer 做发布后内容规划(赛季活动、
  战斗通行证、留存)
- **`/team-qa`** ——编排 qa-lead + qa-tester + gameplay-programmer +
  producer 走完整个 QA 周期:策略、执行、覆盖率与签字

#### 模型层级路由

技能现在按任务复杂度明确分配到 Haiku、Sonnet 或 Opus 层级。只读
状态检查用 Haiku;复杂的多文档综合用 Opus;其余默认 Sonnet。层级
分配记录在 `.claude/docs/coordination-rules.md`。

#### 目录级 CLAUDE.md 文件

三个新的目录作用域 CLAUDE.md 文件(`design/`、`src/`、`docs/`)为在
这些目录中工作的代理提供路径相关的指令。当 Claude Code 读取该目录中
的文件时自动加载。

---

### 升级后

1. **验证新钩子**已注册到 `.claude/settings.json` ——四个都要检查:
   `log-agent-stop.sh`、`notify.sh`、`post-compact.sh`、
   `validate-skill-change.sh`。

2. **测试审计追踪**:派生任意子代理——开始与结束事件都应出现在
   `production/session-logs/` 中。

3. **生成 sprint-status.yaml**(如果你正在活跃生产期):
   ```
   /sprint-plan status
   ```

4. **运行 `/adopt`**(如果你有早于本模板版本的 GDD 或 ADR)——它会
   指出需要补哪些章节,且不会覆盖你的内容。

5. **验证你的技能**:任何技能编辑后用 `/skill-test` ——新的
   `validate-skill-change.sh` 钩子会自动提醒你做这件事。

---

## v0.2.0 → v0.3.0

**发布日期:** 2026-03-09
**提交范围:** `e289ce9..HEAD`
**关键主题:** `/design-system` GDD 创作、`/map-systems` 更名、自定义状态栏

### 破坏性变更

#### `/design-systems` 更名为 `/map-systems`

`/design-systems` 技能更名为 `/map-systems`,语义更准确
(分解 = *映射(mapping)*,而非 *设计(designing)*)。

**需要采取行动:** 更新所有调用 `/design-systems` 的文档、笔记或
脚本。新的调用方式是 `/map-systems`。

### 变更内容

| 类别 | 变更 |
|----------|---------|
| **新技能** | `/design-system`(引导式逐节 GDD 创作) |
| **更名技能** | `/design-systems` → `/map-systems`(破坏性更名) |
| **新文件** | `.claude/statusline.sh`、`.claude/settings.json` 状态栏配置 |
| **技能更新** | `/gate-check` ——PASS 时写入 `production/stage.txt`,新的阶段定义 |
| **技能更新** | `brainstorm`、`start`、`design-review`、`project-stage-detect`、`setup-engine` ——交叉引用修复 |
| **缺陷修复** | `log-agent.sh`、`validate-commit.sh` ——钩子执行修复 |
| **文档** | 新增 `UPGRADING.md`,更新 `README.md`、`WORKFLOW-GUIDE.md` |

---

### 文件:可安全覆盖

**需要新增的文件:**
```
.claude/skills/design-system/SKILL.md
.claude/statusline.sh
```

**需要覆盖的已有文件(无用户内容):**
```
.claude/skills/map-systems/SKILL.md      ← 原 design-systems/SKILL.md
.claude/skills/gate-check/SKILL.md
.claude/skills/brainstorm/SKILL.md
.claude/skills/start/SKILL.md
.claude/skills/design-review/SKILL.md
.claude/skills/project-stage-detect/SKILL.md
.claude/skills/setup-engine/SKILL.md
.claude/hooks/log-agent.sh
.claude/hooks/validate-commit.sh
README.md
docs/WORKFLOW-GUIDE.md
UPGRADING.md
```

**删除(已被更名取代):**
```
.claude/skills/design-systems/   ← 整个目录;由 map-systems/ 取代
```

---

### 文件:谨慎合并

#### `.claude/settings.json`

新版本添加了指向 `.claude/statusline.sh` 的 `statusLine` 配置块。
如果你没有自定义过 `settings.json`,直接覆盖是安全的。否则手动
添加这个块:

```json
"statusLine": {
  "script": ".claude/statusline.sh"
}
```

---

### 新特性

#### 自定义状态栏

`.claude/statusline.sh` 在终端状态栏显示 7 阶段生产流水线面包屑:

```
ctx: 42% | claude-sonnet-4-6 | Systems Design
```

在 Production/Polish/Release 阶段,如果 `production/session-state/active.md`
中存在 `<!-- STATUS -->` 块,还会显示当前活跃的 Epic/Feature/Task:

```
ctx: 42% | claude-sonnet-4-6 | Production | Combat System > Melee Combat > Hitboxes
```

当前阶段从项目产物自动检测,也可以通过把阶段名写入
`production/stage.txt` 来固定。

#### `/gate-check` 阶段推进

当门的 PASS 裁决被确认时,`/gate-check` 现在会把新阶段名写入
`production/stage.txt`。之后所有会话的状态栏立即更新,无需手动
编辑文件。

---

### 升级后

1. **删除旧技能目录:**
   ```bash
   rm -rf .claude/skills/design-systems/
   ```

2. **测试状态栏**:启动一个 Claude Code 会话——你应该能在终端底部
   看到阶段面包屑。

3. **验证钩子执行**仍然正常:
   ```bash
   bash .claude/hooks/log-agent.sh '{}' '{}'
   bash .claude/hooks/validate-commit.sh '{}' '{}'
   ```

---

## v0.1.0 → v0.2.0

**发布日期:** 2026-02-21
**提交范围:** `ad540fe..e289ce9`
**关键主题:** 上下文韧性、AskUserQuestion 集成、`/map-systems` 技能

### 变更内容

| 类别 | 变更 |
|----------|---------|
| **新技能** | `/start`(上手指引)、`/map-systems`(系统分解)、`/design-system`(引导式 GDD 创作) |
| **新钩子** | `session-start.sh`(恢复)、`detect-gaps.sh`(缺口检测) |
| **新模板** | `systems-index.md`、3 个协作协议模板 |
| **上下文管理** | 重大重写——新增文件持久化状态策略 |
| **代理更新** | 14 个设计/创意代理——AskUserQuestion 集成 |
| **技能更新** | 全部 7 个 `team-*` 技能 + `brainstorm` ——阶段转换处使用 AskUserQuestion |
| **CLAUDE.md** | 从约 159 行精简到约 60 行;文档导入从 10 个减到 5 个 |
| **钩子更新** | 全部 8 个钩子——Windows 兼容性修复、新特性 |
| **移除文档** | `docs/IMPROVEMENTS-PROPOSAL.md`、`docs/MULTI-STAGE-DOCUMENT-WORKFLOW.md` |

---

### 文件:可安全覆盖

这些是纯基础设施——你没有自定义过它们。直接复制新版本,
不会影响你的项目内容。

**需要新增的文件:**
```
.claude/skills/start/SKILL.md
.claude/skills/map-systems/SKILL.md
.claude/skills/design-system/SKILL.md
.claude/docs/templates/systems-index.md
.claude/docs/templates/collaborative-protocols/design-agent-protocol.md
.claude/docs/templates/collaborative-protocols/implementation-agent-protocol.md
.claude/docs/templates/collaborative-protocols/leadership-agent-protocol.md
.claude/hooks/detect-gaps.sh
.claude/hooks/session-start.sh
production/session-state/.gitkeep
docs/examples/README.md
.github/ISSUE_TEMPLATE/bug_report.md
.github/ISSUE_TEMPLATE/feature_request.md
.github/PULL_REQUEST_TEMPLATE.md
```

**需要覆盖的已有文件(无用户内容):**
```
.claude/skills/brainstorm/SKILL.md
.claude/skills/design-review/SKILL.md
.claude/skills/gate-check/SKILL.md
.claude/skills/project-stage-detect/SKILL.md
.claude/skills/setup-engine/SKILL.md
.claude/skills/team-audio/SKILL.md
.claude/skills/team-combat/SKILL.md
.claude/skills/team-level/SKILL.md
.claude/skills/team-narrative/SKILL.md
.claude/skills/team-polish/SKILL.md
.claude/skills/team-release/SKILL.md
.claude/skills/team-ui/SKILL.md
.claude/hooks/log-agent.sh
.claude/hooks/pre-compact.sh
.claude/hooks/session-stop.sh
.claude/hooks/validate-assets.sh
.claude/hooks/validate-commit.sh
.claude/hooks/validate-push.sh
.claude/rules/design-docs.md
.claude/docs/hooks-reference.md
.claude/docs/skills-reference.md
.claude/docs/quick-start.md
.claude/docs/directory-structure.md
.claude/docs/context-management.md
docs/COLLABORATIVE-DESIGN-PRINCIPLE.md
docs/WORKFLOW-GUIDE.md
README.md
```

**需要覆盖的代理文件**(如果你没有往里写过自定义 prompt):
```
.claude/agents/art-director.md
.claude/agents/audio-director.md
.claude/agents/creative-director.md
.claude/agents/economy-designer.md
.claude/agents/game-designer.md
.claude/agents/level-designer.md
.claude/agents/live-ops-designer.md
.claude/agents/narrative-director.md
.claude/agents/producer.md
.claude/agents/systems-designer.md
.claude/agents/technical-director.md
.claude/agents/ux-designer.md
.claude/agents/world-builder.md
.claude/agents/writer.md
```

如果你*已经*自定义过代理 prompt,见下面的"谨慎合并"。

---

### 文件:谨慎合并

这些文件同时包含模板结构和你的项目专属内容。请**不要**覆盖
——手动合并变更。

#### `CLAUDE.md`

模板版本从约 159 行精简到约 60 行。关键结构变化:5 个文档导入
被移除,因为 Claude Code 本来就会自动加载它们(agent-roster、
skills-reference、hooks-reference、rules-reference、
review-workflow)。

**保留你版本中的:**
- `## Technology Stack` 章节(你的引擎/语言选择)
- 你添加的任何项目专属内容

**采纳新版本中的:**
- 更精简的导入列表(删掉那 5 个冗余的 `@` 导入,如果有的话)
- 更新后的协作协议措辞

#### `.claude/docs/technical-preferences.md`

如果你运行过 `/setup-engine`,这个文件里有你的引擎配置、命名规范
和性能预算。全部保留。模板版本只是空占位符。

#### `.claude/docs/templates/game-concept.md`

小的结构更新——新增 `## Next Steps` 章节,指向 `/map-systems`。
如果你想要更新后的指引,可以把该章节加到你的副本里,但不是必须。

#### `.claude/settings.json`

检查新版本是否添加了你想要的权限规则。本次变更很小(schema 更新)。
如果你没有自定义过 `settings.json`,直接覆盖是安全的。

#### 自定义过的代理文件

如果你往任何代理 `.md` 文件里加过项目专属知识或自定义行为,请做
diff,并手动添加新的 AskUserQuestion 集成章节,而不是直接覆盖。
每个代理的变更都是系统 prompt 末尾一段标准化的协作协议块。

---

### 文件:删除

这些文件在 v0.2.0 中被移除。如果你的仓库里还有,可以安全删除
——它们已被组织得更好的替代方案取代。

```
docs/IMPROVEMENTS-PROPOSAL.md      → 由 WORKFLOW-GUIDE.md 取代
docs/MULTI-STAGE-DOCUMENT-WORKFLOW.md → 内容并入 context-management.md
```

---

### 升级后

1. **运行 `/project-stage-detect`** 验证系统能用新的检测逻辑正确
   读取你的项目。

2. **运行一次 `/start`**(如果你还没用过)——它现在能正确识别你的
   阶段,并跳过你已经完成的上手步骤。

3. **检查 `production/session-state/`** 存在且已被 gitignore:
   ```bash
   ls production/session-state/
   cat .gitignore | grep session-state
   ```

4. **测试钩子执行** ——如果你在 Windows 上,验证新钩子在 Git Bash
   中无报错运行:
   ```bash
   bash .claude/hooks/detect-gaps.sh '{}' '{}'
   bash .claude/hooks/session-start.sh '{}' '{}'
   ```

---

*未来的每个版本都会在本文件中有自己的章节。*
