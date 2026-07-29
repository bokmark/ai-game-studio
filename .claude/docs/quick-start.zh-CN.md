> 中文翻译 | [English](quick-start.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# Game Studio Agent Architecture —— 快速上手指南

## 这是什么?

这是一套完整的用于游戏开发的 Claude Code 代理架构。它将 49 个专业化 AI 代理组织
成与真实游戏开发团队相对应的工作室层级,带有明确的职责、委派规则与协调协议。其
中包含 Godot、Unity 和 Unreal 的引擎专家代理 —— 每个都配有针对主要引擎子系统
的专职子专家。所有设计代理与模板都以成熟的游戏设计理论为基础(MDA 框架、自我决
定理论、心流状态、Bartle 玩家类型)。请使用与你项目匹配的引擎套组。

## 如何使用

### 1. 理解层级

代理分为三个层级:

- **Tier 1(Opus)**:做高层决策的总监
  - `creative-director` —— 愿景与创意冲突裁决
  - `technical-director` —— 架构与技术决策
  - `producer` —— 排期、协调与风险管理

- **Tier 2(Sonnet)**:各自领域负责人的部门主管
  - `game-designer`、`lead-programmer`、`art-director`、`audio-director`、
    `narrative-director`、`qa-lead`、`release-manager`、`localization-lead`

- **Tier 3(Sonnet/Haiku)**:在各自领域内执行的专家
  - 设计师、程序员、美术、编剧、测试、工程师

### 2. 为任务选对代理

问自己:"在真实工作室里,这件事归哪个部门管?"

| 我要…… | 使用这个代理 |
|--------|--------------|
| 设计一个新机制 | `game-designer` |
| 编写战斗代码 | `gameplay-programmer` |
| 创建着色器 | `technical-artist` |
| 撰写对白 | `writer` |
| 规划下一个 Sprint | `producer` |
| 评审代码质量 | `lead-programmer` |
| 编写测试用例 | `qa-tester` |
| 设计关卡 | `level-designer` |
| 修复性能问题 | `performance-analyst` |
| 搭建 CI/CD | `devops-engineer` |
| 设计掉落表 | `economy-designer` |
| 裁决创意冲突 | `creative-director` |
| 做架构决策 | `technical-director` |
| 管理一次发布 | `release-manager` |
| 准备待翻译的字符串 | `localization-lead` |
| 快速验证一个机制点子 | `prototyper` |
| 审查代码的安全问题 | `security-engineer` |
| 检查无障碍合规 | `accessibility-specialist` |
| 咨询 Unreal Engine 问题 | `unreal-specialist` |
| 咨询 Unity 问题 | `unity-specialist` |
| 咨询 Godot 问题 | `godot-specialist` |
| 设计 GAS 技能/效果 | `ue-gas-specialist` |
| 划定 BP/C++ 边界 | `ue-blueprint-specialist` |
| 实现 UE 复制(replication) | `ue-replication-specialist` |
| 构建 UMG/CommonUI 控件 | `ue-umg-specialist` |
| 设计 DOTS/ECS 架构 | `unity-dots-specialist` |
| 编写 Unity 着色器/VFX | `unity-shader-specialist` |
| 管理 Addressable 资产 | `unity-addressables-specialist` |
| 构建 UI Toolkit/UGUI 界面 | `unity-ui-specialist` |
| 编写地道的 GDScript | `godot-gdscript-specialist` |
| 编写 Godot C# 代码 | `godot-csharp-specialist` |
| 创建 Godot 着色器 | `godot-shader-specialist` |
| 构建 GDExtension 模块 | `godot-gdextension-specialist` |
| 规划线上活动与赛季 | `live-ops-designer` |
| 为玩家撰写补丁说明 | `community-manager` |
| 头脑风暴一个新游戏点子 | 使用 `/brainstorm` 技能 |

### 3. 用斜杠命令处理常见任务

| 命令 | 作用 |
|------|------|
| `/start` | 首次上手指引 —— 询问你的现状,引导你进入正确的工作流 |
| `/help` | 上下文感知的"下一步该做什么?" —— 读取你当前所处阶段与产物 |
| `/project-stage-detect` | 分析项目状态、检测阶段、识别缺口 |
| `/setup-engine` | 配置引擎与版本,填充参考文档 |
| `/adopt` | 对既有项目做既有项目(brownfield)审计与迁移计划 |
| `/brainstorm` | 从零开始的引导式游戏概念构思 |
| `/map-systems` | 将概念分解为系统、映射依赖、指导逐系统撰写 GDD |
| `/design-system` | 引导式逐节撰写单个游戏系统的 GDD |
| `/quick-design` | 面向小改动的轻量规格 —— 调参、微调、小型新增 |
| `/review-all-gdds` | 跨 GDD 一致性与游戏设计理论评审 |
| `/propagate-design-change` | 找出受 GDD 变更影响的 ADR 与故事 |
| `/art-bible` | 引导式逐节撰写美术圣经(Art Bible)—— 在资产生产前创建视觉识别规格 |
| `/asset-spec` | 从 GDD 或角色档案生成逐资产视觉规格与 AI 生成提示词 |
| `/ux-design` | 撰写 UX 规格(界面/流程、HUD、交互模式) |
| `/ux-review` | 校验 UX 规格的无障碍性与 GDD 对齐 |
| `/create-architecture` | 游戏的主架构文档 |
| `/architecture-decision` | 创建一份 ADR |
| `/architecture-review` | 校验所有 ADR、依赖排序、GDD 可追溯性 |
| `/create-control-manifest` | 从已 Accepted 的 ADR 生成扁平的程序员规则清单 |
| `/create-epics` | 将 GDD + ADR 转化为 Epic(每个架构模块一个) |
| `/create-stories` | 把单个 Epic 拆成可实现的故事文件 |
| `/dev-story` | 读取一个故事并实现它 —— 路由到正确的程序员代理 |
| `/sprint-plan` | 创建或更新 Sprint 计划 |
| `/sprint-status` | 30 行速览 Sprint 快照 |
| `/story-readiness` | 在领取前校验故事是否达到可实现状态 |
| `/story-done` | 故事收尾完成评审 —— 核验验收标准 |
| `/estimate` | 产出结构化工时估算 |
| `/design-review` | 评审一份设计文档 |
| `/code-review` | 评审代码质量与架构 |
| `/balance-check` | 分析游戏平衡数据 |
| `/asset-audit` | 审计资产合规性 |
| `/content-audit` | GDD 规定内容 vs 已实现内容 —— 找出缺口 |
| `/scope-check` | 对照计划检测范围蔓延 |
| `/perf-profile` | 性能剖析与瓶颈定位 |
| `/tech-debt` | 扫描、跟踪并排定技术债优先级 |
| `/gate-check` | 校验阶段就绪度(PASS/CONCERNS/FAIL) |
| `/consistency-check` | 扫描所有 GDD 的跨文档不一致(数值、名称、规则冲突) |
| `/security-audit` | 安全漏洞审计:存档篡改、作弊途径、网络利用、数据泄露 |
| `/reverse-document` | 从现有代码生成设计/架构文档 |
| `/milestone-review` | 评审里程碑进度 |
| `/retrospective` | 执行 Sprint/里程碑复盘 |
| `/bug-report` | 创建结构化缺陷报告 |
| `/playtest-report` | 创建或分析试玩测试反馈 |
| `/onboard` | 为某个角色生成上手文档 |
| `/release-checklist` | 校验发布前清单 |
| `/launch-checklist` | 完整的上线就绪校验 |
| `/changelog` | 从 Git 历史生成更新日志 |
| `/patch-notes` | 生成面向玩家的补丁说明 |
| `/hotfix` | 带审计追踪的紧急修复 |
| `/day-one-patch` | 为金牌母版(gold master)之后发现的已知问题准备聚焦的首日补丁 |
| `/prototype` | 概念原型 —— 在写 GDD 之前验证核心点子(第 1 阶段) |
| `/vertical-slice` | 生产质量的端到端构建 —— 验证完整游戏循环(第 4 阶段) |
| `/localize` | 本地化扫描、提取、校验 |
| `/team-combat` | 编排完整战斗团队管线 |
| `/team-narrative` | 编排完整叙事团队管线 |
| `/team-ui` | 编排完整 UI 团队管线 |
| `/team-release` | 编排完整发布团队管线 |
| `/team-polish` | 编排完整打磨团队管线 |
| `/team-audio` | 编排完整音频团队管线 |
| `/team-level` | 编排完整关卡创作管线 |
| `/team-live-ops` | 为赛季、活动与发布后内容编排在线运营(live-ops)团队 |
| `/team-qa` | 编排完整 QA 团队周期 —— 测试计划、测试用例、冒烟检查、签核 |
| `/qa-plan` | 为 Sprint 或特性生成 QA 测试计划 |
| `/bug-triage` | 重排未决缺陷优先级、分配到 Sprint、暴露系统性趋势 |
| `/smoke-check` | 在移交 QA 前运行关键路径冒烟测试门(PASS/FAIL) |
| `/soak-test` | 为长时间试玩会话生成浸泡测试方案 |
| `/regression-suite` | 将覆盖映射到 GDD 关键路径、标记缺口、维护回归套件 |
| `/test-setup` | 为项目引擎脚手架测试框架 + CI 管线(运行一次) |
| `/test-helpers` | 生成引擎特定的测试辅助库与工厂函数 |
| `/test-flakiness` | 从 CI 历史检测不稳定测试,标记隔离或修复 |
| `/test-evidence-review` | 测试文件与人工证据的质量评审 —— ADEQUATE/INCOMPLETE/MISSING |
| `/skill-test` | 校验技能文件的合规性与正确性(static / spec / audit) |
| `/skill-improve` | 用 测试-修复-复测 循环改进技能 —— 诊断、提出修复、重写、验证 |

### 4. 用模板创建新文档

模板位于 `.claude/docs/templates/`:

- `game-design-document.md` —— 用于新机制与系统
- `architecture-decision-record.md` —— 用于技术决策
- `architecture-traceability.md` —— 将 GDD 需求映射到 ADR 再到故事 ID
- `risk-register-entry.md` —— 用于新风险
- `narrative-character-sheet.md` —— 用于新角色
- `test-plan.md` —— 用于特性测试计划
- `sprint-plan.md` —— 用于 Sprint 规划
- `milestone-definition.md` —— 用于新里程碑
- `level-design-document.md` —— 用于新关卡
- `game-pillars.md` —— 用于核心设计支柱
- `art-bible.md` —— 用于视觉风格参考
- `technical-design-document.md` —— 用于逐系统技术设计
- `post-mortem.md` —— 用于项目/里程碑复盘
- `sound-bible.md` —— 用于音频风格参考
- `release-checklist-template.md` —— 用于平台发布清单
- `changelog-template.md` —— 用于面向玩家的补丁说明
- `release-notes.md` —— 用于面向玩家的发布说明
- `incident-response.md` —— 用于线上事故响应手册
- `game-concept.md` —— 用于初始游戏概念(MDA、SDT、Flow、Bartle)
- `pitch-document.md` —— 用于向利益相关方推介游戏
- `economy-model.md` —— 用于虚拟经济设计(sink/faucet 消耗/产出模型)
- `faction-design.md` —— 用于派系身份、设定与玩法角色
- `systems-index.md` —— 用于系统分解与依赖映射
- `project-stage-report.md` —— 用于项目阶段检测输出
- `design-doc-from-implementation.md` —— 用于把现有代码反向文档化为 GDD
- `architecture-doc-from-code.md` —— 用于把代码反向文档化为架构文档
- `concept-doc-from-prototype.md` —— 用于把原型反向文档化为概念文档
- `ux-spec.md` —— 用于逐界面 UX 规格(布局区域、状态、事件)
- `hud-design.md` —— 用于整局游戏的 HUD 理念、区域与元素规格
- `accessibility-requirements.md` —— 用于项目级无障碍等级与特性矩阵
- `interaction-pattern-library.md` —— 用于标准 UI 控件与游戏特定模式
- `player-journey.md` —— 用于 6 阶段情感弧线与按时间尺度的留存钩子
- `difficulty-curve.md` —— 用于难度轴、上手坡度与跨系统交互
- `test-evidence.md` —— 记录人工测试证据的模板(截图、走查笔记)

另有 `.claude/docs/templates/collaborative-protocols/`(由代理使用,通常不直接编辑):

- `design-agent-protocol.md` —— 设计代理的 提问-选项-草稿-批准 循环
- `implementation-agent-protocol.md` —— 编程代理从领取故事到 /story-done 的循环
- `leadership-agent-protocol.md` —— 总监级代理的跨部门委派与升级

### 5. 遵循协调规则

1. 工作沿层级向下流动:总监 -> 主管 -> 专家
2. 冲突沿层级向上升级
3. 跨部门工作由 `producer` 协调
4. 代理未经委派不得修改其领域之外的文件
5. 所有决策都要成文记录

## 新项目的第一步

**不知道从何开始?** 运行 `/start`。它会询问你的现状,并把你路由到正确的工作流。
不对你的游戏、引擎或经验水平做任何假设。

如果你已经知道自己需要什么,直接跳到相应路径:

### 路径 A:"我不知道该做什么"

1. **运行 `/start`**(或 `/brainstorm open`)—— 引导式创意探索:什么让你兴奋、
   你玩过什么、你的约束条件
   - 生成 3 个概念,帮你选定一个,定义核心循环与支柱
   - 产出游戏概念文档并推荐引擎
2. **搭建引擎** —— 运行 `/setup-engine`(使用 brainstorm 的推荐)
   - 配置 CLAUDE.md、检测知识缺口、填充参考文档
   - 创建 `.claude/docs/technical-preferences.md`,包含命名规范、性能预算与引擎
     特定默认值
   - 如果引擎版本新于 LLM 的训练数据,它会从网络获取当前文档,让代理给出正确
     的 API 建议
3. **验证概念** —— 运行 `/design-review design/gdd/game-concept.md`
4. **分解为系统** —— 运行 `/map-systems` 映射所有系统与依赖
5. **设计每个系统** —— 运行 `/design-system [system-name]`(或 `/map-systems next`),
   按依赖顺序撰写 GDD
6. **为机制做原型** —— 运行 `/prototype [core-mechanic]`(1–3 天 —— 在写 GDD 之前)
7. **设计每个系统** —— 运行 `/design-system [system-name]` 撰写 GDD,吸收原型结论
8. **规划第一个 Sprint** —— 在架构与 `/vertical-slice` 之后,运行 `/sprint-plan new`
9. 开始构建

### 路径 B:"我知道要做什么"

如果你已有游戏概念和引擎选择:

1. **搭建引擎** —— 运行 `/setup-engine [engine] [version]`
   (例如 `/setup-engine godot 4.6`)—— 同时创建技术偏好
2. **撰写游戏支柱** —— 委派给 `creative-director`
3. **分解为系统** —— 运行 `/map-systems` 枚举系统与依赖
4. **设计每个系统** —— 运行 `/design-system [system-name]`,按依赖顺序写 GDD
5. **创建初始 ADR** —— 运行 `/architecture-decision`
6. **在 `production/milestones/` 中创建第一个里程碑**
7. **规划第一个 Sprint** —— 运行 `/sprint-plan new`
8. 开始构建

### 路径 C:"我懂游戏但不懂引擎"

如果你有概念但不知道哪个引擎合适:

1. **不带参数运行 `/setup-engine`** —— 它会询问你游戏的需求(2D/3D、平台、团队
   规模、语言偏好),并基于你的回答推荐引擎
2. 从第 2 步开始遵循路径 B

### 路径 D:"我有一个既有项目"

如果你已经有设计文档、原型或代码:

1. **运行 `/start`**(或 `/project-stage-detect`)—— 分析已有内容、识别缺口、
   推荐下一步
2. **运行 `/adopt`** —— 如果你已有 GDD、ADR 或故事:审计内部格式合规性,并构建
   编号迁移计划来填补缺口,不会覆盖你已有的工作
3. **按需配置引擎** —— 若尚未配置,运行 `/setup-engine`
4. **校验阶段就绪度** —— 运行 `/gate-check` 查看你所处的位置
5. **规划下一个 Sprint** —— 运行 `/sprint-plan new`

## 文件结构参考

```
CLAUDE.md                          -- Master config (read this first, ~60 lines)
.claude/
  settings.json                    -- Claude Code hooks and project settings
  agents/                          -- 49 agent definitions (YAML frontmatter)
  skills/                          -- 73 slash command definitions (YAML frontmatter)
  hooks/                           -- 12 hook scripts (.sh) wired by settings.json
  rules/                           -- 11 path-specific rule files
  docs/
    quick-start.md                 -- This file
    technical-preferences.md       -- Project-specific standards (populated by /setup-engine)
    coding-standards.md            -- Coding and design doc standards
    coordination-rules.md          -- Agent coordination rules
    context-management.md          -- Context budgets and compaction instructions
    directory-structure.md         -- Project directory layout
    workflow-catalog.yaml          -- 7-phase pipeline definition (read by /help)
    setup-requirements.md          -- System prerequisites (Git Bash, jq, Python)
    settings-local-template.md     -- Personal settings.local.json guide
    templates/                     -- 41 document templates
```
