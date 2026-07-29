> 中文翻译 | [English](WORKFLOW-GUIDE.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# AI Game Studios——完整工作流指南

> **如何使用代理架构从零走到游戏发布。**
>
> 本指南带你使用 49 个代理的系统、73 个斜杠命令和 12 个自动化钩子(hook)走完游戏开发的每个阶段。假设你已安装 Claude Code,并在项目根目录下工作。
>
> 流水线共 7 个阶段。每个阶段都有正式的阶段门(`/gate-check`),必须通过才能推进。权威的阶段顺序定义在 `.claude/docs/workflow-catalog.yaml` 中,由 `/help` 读取。

---

## 目录

1. [快速开始](#快速开始)
2. [第 1 阶段:概念](#第-1-阶段概念)
3. [第 2 阶段:系统设计](#第-2-阶段系统设计)
4. [第 3 阶段:技术准备](#第-3-阶段技术准备)
5. [第 4 阶段:预制作](#第-4-阶段预制作)
6. [第 5 阶段:制作](#第-5-阶段制作)
7. [第 6 阶段:打磨](#第-6-阶段打磨)
8. [第 7 阶段:发布](#第-7-阶段发布)
9. [横切关注点](#横切关注点)
10. [附录 A:代理速查](#附录-a代理速查)
11. [附录 B:斜杠命令速查](#附录-b斜杠命令速查)
12. [附录 C:常见工作流](#附录-c常见工作流)

---

## 快速开始

### 你需要什么

开始之前,确保你有:

- **Claude Code** 已安装并能正常工作
- **Git**,附 Git Bash(Windows)或标准终端(Mac/Linux)
- **jq**(可选但推荐——缺失时钩子回退到 `grep`)
- **Python 3**(可选——部分钩子用它做 JSON 校验)

### 第 1 步:克隆并打开

```bash
git clone <repo-url> my-game
cd my-game
```

### 第 2 步:运行 /start

如果这是你的第一个会话:

```
/start
```

这个引导式上手指引会询问你当前所处位置,并把你路由到正确的阶段:

- **路径 A** —— 还没有点子:路由到 `/brainstorm`
- **路径 B** —— 模糊的想法:带着种子路由到 `/brainstorm`
- **路径 C** —— 明确的概念:路由到 `/setup-engine` 和 `/map-systems`
- **路径 D1** —— 已有项目,产物很少:走正常流程
- **路径 D2** —— 已有项目,已有 GDD/ADR:先运行 `/project-stage-detect`,再用 `/adopt` 做既有项目(brownfield)迁移

### 第 3 步:验证钩子正常工作

启动一个新的 Claude Code 会话。你应该看到 `session-start.sh` 钩子的输出:

```
=== AI Game Studios -- Session Context ===
Branch: main
Recent commits:
  abc1234 Initial commit
===================================
```

如果看到这些,说明钩子正常。如果没有,检查 `.claude/settings.json`,确认钩子路径与你的操作系统匹配。

### 第 4 步:随时求助

在任何时候运行:

```
/help
```

它会从 `production/stage.txt` 读取你当前所处的阶段,检查哪些产物已存在,并明确告诉你下一步做什么。它会区分必需的下一步和可选的机会。

### 第 5 步:创建目录结构

目录按需创建。系统期望的布局如下:

```
src/                  # Game source code
  core/               # Engine/framework code
  gameplay/           # Gameplay systems
  ai/                 # AI systems
  networking/         # Multiplayer code
  ui/                 # UI code
  tools/              # Dev tools
assets/               # Game assets
  art/                # Sprites, models, textures
  audio/              # Music, SFX
  vfx/                # Particle effects
  shaders/            # Shader files
  data/               # JSON config/balance data
design/               # Design documents
  gdd/                # Game design documents
  narrative/          # Story, lore, dialogue
  levels/             # Level design documents
  balance/            # Balance spreadsheets and data
  ux/                 # UX specifications
docs/                 # Technical documentation
  architecture/       # Architecture Decision Records
  api/                # API documentation
  postmortems/        # Post-mortems
tests/                # Test suites
prototypes/           # Throwaway prototypes
production/           # Sprint plans, milestones, releases
  sprints/
  milestones/
  releases/
  epics/              # Epic and story files (from /create-epics + /create-stories)
  playtests/          # Playtest reports
  session-state/      # Ephemeral session state (gitignored)
  session-logs/       # Session audit trail (gitignored)
```

> **提示:** 第一天并不需要所有这些目录。到了需要它们的阶段再创建即可。重要的是创建时遵循此结构,因为**规则系统**会基于文件路径执行标准。`src/gameplay/` 中的代码适用玩法规则,`src/ai/` 中的代码适用 AI 规则,以此类推。

---

## 第 1 阶段:概念

### 本阶段做什么

你从「没有点子」或「模糊想法」走到一份结构化的游戏概念文档,其中定义了游戏支柱和玩家旅程。这一阶段弄清楚你在做**什么**以及**为什么**。

### 第 1 阶段流水线

```
/brainstorm  -->  game-concept.md  -->  /design-review  -->  /setup-engine
     |                                        |                    |
     v                                        v                    v
  10 concepts     Concept doc with       Validation          Engine pinned in
  MDA analysis    pillars, MDA,          of concept          technical-preferences.md
  Player motiv.   core loop, USP         document
                                                                   |
                                                                   v
                                                             /prototype
                                                       (concept prototype — 1-3 days)
                                                        PROCEED ↓     PIVOT → /brainstorm
                                                                   |
                                                                   v (PROCEED)
                                                             /map-systems
                                                                   |
                                                                   v
                                                            systems-index.md
                                                            (all systems, deps,
                                                             priority tiers)
```

### 步骤 1.1:用 /brainstorm 头脑风暴

这是你的起点。运行头脑风暴技能:

```
/brainstorm
```

或带上类型提示:

```
/brainstorm roguelike deckbuilder
```

**会发生什么:** 头脑风暴技能用专业工作室的方法,引导你走完 6 个阶段的协作式创意流程:

1. 询问你的兴趣、主题和约束
2. 生成 10 个概念种子,并做 MDA(机制、动态、美学)分析
3. 你挑 2-3 个最喜欢的做深度分析
4. 进行玩家动机映射与目标受众定位
5. 你选出最终概念
6. 将其正式化写入 `design/gdd/game-concept.md`

概念文档包含:

- 电梯演讲(一句话)
- 核心幻想(玩家想象自己在做什么)
- MDA 拆解
- 目标受众(Bartle 玩家类型、人口特征)
- 核心循环图
- 独特卖点
- 同类作品与差异化
- 游戏支柱(3-5 条不可妥协的设计价值观)
- 反支柱(游戏有意回避的东西)

### 步骤 1.2:评审概念(可选但推荐)

```
/design-review design/gdd/game-concept.md
```

在继续之前验证结构与完整性。

### 步骤 1.3:选择引擎

```
/setup-engine
```

或指定引擎:

```
/setup-engine godot 4.6
```

**/setup-engine 会做什么:**

- 用命名约定、性能预算和引擎特定默认值填充 `.claude/docs/technical-preferences.md`
- 检测知识缺口(引擎版本新于 LLM 训练数据),并建议交叉查阅 `docs/engine-reference/`
- 在 `docs/engine-reference/` 中创建版本锁定的参考文档

**为什么重要:** 设定引擎后,系统就知道该用哪些引擎专家代理。如果你选 Godot,`godot-specialist`、`godot-gdscript-specialist`、`godot-shader-specialist` 等代理就会成为你的首选专家。

### 步骤 1.4:将概念分解为系统

在撰写单个 GDD 之前,先枚举游戏需要的所有系统:

```
/map-systems
```

这会创建 `design/gdd/systems-index.md`——一份主追踪文档,它会:

- 列出游戏需要的每个系统(战斗、移动、UI 等)
- 映射系统之间的依赖
- 划分优先级层级(MVP、垂直切片、Alpha、完整愿景)
- 确定设计顺序(基础(Foundation)> 核心(Core)> 功能(Feature)> 表现(Presentation)> 打磨(Polish))

这一步是进入第 2 阶段前的**必需步骤**。对 155 份游戏复盘的研究证实,跳过系统枚举会在制作阶段付出 5-10 倍的代价。

### 第 1 阶段门

```
/gate-check concept
```

**通过要求:**

- `technical-preferences.md` 中已配置引擎
- `design/gdd/game-concept.md` 存在且含支柱
- `design/gdd/systems-index.md` 存在且含依赖排序

**结论:** PASS / CONCERNS / FAIL。CONCERNS 表示在已确认风险的情况下可通过。FAIL 会阻止推进。

---

## 第 2 阶段:系统设计

### 本阶段做什么

你创建定义游戏运作方式的全部设计文档。此阶段不写任何代码——纯设计。系统索引中识别出的每个系统都会有自己的 GDD,逐节撰写、单独评审,最后所有 GDD 一起做一致性交叉检查。

### 第 2 阶段流水线

```
/map-systems next  -->  /design-system  -->  /design-review
       |                     |                     |
       v                     v                     v
  Picks next system    Section-by-section     Validates 8
  from systems-index   GDD authoring          required sections
                       (incremental writes)   APPROVED/NEEDS REVISION
       |
       |  (repeat for each MVP system)
       v
/review-all-gdds
       |
       v
  Cross-GDD consistency + design theory review
  PASS / CONCERNS / FAIL
```

### 步骤 2.1:撰写系统 GDD

按依赖顺序用引导流程设计每个系统:

```
/map-systems next
```

这会挑出优先级最高的未设计系统,并交接给 `/design-system`,由它引导你逐节创建其 GDD。

也可以直接设计某个特定系统:

```
/design-system combat-system
```

**/design-system 会做什么:**

1. 读取你的游戏概念、系统索引,以及上下游的 GDD
2. 运行技术可行性预检(领域映射 + 可行性简报)
3. 带你逐节走完 8 个必需的 GDD 章节
4. 每节遵循:背景 > 提问 > 选项 > 决策 > 草稿 > 批准 > 写入
5. 每节获批后立即写入文件(崩溃也不丢)
6. 标记与既有获批 GDD 的冲突
7. 按类别路由到专家代理(数学找 systems-designer,经济找 economy-designer,故事系统找 narrative-director)

**8 个必需的 GDD 章节:**

| # | 章节 | 这里写什么 |
|---|---------|---------------|
| 1 | **概述(Overview)** | 系统的一段话总结 |
| 2 | **玩家幻想(Player Fantasy)** | 玩家使用此系统时想象/感受到什么 |
| 3 | **详细规则(Detailed Rules)** | 无歧义的机制规则 |
| 4 | **公式(Formulas)** | 所有计算,含变量定义与取值范围 |
| 5 | **边缘情况(Edge Cases)** | 怪异情况下会发生什么?明确给出答案。 |
| 6 | **依赖(Dependencies)** | 本系统与哪些系统相连(双向) |
| 7 | **调参旋钮(Tuning Knobs)** | 设计师可以安全调整哪些值,附安全范围 |
| 8 | **验收标准(Acceptance Criteria)** | 如何测试它确实有效?具体、可度量。 |

另加**游戏手感**章节:手感参照、输入响应(毫秒/帧数)、动画手感目标(启动/活跃/恢复)、打击时刻、重量感曲线。

### 步骤 2.2:评审每份 GDD

在开始下一个系统之前,先验证当前的:

```
/design-review design/gdd/combat-system.md
```

检查全部 8 个章节的完整性、公式清晰度、边缘情况处理、双向依赖与可测试的验收标准。

**结论:** APPROVED / NEEDS REVISION / MAJOR REVISION。只有 APPROVED 的 GDD 才应继续推进。

### 步骤 2.3:不走完整 GDD 的小变更

对于不值得写完整 GDD 的调参、小增补或微调:

```
/quick-design "add 10% damage bonus for flanking attacks"
```

这会在 `design/quick-specs/` 中创建轻量级规格,而不是完整的 8 章节 GDD。适用于调参、数值修改和小增补。

### 步骤 2.4:跨 GDD 一致性评审

当所有 MVP 系统的 GDD 都单独获批后:

```
/review-all-gdds
```

它会同时读取所有 GDD,并运行两个分析阶段:

**第 1 阶段——跨 GDD 一致性:**
- 依赖双向性(A 引用了 B,B 是否引用 A?)
- 系统之间的规则矛盾
- 对已改名或已移除系统的过时引用
- 职责冲突(两个系统声称同一职责)
- 公式范围兼容性(系统 A 的输出是否适配系统 B 的输入?)
- 验收标准交叉检查

**第 2 阶段——设计理论(游戏设计整体性):**
- 相互竞争的进度循环(两个系统是否争夺同一奖励空间?)
- 认知负荷(同时活跃的系统是否超过 4 个?)
- 支配性策略(是否存在让其他策略全部失效的最优解?)
- 经济循环分析(产出与消耗是否平衡?)
- 跨系统的难度曲线一致性
- 支柱对齐与反支柱违例
- 玩家幻想连贯性

**输出:** `design/gdd/gdd-cross-review-[date].md`,附结论。

### 步骤 2.5:叙事设计(如适用)

如果你的游戏有故事、设定或对话,就在这一阶段构建:

1. **世界观构建** —— 用 `world-builder` 定义世界的派系、历史、地理和规则
2. **故事结构** —— 用 `narrative-director` 设计故事弧线、角色弧线和叙事节拍
3. **角色卡** —— 使用 `narrative-character-sheet.md` 模板

### 第 2 阶段门

```
/gate-check systems-design
```

**通过要求:**

- `systems-index.md` 中所有 MVP 系统状态为 `Status: Approved`
- 每个 MVP 系统都有已评审的 GDD
- 存在跨 GDD 评审报告(`design/gdd/gdd-cross-review-*.md`),且结论为 PASS 或 CONCERNS(不是 FAIL)

---

## 第 3 阶段:技术准备

### 本阶段做什么

你做出关键技术决策,将其记录为架构决策记录(ADR),通过评审验证它们,并产出一份控制清单,为程序员提供扁平、可执行的规则。你还将奠定 UX 基础。

### 第 3 阶段流水线

```
/create-architecture  -->  /architecture-decision (x N)  -->  /architecture-review
        |                          |                                   |
        v                          v                                   v
  Master architecture       Per-decision ADRs              Validates completeness,
  document covering         in docs/architecture/          dependency ordering,
  all systems               adr-*.md                       engine compatibility
                                                                      |
                                                                      v
                                                         /create-control-manifest
                                                                      |
                                                                      v
                                                         Flat programmer rules
                                                         docs/architecture/
                                                         control-manifest.md
        Also in this phase:
        -------------------
        /ux-design  -->  /ux-review
        Accessibility requirements doc
        Interaction pattern library
```

### 步骤 3.1:主架构文档

```
/create-architecture
```

在 `docs/architecture/architecture.md` 创建总体架构文档,涵盖系统边界、数据流和集成点。

### 步骤 3.2:架构决策记录(ADR)

对每个重大技术决策:

```
/architecture-decision "State Machine vs Behavior Tree for NPC AI"
```

**会发生什么:** 技能引导你创建一份 ADR,包含:
- 背景与决策驱动因素
- 所有选项及其利弊与引擎兼容性
- 所选方案及理由
- 后果(正面、负面、风险)
- 依赖(Depends On、Enables、Blocks、Ordering Note)
- 覆盖的 GDD 需求(通过 TR-ID 关联)

ADR 有生命周期:Proposed > Accepted > Superseded/Deprecated。

**阶段门检查前至少需要 3 份基础层 ADR。**

**改造既有 ADR:** 如果你的既有项目(brownfield)已经有 ADR:

```
/architecture-decision retrofit docs/architecture/adr-005.md
```

这会检测缺少哪些模板章节,只补这些章节,绝不覆盖已有内容。

### 步骤 3.3:架构评审

```
/architecture-review
```

将所有 ADR 一起验证:
- ADR 依赖的拓扑排序(检测循环)
- 引擎兼容性验证
- GDD 修订标记(根据 ADR 选择,标记需要更新的 GDD 章节)
- TR-ID 注册表维护(`docs/architecture/tr-registry.yaml`)

### 步骤 3.4:控制清单

```
/create-control-manifest
```

汇总所有 Accepted 状态的 ADR,产出扁平的程序员规则清单:

```
docs/architecture/control-manifest.md
```

其中包含按代码层组织的必需模式、禁用模式和护栏。之后创建的故事会内嵌清单版本日期,以便检测过期。

### 步骤 3.5:无障碍需求

使用模板创建 `design/accessibility-requirements.md`。承诺一个等级(Basic / Standard / Comprehensive / Exemplary),并填写 4 轴特性矩阵(视觉、运动、认知、听觉)。

本文档在第 3 阶段就是必需的,因为 UX 规格(第 4 阶段撰写)会引用该等级——它是设计前置条件,而不是 UX 交付物。

### 第 3 阶段门

```
/gate-check technical-setup
```

**通过要求:**

- `docs/architecture/architecture.md` 存在
- 至少 3 份 ADR 存在且为 Accepted
- 存在架构评审报告
- `docs/architecture/control-manifest.md` 存在
- `design/accessibility-requirements.md` 存在

---

## 第 4 阶段:预制作

### 本阶段做什么

你为关键屏幕创建 UX 规格,为高风险的机制做原型,把设计文档转化为可实现的故事,规划第一个 Sprint,并构建一个证明核心循环好玩的垂直切片。

### 第 4 阶段流水线

```
/ux-design  -->  /vertical-slice  -->  /create-epics  -->  /create-stories  -->  /sprint-plan
    |                   |                   |                   |                       |
    v                   v                   v                   v                       v
  UX specs       Production-quality   Epic files in       Story files in          First sprint with
  design/ux/     end-to-end build     production/         production/             prioritized stories
                 in prototypes/       epics/*/EPIC.md     epics/*/story-*.md      production/sprints/
                 PROCEED/PIVOT/KILL   (one per module)    (one per behaviour)     sprint-*.md
    |                                                          |
    v                                                          v
 /ux-review                                             /story-readiness
 (validates specs                                       (validates each story
  before epics)                                          before pickup)
                                                               |
                                                               v
                                                           /dev-story
                                                         (implements the story,
                                                          routes to right agent)
```

### 步骤 4.1:关键屏幕的 UX 规格

在写 Epic 之前,先创建 UX 规格,让故事作者知道有哪些屏幕、必须支持哪些玩家交互。

**UX 规格:**

```
/ux-design main-menu
/ux-design core-gameplay-hud
```

三种模式:屏幕/流程、HUD 和交互模式。输出到 `design/ux/`。每份规格包含:玩家需求、布局分区、状态、交互映射、数据需求、触发的事件、无障碍、本地化。

它会读取你的 `accessibility-requirements.md`(第 3 阶段撰写)和 `technical-preferences.md` 中的输入方式配置,来驱动无障碍和输入覆盖检查——无需逐屏幕重新指定。

> **提示:** `/design-system` 会为每个有 UI 需求的系统发出 📌 UX 标记。把这些标记当作清单,对照哪些屏幕需要规格。

**交互模式库:**

```
/ux-design interaction-patterns
```

创建 `design/ux/interaction-patterns.md`——16 种标准控件加上游戏特定模式(物品栏格子、技能图标、HUD 条、对话框等),附动画与音效标准。

**UX 评审:**

```
/ux-review all
```

校验 UX 规格的 GDD 对齐度与无障碍等级合规性。给出 APPROVED / NEEDS REVISION / MAJOR REVISION NEEDED 结论。

### 步骤 4.2:构建垂直切片

垂直切片是生产质量的证据,证明在投入完整制作之前,你能端到端构建完整的游戏循环。

```
/vertical-slice
```

**它证明什么:** 一个从零开始的玩家,能否在没有开发者引导的情况下,几分钟内体验到核心幻想?

**它构建什么:** 一个接近生产质量的可玩构建,覆盖至少一个完整的[开始 → 挑战 → 解决]循环。使用真实的架构分层、真实的命名约定、不写死数值——但不要求最终的美术和音频。它不像概念原型那样是一次性的;它证明的是生产管线的可行性。

**关于概念原型:** 如果你在第 1 阶段(概念)运行过 `/prototype`,说明你已经验证了核心想法好玩。垂直切片现在验证的是你能正确地把它构建出来。两者回答的问题不同。如果你跳过了概念原型,在投入完整切片之前,先补一个是合理的。

**结论:** 垂直切片会给出 PROCEED / PIVOT / KILL 结论。
- **PROCEED** → 进入步骤 4.3(Epic 与故事)
- **PIVOT** → 用 `/design-system [mechanic]` 修订受影响的 GDD,然后重跑 `/vertical-slice`
- **KILL** → 带着学到的东西回到 `/brainstorm`

### 步骤 4.3:从设计产物创建 Epic 与故事

```
/create-epics layer: foundation
/create-stories [epic-slug]   # repeat for each epic
/create-epics layer: core
/create-stories [epic-slug]   # repeat for each core epic
```

`/create-epics` 读取你的 GDD、ADR 和架构来定义 Epic 范围——每个架构模块一个 Epic。然后 `/create-stories` 把每个 Epic 拆成 `production/epics/[slug]/` 中可实现的故事文件。每个故事内嵌:
- GDD 需求引用(TR-ID,而不是引用原文——不会过时)
- ADR 引用(只引用 Accepted 状态的 ADR;Proposed 状态的 ADR 会导致 `Status: Blocked`)
- 控制清单版本日期(用于过期检测)
- 引擎特定的实现说明
- 来自 GDD 的验收标准

故事创建好之后,运行 `/dev-story [story-path]` 实现其中一个——它会自动路由到正确的程序员代理。

### 步骤 4.4:领取前验证故事

```
/story-readiness production/epics/combat/story-combat-damage-calc.md
```

检查:设计完整性、架构覆盖、范围清晰度、完成定义。结论:READY / NEEDS WORK / BLOCKED。

### 步骤 4.5:工作量估算

```
/estimate production/epics/combat/story-combat-damage-calc.md
```

给出带风险评估的工作量估算。

### 步骤 4.6:规划第一个 Sprint

```
/sprint-plan new
```

**会发生什么:** `producer` 代理协作进行 Sprint 规划:
- 询问 Sprint 目标与可用时间
- 把目标拆成 Must Have / Should Have / Nice to Have 任务
- 识别风险与阻塞
- 创建 `production/sprints/sprint-01.md`
- 填充 `production/sprint-status.yaml`(机器可读的故事追踪)

### 步骤 4.7:垂直切片(硬门)

在进入制作阶段之前,你必须构建并试玩测试一个垂直切片:

- 一个完整的端到端核心循环,可从开头玩到结尾
- 有代表性的质量(不是满屏占位符)
- 至少 3 次无引导试玩会话
- 撰写试玩测试报告(`/playtest-report`)

这是一道**硬门**——如果没有真人无引导地玩过这个构建,`/gate-check` 会自动判 FAIL。

### 第 4 阶段门

```
/gate-check pre-production
```

**通过要求:**

- `design/ux/` 中至少有 1 份已评审的 UX 规格
- UX 评审已完成(APPROVED,或 NEEDS REVISION 但风险已记录)
- 至少 1 个带 README 的原型
- `production/epics/[epic-slug]/` 中存在故事文件
- 至少 1 份 Sprint 计划
- 至少 1 份试玩测试报告(垂直切片经过 3 次以上会话试玩)

---

## 第 5 阶段:制作

### 本阶段做什么

这是核心生产循环。你以 Sprint(通常 1-2 周)为单位工作,逐个故事实现功能、跟踪进度,并通过结构化的完成评审关闭故事。这一阶段反复进行,直到游戏内容完整。

### 第 5 阶段流水线(每个 Sprint)

```
/sprint-plan new  -->  /story-readiness  -->  implement  -->  /story-done
       |                     |                    |                |
       v                     v                    v                v
  Sprint created       Story validated      Code written     8-phase review:
  sprint-status.yaml   READY verdict        Tests pass       verify criteria,
  populated                                                  check deviations,
                                                             update story status
       |
       |  (repeat per story until sprint complete)
       v
  /sprint-status  (quick 30-line snapshot anytime)
  /scope-check    (if scope is growing)
  /retrospective  (at sprint end)
```

### 步骤 5.1:故事生命周期

制作阶段围绕**故事生命周期**展开:

```
/story-readiness  -->  implement  -->  /story-done  -->  next story
```

**1. 故事就绪:** 领取故事前先验证:

```
/story-readiness production/epics/combat/story-combat-damage-calc.md
```

这会检查设计完整性、架构覆盖、ADR 状态(ADR 仍为 Proposed 则阻塞)、控制清单版本(过期则警告)和范围清晰度。结论:READY / NEEDS WORK / BLOCKED。

**2. 实现:** 与合适的代理协作:

- `gameplay-programmer` 负责玩法系统
- `engine-programmer` 负责核心引擎工作
- `ai-programmer` 负责 AI 行为
- `network-programmer` 负责多人联机
- `ui-programmer` 负责 UI 代码
- `tools-programmer` 负责开发工具

所有代理都遵循协作协议:先读设计文档,提出澄清问题,给出架构选项,获得你的批准,然后才实现。

**3. 故事完成:** 故事完成时:

```
/story-done production/epics/combat/story-combat-damage-calc.md
```

这会运行 8 阶段完成评审:
1. 找到并读取故事文件
2. 加载引用的 GDD、ADR 和控制清单
3. 验证验收标准(可自动检查的、手动的、延期的)
4. 检查 GDD/ADR 偏差(BLOCKING / ADVISORY / OUT OF SCOPE)
5. 提示进行代码评审
6. 生成完成报告(COMPLETE / COMPLETE WITH NOTES / BLOCKED)
7. 更新故事 `Status: Complete` 并附完成说明
8. 给出下一个就绪的故事

评审中发现的技术债会记录到 `docs/tech-debt-register.md`。

### 步骤 5.2:Sprint 跟踪

随时查看进度:

```
/sprint-status
```

从 `production/sprint-status.yaml` 读取的 30 行快速快照。

如果范围在膨胀:

```
/scope-check production/sprints/sprint-03.md
```

它把当前范围与原计划对比,标记范围扩大并建议砍项。

### 步骤 5.3:内容跟踪

```
/content-audit
```

对比 GDD 规定的内容与已实现的内容。尽早发现内容缺口。

### 步骤 5.4:设计变更传播

当故事创建之后 GDD 发生变更时:

```
/propagate-design-change design/gdd/combat-system.md
```

对 GDD 做 Git diff,找出受影响的 ADR,生成影响报告,并引导你逐项决定 Superseded/更新/保留。

### 步骤 5.5:跨系统功能(团队编排)

对横跨多个领域的功能,使用团队技能:

```
/team-combat "healing ability with HoT and cleanse"
/team-narrative "Act 2 story content"
/team-ui "inventory screen redesign"
/team-level "forest dungeon level"
/team-audio "combat audio pass"
```

每个团队技能协调一个 6 阶段协作工作流:
1. **设计** —— game-designer 提问、给出选项
2. **架构** —— lead-programmer 提出代码结构
3. **并行实现** —— 各专家同时工作
4. **集成** —— gameplay-programmer 把一切接线整合
5. **验证** —— qa-tester 对照验收标准运行
6. **报告** —— 协调者总结状态

编排是自动化的,但**决策点始终在你手中**。

### 步骤 5.6:Sprint 评审与下一个 Sprint

Sprint 结束时:

```
/retrospective
```

分析计划与完成的差距、速度、阻塞和可执行的改进。

然后规划下一个 Sprint:

```
/sprint-plan new
```

### 步骤 5.7:里程碑评审

在里程碑检查点:

```
/milestone-review "alpha"
```

产出功能完整度、质量指标、风险评估和 go/no-go 建议。

### 第 5 阶段门

```
/gate-check production
```

**通过要求:**

- 所有 MVP 故事完成
- 试玩测试:3 次会话,覆盖新玩家、游戏中期和难度曲线
- 乐趣假设得到验证
- 试玩数据中不存在困惑循环

---

## 第 6 阶段:打磨

### 本阶段做什么

你的游戏功能已完整。现在要把它做好。本阶段聚焦性能、平衡、无障碍、音频、视觉打磨和试玩测试。

### 第 6 阶段流水线

```
/perf-profile  -->  /balance-check  -->  /asset-audit  -->  /playtest-report (x3)
       |                  |                    |                    |
       v                  v                    v                    v
  Profile CPU/GPU    Analyze formulas     Verify naming,      Cover: new player,
  memory, optimize   and data for         formats, sizes      mid-game, difficulty
  bottlenecks        broken progressions                      curve

  /tech-debt  -->  /team-polish
       |                |
       v                v
  Track and        Coordinated pass:
  prioritize       performance + art +
  debt items       audio + UX + QA
```

### 步骤 6.1:性能分析

```
/perf-profile
```

引导你完成结构化的性能分析:
- 确立目标(FPS、内存、平台)
- 按影响排序识别瓶颈
- 生成可执行的优化任务,附代码位置与预期收益

### 步骤 6.2:平衡分析

```
/balance-check assets/data/combat_damage.json
```

分析平衡数据中的统计异常值、断裂的进度曲线、破坏性策略(degenerate strategies)和经济失衡。

### 步骤 6.3:资产审计

```
/asset-audit
```

验证所有资产的命名约定、文件格式标准和大小预算。

### 步骤 6.4:试玩测试(必需:3 次会话)

```
/playtest-report
```

生成结构化的试玩测试报告。需要 3 次会话,分别覆盖:
- 新玩家体验
- 游戏中期系统
- 难度曲线

### 步骤 6.5:技术债评估

```
/tech-debt
```

扫描 TODO/FIXME/HACK 注释、代码重复、过于复杂的函数、缺失的测试和过时的依赖。每一项都会分类并排定优先级。

### 步骤 6.6:协作打磨

```
/team-polish "combat system"
```

并行协调 4 位专家:
1. 性能优化(performance-analyst)
2. 视觉打磨(technical-artist)
3. 音频打磨(sound-designer)
4. 手感/打击反馈(gameplay-programmer + technical-artist)

你定优先级;团队执行,每一步都经你批准。

### 步骤 6.7:本地化与无障碍

```
/localize src/
```

扫描硬编码字符串、破坏翻译的字符串拼接、未考虑文本膨胀的文案和缺失的语言文件。

无障碍对照第 3 阶段无障碍需求文档中承诺的等级进行审计。

### 第 6 阶段门

```
/gate-check polish
```

**通过要求:**

- 至少 3 份试玩测试报告
- 协作打磨已完成(`/team-polish`)
- 没有阻塞性性能问题
- 满足无障碍等级要求

---

## 第 7 阶段:发布

### 本阶段做什么

你的游戏已打磨完毕、测试通过、准备就绪。现在把它发布出去。

### 第 7 阶段流水线

```
/release-checklist  -->  /launch-checklist  -->  /team-release
        |                       |                      |
        v                       v                      v
  Pre-release             Full cross-department    Coordinate:
  validation across       validation (Go/No-Go     build, QA sign-off,
  code, content,          per department)           deployment, launch
  store, legal
                    Also: /changelog, /patch-notes, /hotfix
```

### 步骤 7.1:发布检查清单

```
/release-checklist v1.0.0
```

生成全面的发布前检查清单,涵盖:
- 构建验证(所有平台可编译可运行)
- 认证要求(平台特定)
- 商店元数据(描述、截图、预告片)
- 法律合规(EULA、隐私政策、分级)
- 存档兼容性
- 数据分析验证

### 步骤 7.2:上线就绪(完整验证)

```
/launch-checklist
```

跨部门完整验证:

| 部门 | 检查内容 |
|-----------|---------------|
| **工程** | 构建稳定性、崩溃率、内存泄漏、加载时间 |
| **设计** | 功能完整度、教学流程、难度曲线 |
| **美术** | 资产质量、缺失贴图、LOD 层级 |
| **音频** | 缺失音效、混音电平、空间音频 |
| **QA** | 按严重度统计的未关闭 bug 数、回归套件通过率 |
| **叙事** | 对话完整度、设定一致性、错别字 |
| **本地化** | 所有字符串已翻译、无截断、语言环境测试 |
| **无障碍** | 合规清单、辅助功能测试 |
| **商店** | 元数据完整、截图获批、定价已设定 |
| **市场** | 新闻资料包就绪、上线预告片、社交媒体排期 |
| **社区** | 补丁说明草稿、FAQ 已准备、支持渠道就绪 |
| **基础设施** | 服务器扩容、CDN 配置、监控启用 |
| **法务** | EULA 定稿、隐私政策、COPPA/GDPR 合规 |

每一项都有 **Go / No-Go** 状态。全部 Go 才能发布。

### 步骤 7.3:生成面向玩家的内容

```
/patch-notes v1.0.0
```

从 Git 历史和 Sprint 数据生成玩家友好的补丁说明。把开发者语言翻译成玩家语言。

```
/changelog v1.0.0
```

生成内部更新日志(更技术化,面向团队)。

### 步骤 7.4:协调发布

```
/team-release
```

协调 release-manager、QA 和 DevOps 完成:
1. 发布前验证
2. 构建管理
3. 最终 QA 签字
4. 部署准备
5. Go/No-Go 决策

### 步骤 7.5:发布

推送到 `main` 或 `develop` 时,`validate-push` 钩子会警告你。这是有意为之——发布推送应当经过深思熟虑:

```bash
git tag v1.0.0
git push origin main --tags
```

### 步骤 7.6:上线后

**热修复工作流**,用于线上严重 bug:

```
/hotfix "Players losing save data when inventory exceeds 99 items"
```

绕过正常 Sprint 流程,但保留完整审计追踪:
1. 创建热修复分支
2. 实现修复
3. 确保回移到开发分支
4. 记录事件

上线稳定后做**复盘**:

```
Ask Claude to create a post-mortem using the template at
.claude/docs/templates/post-mortem.md
```

---

## 横切关注点

以下主题贯穿所有阶段。

### 总监评审模式

总监门是在关键工作流节点评审你工作的专家代理。默认情况下,它们在每个检查点运行。你可以控制评审强度。

**在 `/start` 中设置一次评审强度。** 保存到 `production/review-mode.txt`。

| 模式 | 运行内容 | 适合 |
|------|-----------|----------|
| `full` | 每一步都运行所有总监门 | 新项目、学习本系统 |
| `lean` | 仅在阶段转换(`/gate-check`)时运行总监评审 | 有经验的开发者 |
| `solo` | 不做总监评审 | Game Jam、原型、极限速度 |

**单次覆盖**,不改变全局设置:

```
/brainstorm space horror --review full
/architecture-decision --review solo
```

`--review` 标志适用于所有使用门机制的技能。随时可以编辑 `production/review-mode.txt` 或重跑 `/start` 来修改全局模式。

完整的门定义与检查模式:`.claude/docs/director-gates.md`

---

### 协作协议

本系统是**用户驱动的协作**,而非自主生成。

**模式:** 提问 > 选项 > 决策 > 草稿 > 批准

每次代理交互都遵循这个模式:
1. 代理提出澄清问题
2. 代理给出 2-4 个选项,附权衡与理由
3. 你做决定
4. 代理根据你的决定起草
5. 你审阅并改进
6. 代理在写入前问「我可以把它写入 [filepath] 吗?」

完整协议与示例见 `docs/COLLABORATIVE-DESIGN-PRINCIPLE.md`。

### AskUserQuestion 工具

代理用 `AskUserQuestion` 工具做结构化的选项呈现。模式是「先解释,后捕获」:先在对话正文中给出完整分析,再用干净的 UI 选择器捕获决策。适用于设计选择、架构决策和战略问题。不适用于开放式探索问题或简单的是/否确认。

### 代理协作(3 层层级)

```
Tier 1 (Directors):    creative-director, technical-director, producer
                                          |
Tier 2 (Leads):        game-designer, lead-programmer, art-director,
                       audio-director, narrative-director, qa-lead,
                       release-manager, localization-lead
                                          |
Tier 3 (Specialists):  gameplay-programmer, engine-programmer,
                       ai-programmer, network-programmer, ui-programmer,
                       tools-programmer, systems-designer, level-designer,
                       economy-designer, world-builder, writer,
                       technical-artist, sound-designer, ux-designer,
                       qa-tester, performance-analyst, devops-engineer,
                       analytics-engineer, accessibility-specialist,
                       live-ops-designer, prototyper, security-engineer,
                       community-manager, godot-specialist,
                       godot-gdscript-specialist, godot-shader-specialist,
                       godot-csharp-specialist, godot-gdextension-specialist,
                       unity-specialist, unity-dots-specialist,
                       unity-shader-specialist, unity-addressables-specialist,
                       unity-ui-specialist, unreal-specialist,
                       ue-blueprint-specialist, ue-gas-specialist,
                       ue-replication-specialist, ue-umg-specialist
```

**协作规则:**
- 垂直委派:总监 > 主管 > 专家。复杂决策不得跨层跳过。
- 横向协商:同层代理可以互相咨询,但不得在自己的领域之外做有约束力的决定。
- 冲突解决:设计冲突找 `creative-director`。技术冲突找 `technical-director`。范围冲突找 `producer`。
- 不做单方面的跨领域变更。

### 自动化钩子(安全网)

系统有 12 个自动运行的钩子:

| 钩子 | 触发时机 | 作用 |
|------|---------|-------------|
| `session-start.sh` | 会话开始 | 显示分支、最近提交,检测 active.md 以便恢复 |
| `detect-gaps.sh` | 会话开始 | 检测全新项目(无引擎、无概念)并建议 `/start` |
| `pre-compact.sh` | 压缩前 | 把会话状态导出到对话中,以便自动恢复 |
| `post-compact.sh` | 压缩后 | 提醒 Claude 从 `active.md` 恢复会话状态 |
| `notify.sh` | 通知事件 | 通过 PowerShell 显示 Windows Toast 通知 |
| `validate-commit.sh` | 提交前 | 检查设计文档引用、JSON 有效性、无硬编码数值 |
| `validate-push.sh` | 推送前 | 推送到 main/develop 时发出警告 |
| `validate-assets.sh` | 提交前 | 检查资产命名与大小 |
| `validate-skill-change.sh` | 技能文件写入时 | `.claude/skills/` 变更后建议运行 `/skill-test` |
| `log-agent.sh` | 代理启动 | 记录代理调用,形成审计追踪 |
| `log-agent-stop.sh` | 代理停止 | 补全代理审计追踪(启动 + 停止) |
| `session-stop.sh` | 会话结束 | 最终的会话日志 |

### 上下文韧性

**会话状态文件:** `production/session-state/active.md` 是一个持续更新的检查点。每达成一个重要里程碑后就更新它。任何中断(压缩、崩溃、`/clear`)之后,先读这个文件。

**增量写入:** 创建多章节文档时,每节获批后立即写入文件。这样已完成的章节能在崩溃和上下文压缩中幸存。已写入章节的先前讨论可以被安全压缩。

**自动恢复:** `session-start.sh` 钩子会自动检测并预览 `active.md`。`pre-compact.sh` 钩子在压缩前把状态导出到对话中。

**Sprint 状态跟踪:** `production/sprint-status.yaml` 是机器可读的故事追踪器。由 `/sprint-plan`(初始化)和 `/story-done`(状态更新)写入。由 `/sprint-status`、`/help` 和 `/story-done`(下一个故事)读取。消除了脆弱的 Markdown 扫描。

### 既有项目(brownfield)接入

对已有部分产物的既有项目:

```
/adopt
```

或针对性执行:

```
/adopt gdds
/adopt adrs
/adopt stories
/adopt infra
```

它审计既有产物的**格式**(而非存在性),把缺口分类为 BLOCKING/HIGH/MEDIUM/LOW,构建有序迁移计划,并写出 `docs/adoption-plan-[date].md`。核心原则:迁移而非替换——它绝不重新生成已有成果,只填补缺口。

单个技能也支持改造(retrofit)模式:

```
/design-system retrofit design/gdd/combat-system.md
/architecture-decision retrofit docs/architecture/adr-005.md
```

它们会检测哪些章节存在、哪些缺失,只补缺的部分。

### 阶段门系统

阶段门是正式的检查点。运行 `/gate-check` 并带上转换名称:

```
/gate-check concept              # Concept -> Systems Design
/gate-check systems-design       # Systems Design -> Technical Setup
/gate-check technical-setup      # Technical Setup -> Pre-Production
/gate-check pre-production       # Pre-Production -> Production
/gate-check production           # Production -> Polish
/gate-check polish               # Polish -> Release
```

**结论:**
- **PASS** —— 所有要求满足,进入下一阶段
- **CONCERNS** —— 要求满足但有已确认的风险,可通过
- **FAIL** —— 要求未满足,阻止推进,并给出具体的整改项

门通过时,`production/stage.txt` 才会更新(仅此时机),它控制状态栏和 `/help` 的行为。

### 逆向文档

对只有代码而没有设计文档的情况(既有项目接入后很常见):

```
/reverse-document src/gameplay/combat/
```

读取既有代码,从中生成 GDD 格式的设计文档。

---

## 附录 A:代理速查

### 「我要做 X——该用哪个代理?」

| 我需要…… | 代理 | 层级 |
|-------------|-------|------|
| 想出一个游戏点子 | `/brainstorm` 技能 | -- |
| 设计游戏机制 | `game-designer` | 2 |
| 设计具体公式/数值 | `systems-designer` | 3 |
| 设计游戏关卡 | `level-designer` | 3 |
| 设计掉落表/经济 | `economy-designer` | 3 |
| 构建世界观设定 | `world-builder` | 3 |
| 撰写对话 | `writer` | 3 |
| 规划故事 | `narrative-director` | 2 |
| 规划 Sprint | `producer` | 1 |
| 做创意决策 | `creative-director` | 1 |
| 做技术决策 | `technical-director` | 1 |
| 实现玩法代码 | `gameplay-programmer` | 3 |
| 实现核心引擎系统 | `engine-programmer` | 3 |
| 实现 AI 行为 | `ai-programmer` | 3 |
| 实现多人联机 | `network-programmer` | 3 |
| 实现 UI | `ui-programmer` | 3 |
| 构建开发工具 | `tools-programmer` | 3 |
| 评审代码架构 | `lead-programmer` | 2 |
| 创建 shader / VFX | `technical-artist` | 3 |
| 定义视觉风格 | `art-director` | 2 |
| 定义音频风格 | `audio-director` | 2 |
| 设计音效 | `sound-designer` | 3 |
| 设计 UX 流程 | `ux-designer` | 3 |
| 编写测试用例 | `qa-tester` | 3 |
| 规划测试策略 | `qa-lead` | 2 |
| 性能分析 | `performance-analyst` | 3 |
| 搭建 CI/CD | `devops-engineer` | 3 |
| 设计数据分析 | `analytics-engineer` | 3 |
| 检查无障碍 | `accessibility-specialist` | 3 |
| 规划在线运营 | `live-ops-designer` | 3 |
| 管理发布 | `release-manager` | 2 |
| 管理本地化 | `localization-lead` | 2 |
| 快速做原型 | `prototyper` | 3 |
| 安全审计 | `security-engineer` | 3 |
| 与玩家沟通 | `community-manager` | 3 |
| Godot 相关帮助 | `godot-specialist` | 3 |
| GDScript 相关帮助 | `godot-gdscript-specialist` | 3 |
| Godot shader 帮助 | `godot-shader-specialist` | 3 |
| GDExtension 模块 | `godot-gdextension-specialist` | 3 |
| Unity 相关帮助 | `unity-specialist` | 3 |
| Unity DOTS/ECS | `unity-dots-specialist` | 3 |
| Unity shader/VFX | `unity-shader-specialist` | 3 |
| Unity Addressables | `unity-addressables-specialist` | 3 |
| Unity UI Toolkit | `unity-ui-specialist` | 3 |
| Unreal 相关帮助 | `unreal-specialist` | 3 |
| Unreal GAS | `ue-gas-specialist` | 3 |
| Unreal 蓝图 | `ue-blueprint-specialist` | 3 |
| Unreal 复制(replication) | `ue-replication-specialist` | 3 |
| Unreal UMG/CommonUI | `ue-umg-specialist` | 3 |

### 代理层级

```
                    creative-director / technical-director / producer
                                         |
          ---------------------------------------------------------------
          |            |           |           |          |        |       |
    game-designer  lead-prog  art-dir  audio-dir  narr-dir  qa-lead  release-mgr
          |            |           |           |          |        |        |
     specialists  programmers  tech-art  snd-design  writer   qa-tester  devops
     (systems,    (gameplay,             (sound)     (world-  (perf,     (analytics,
      economy,     engine,                           builder)  access.)   security)
      level)       ai, net,
                   ui, tools)
```

**升级规则:** 如果两个代理意见不合,向上升级。设计冲突找 `creative-director`。技术冲突找 `technical-director`。范围冲突找 `producer`。

---

## 附录 B:斜杠命令速查

### 全部 73 个命令,按类别分组

#### 上手指引与导航(6)

| 命令 | 用途 | 阶段 |
|---------|---------|-------|
| `/start` | 引导式上手指引,路由到正确工作流 | 任意(首次会话) |
| `/help` | 上下文感知的「下一步该做什么?」 | 任意 |
| `/project-stage-detect` | 完整项目审计,确定当前阶段 | 任意 |
| `/setup-engine` | 配置引擎、锁定版本、设置偏好 | 1 |
| `/adopt` | 既有项目审计与迁移计划 | 任意(既有项目) |
| `/skill-improve` | 通过测试-修复-重测循环改进技能 | 任意 |

#### 游戏设计(6)

| 命令 | 用途 | 阶段 |
|---------|---------|-------|
| `/brainstorm` | 带 MDA 分析的协作式创意构思 | 1 |
| `/map-systems` | 把概念分解为系统索引 | 1-2 |
| `/design-system` | 引导式逐节撰写 GDD | 2 |
| `/quick-design` | 小变更的轻量级规格 | 2+ |
| `/review-all-gdds` | 跨 GDD 一致性与设计理论评审 | 2 |
| `/propagate-design-change` | 找出受 GDD 变更影响的 ADR/故事 | 5 |

#### UX 与界面(2)

| 命令 | 用途 | 阶段 |
|---------|---------|-------|
| `/ux-design` | 撰写 UX 规格(屏幕/流程、HUD、模式) | 4 |
| `/ux-review` | 校验 UX 规格的无障碍与 GDD 对齐 | 4 |

#### 架构(4)

| 命令 | 用途 | 阶段 |
|---------|---------|-------|
| `/create-architecture` | 主架构文档 | 3 |
| `/architecture-decision` | 创建或改造 ADR | 3 |
| `/architecture-review` | 验证所有 ADR 及依赖排序 | 3 |
| `/create-control-manifest` | 从 Accepted ADR 生成扁平程序员规则 | 3 |

#### 故事与 Sprint(8)

| 命令 | 用途 | 阶段 |
|---------|---------|-------|
| `/create-epics` | 把 GDD + ADR 转化为 Epic(每个模块一个) | 4 |
| `/create-stories` | 把单个 Epic 拆成故事文件 | 4 |
| `/dev-story` | 实现故事——路由到正确的程序员代理 | 5 |
| `/sprint-plan` | 创建或管理 Sprint 计划 | 4-5 |
| `/sprint-status` | 30 行 Sprint 快速快照 | 5 |
| `/story-readiness` | 验证故事是否可实现 | 4-5 |
| `/story-done` | 8 阶段故事完成评审 | 5 |
| `/estimate` | 带风险评估的工作量估算 | 4-5 |

#### 评审与分析(13)

| 命令 | 用途 | 阶段 |
|---------|---------|-------|
| `/design-review` | 对照 8 章节标准验证 GDD | 1-2 |
| `/code-review` | 架构级代码评审 | 5+ |
| `/balance-check` | 游戏平衡公式分析 | 5-6 |
| `/asset-audit` | 资产命名、格式、大小验证 | 6 |
| `/asset-spec` | 逐资产视觉规格与 AI 生成提示词 | 5-6 |
| `/content-audit` | GDD 规定内容 vs 已实现内容 | 5 |
| `/consistency-check` | 跨 GDD 实体与公式不一致扫描 | 2+ |
| `/scope-check` | 范围蔓延检测 | 5 |
| `/perf-profile` | 性能分析工作流 | 6 |
| `/tech-debt` | 技术债扫描与优先级排序 | 6 |
| `/gate-check` | 正式阶段门,PASS/CONCERNS/FAIL | 所有转换 |
| `/reverse-document` | 从既有代码生成设计文档 | 任意 |
| `/security-audit` | 安全漏洞审计(存档、网络、输入) | 6-7 |

#### QA 与测试(9)

| 命令 | 用途 | 阶段 |
|---------|---------|-------|
| `/qa-plan` | 为 Sprint 或功能生成 QA 测试计划 | 5 |
| `/smoke-check` | 移交 QA 前的关键路径冒烟测试门 | 5-6 |
| `/soak-test` | 长时间试玩会话的浸泡测试协议 | 6 |
| `/regression-suite` | 映射测试覆盖,识别缺少回归测试的已修复 bug | 5-6 |
| `/test-setup` | 搭建测试框架与 CI/CD 管线 | 4 |
| `/test-helpers` | 生成引擎特定的测试辅助库 | 4-5 |
| `/test-evidence-review` | 测试文件与手动证据的质量评审 | 5 |
| `/test-flakiness` | 从 CI 日志检测非确定性测试 | 5-6 |
| `/skill-test` | 校验技能文件的结构与行为正确性 | 任意 |

#### 生产管理(6)

| 命令 | 用途 | 阶段 |
|---------|---------|-------|
| `/milestone-review` | 里程碑进度与 go/no-go | 5 |
| `/retrospective` | Sprint 复盘分析 | 5 |
| `/bug-report` | 创建结构化 bug 报告 | 5+ |
| `/bug-triage` | 重新评估未关闭 bug 的优先级、严重度与负责人 | 5+ |
| `/playtest-report` | 结构化试玩会话报告 | 4-6 |
| `/onboard` | 新成员上手指引 | 任意 |

#### 发布(6)

| 命令 | 用途 | 阶段 |
|---------|---------|-------|
| `/release-checklist` | 发布前验证 | 7 |
| `/launch-checklist` | 跨部门完整上线就绪验证 | 7 |
| `/changelog` | 自动生成内部更新日志 | 7 |
| `/patch-notes` | 面向玩家的补丁说明 | 7 |
| `/hotfix` | 紧急修复工作流 | 7+ |
| `/day-one-patch` | 针对黄金母版后发现的问题的限定范围补丁 | 7+ |

#### 创意(4)

| 命令 | 用途 | 阶段 |
|---------|---------|-------|
| `/prototype` | 概念原型——在写 GDD 前验证核心想法 | 1 |
| `/art-bible` | 引导式美术圣经撰写——视觉识别规格 | 1-2 |
| `/vertical-slice` | 制作阶段前的生产质量端到端构建 | 4 |
| `/localize` | 字符串提取与校验 | 6-7 |

#### 团队编排(9)

| 命令 | 用途 | 阶段 |
|---------|---------|-------|
| `/team-combat` | 战斗功能:从设计到实现 | 5 |
| `/team-narrative` | 叙事内容:从结构到对话 | 5 |
| `/team-ui` | UI 功能:从 UX 规格到打磨后的实现 | 5 |
| `/team-level` | 关卡:从布局到完整布景的遭遇战 | 5 |
| `/team-audio` | 音频:从方向到已实现的事件 | 5-6 |
| `/team-polish` | 协作打磨:性能 + 美术 + 音频 + QA | 6 |
| `/team-release` | 发布协调:构建 + QA + 部署 | 7 |
| `/team-live-ops` | 在线运营规划:赛季活动、战斗通行证、留存 | 7+ |
| `/team-qa` | 完整 QA 周期:策略、执行、覆盖、签字 | 6-7 |

---

## 附录 C:常见工作流

### 工作流 1:「我刚开始,还没有游戏点子」

```
1. /start (routes you based on where you are)
2. /brainstorm (collaborative ideation, pick a concept)
3. /setup-engine (pin engine and version)
4. /design-review on concept doc (optional, recommended)
5. /map-systems (decompose concept into systems with deps and priorities)
6. /gate-check concept (verify you're ready for Systems Design)
7. /design-system per system (guided GDD authoring)
```

### 工作流 2:「我有设计稿,想开始写代码」

```
1. /design-review on each GDD (make sure they're solid)
2. /review-all-gdds (cross-GDD consistency)
3. /gate-check systems-design
4. /create-architecture + /architecture-decision (per major decision)
5. /architecture-review
6. /create-control-manifest
7. /gate-check technical-setup
8. /create-epics layer: foundation + /create-stories [slug] (define epics, break into stories)
9. /sprint-plan new
10. /story-readiness -> implement -> /story-done (story lifecycle)
```

### 工作流 3:「我需要在制作中期添加一个复杂功能」

```
1. /design-system or /quick-design (depending on scope)
2. /design-review to validate
3. /propagate-design-change if modifying existing GDDs
4. /estimate for effort and risk
5. /team-combat, /team-narrative, /team-ui, etc. (appropriate team skill)
6. /story-done when complete
7. /balance-check if it affects game balance
```

### 工作流 4:「线上出问题了」

```
1. /hotfix "description of the issue"
2. Fix is implemented on hotfix branch
3. /code-review the fix
4. Run tests
5. /release-checklist for hotfix build
6. Deploy and backport
```

### 工作流 5:「我有一个既有项目,想用上这套系统」

```
1. /start (choose Path D -- existing work)
2. /project-stage-detect (determines current phase)
3. /adopt (audits existing artifacts, builds migration plan)
4. /design-system retrofit [path] (fill GDD gaps)
5. /architecture-decision retrofit [path] (fill ADR gaps)
6. /gate-check at appropriate transition
```

### 工作流 6:「开始一个新的 Sprint」

```
1. /retrospective (review last sprint)
2. /sprint-plan new (create next sprint)
3. /scope-check (ensure scope is manageable)
4. /story-readiness per story before pickup
5. Implement stories
6. /story-done per completed story
7. /sprint-status for quick progress checks
```

### 工作流 7:「发布游戏」

```
1. /gate-check polish (verify Polish phase is complete)
2. /tech-debt (decide what's acceptable at launch)
3. /localize (final localization pass)
4. /release-checklist v1.0.0
5. /launch-checklist (full cross-department validation)
6. /team-release (coordinate the release)
7. /patch-notes and /changelog
8. Ship!
9. /hotfix if anything breaks post-launch
10. Post-mortem after launch stabilizes
```

### 工作流 8:「我迷路了/不知道下一步做什么」

```
1. /help (reads your phase, checks artifacts, tells you what's next)
2. If /help doesn't help: /project-stage-detect (full audit)
3. If stage seems wrong: /gate-check at the transition you think you're at
```

---

## 充分利用本系统的建议

1. **永远先设计,后实现。** 代理系统建立在「写代码前先要有设计文档」的假设之上。代理会不断引用 GDD。

2. **跨领域功能用团队技能。** 不要试图自己手动协调 4 个代理——让 `/team-combat`、`/team-narrative` 等来处理编排。

3. **信任规则系统。** 当规则标记了你代码中的问题时,修掉它。这些规则凝结了来之不易的游戏开发经验(数据驱动数值、delta time、无障碍等)。

4. **主动压缩。** 上下文用到约 65-70% 时,压缩或 `/clear`。pre-compact 钩子会保存你的进度。不要等到顶到上限。

5. **用对层级的代理。** 不要让 `creative-director` 写 shader。不要让 `qa-tester` 做设计决策。层级存在是有原因的。

6. **不确定时运行 /help。** 它读取你项目的真实状态,告诉你最重要的下一步。

7. **把设计交给程序员之前先运行 `/design-review`。** 它能及早发现不完整的规格,省掉返工。

8. **每个重大功能之后运行 `/code-review`。** 在架构问题扩散之前抓住它们。

9. **高风险机制先做原型。** 一天的原型制作能省下一周浪费在不可行机制上的制作时间。

10. **让 Sprint 计划保持诚实。** 定期用 `/scope-check`。范围蔓延是独立游戏的头号杀手。

11. **用 ADR 记录决策。** 未来的你会感谢现在的你记下了事情*为什么*是这样构建的。

12. **严格遵守故事生命周期。** 领取前 `/story-readiness`,完成后 `/story-done`。这能及早发现偏差,让流水线保持诚实。

13. **尽早、经常写入文件。** 增量分节写入意味着你的设计决策能在崩溃和压缩中幸存。文件才是记忆,对话不是。
