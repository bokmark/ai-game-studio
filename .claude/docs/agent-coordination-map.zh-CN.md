> 中文翻译 | [English](agent-coordination-map.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# 代理协调与委派地图

## 组织层级

```
                           [Human Developer]
                                 |
                 +---------------+---------------+
                 |               |               |
         creative-director  technical-director  producer
                 |               |               |
        +--------+--------+     |        (coordinates all)
        |        |        |     |
  game-designer art-dir  narr-dir  lead-programmer  qa-lead  audio-dir
        |        |        |         |                |        |
     +--+--+     |     +--+--+  +--+--+--+--+--+   |        |
     |  |  |     |     |     |  |  |  |  |  |  |   |        |
    sys lvl eco  ta   wrt  wrld gp ep  ai net tl ui qa-t    snd
                                 |
                             +---+---+
                             |       |
                          perf-a   devops   analytics

  Additional Leads (report to producer/directors):
    release-manager         -- Release pipeline, versioning, deployment
    localization-lead       -- i18n, string tables, translation pipeline
    prototyper              -- Rapid throwaway prototypes, concept validation
    security-engineer       -- Anti-cheat, exploits, data privacy, network security
    accessibility-specialist -- WCAG, colorblind, remapping, text scaling
    live-ops-designer       -- Seasons, events, battle passes, retention, live economy
    community-manager       -- Patch notes, player feedback, crisis comms

  Engine Specialists (use the SET matching your engine):
    unreal-specialist  -- UE5 lead: Blueprint/C++, GAS overview, UE subsystems
      ue-gas-specialist         -- GAS: abilities, effects, attributes, tags, prediction
      ue-blueprint-specialist   -- Blueprint: BP/C++ boundary, graph standards, optimization
      ue-replication-specialist -- Networking: replication, RPCs, prediction, bandwidth
      ue-umg-specialist         -- UI: UMG, CommonUI, widget hierarchy, data binding

    unity-specialist   -- Unity lead: MonoBehaviour/DOTS, Addressables, URP/HDRP
      unity-dots-specialist         -- DOTS/ECS: Jobs, Burst, hybrid renderer
      unity-shader-specialist       -- Shaders: Shader Graph, VFX Graph, SRP customization
      unity-addressables-specialist -- Assets: async loading, bundles, memory, CDN
      unity-ui-specialist           -- UI: UI Toolkit, UGUI, UXML/USS, data binding

    godot-specialist   -- Godot 4 lead: GDScript, node/scene, signals, resources
      godot-gdscript-specialist    -- GDScript: static typing, patterns, signals, performance
      godot-csharp-specialist      -- C#: .NET patterns, [Signal] delegates, async, type-safe node access
      godot-shader-specialist      -- Shaders: Godot shading language, visual shaders, VFX
      godot-gdextension-specialist -- Native: C++/Rust bindings, GDExtension, build systems
```

### 图例

```
sys  = systems-designer       gp  = gameplay-programmer
lvl  = level-designer         ep  = engine-programmer
eco  = economy-designer       ai  = ai-programmer
ta   = technical-artist       net = network-programmer
wrt  = writer                 tl  = tools-programmer
wrld = world-builder          ui  = ui-programmer
snd  = sound-designer         qa-t = qa-tester
narr-dir = narrative-director perf-a = performance-analyst
art-dir = art-director
```

## 委派规则

### 谁可以委派给谁

| 委派方 | 可委派给 |
|------|----------------|
| creative-director | game-designer、art-director、audio-director、narrative-director |
| technical-director | lead-programmer、devops-engineer、performance-analyst、technical-artist(技术决策) |
| producer | 任意代理(仅限其领域内的任务分配) |
| game-designer | systems-designer、level-designer、economy-designer |
| lead-programmer | gameplay-programmer、engine-programmer、ai-programmer、network-programmer、tools-programmer、ui-programmer |
| art-director | technical-artist、ux-designer |
| audio-director | sound-designer |
| narrative-director | writer、world-builder |
| qa-lead | qa-tester |
| release-manager | devops-engineer(发布构建)、qa-lead(发布测试) |
| localization-lead | writer(字符串审校)、ui-programmer(文本适配) |
| prototyper | (独立工作,向 producer 及相关主管汇报发现) |
| security-engineer | network-programmer(安全审查)、lead-programmer(安全模式) |
| accessibility-specialist | ux-designer(无障碍模式)、ui-programmer(实现)、qa-tester(无障碍测试) |
| [engine]-specialist | 引擎子专家(委派子系统相关工作) |
| [engine] 子专家 | (就引擎子系统模式与优化为全体程序员提供咨询) |
| live-ops-designer | economy-designer(在线经济)、community-manager(活动沟通)、analytics-engineer(参与度指标) |
| community-manager | (与 producer 协作获取批准,与 release-manager 协作确定补丁说明发布时机) |

### 升级路径

| 情形 | 升级给 |
|-----------|------------|
| 两名设计师对某一机制意见不合 | game-designer |
| 游戏设计与叙事冲突 | creative-director |
| 游戏设计与技术可行性冲突 | producer(居中协调),然后 creative-director + technical-director |
| 美术与音频基调冲突 | creative-director |
| 代码架构分歧 | technical-director |
| 跨系统代码冲突 | lead-programmer,然后 technical-director |
| 部门间排期冲突 | producer |
| 范围超出产能 | producer,然后由 creative-director 决定删减 |
| 质量门分歧 | qa-lead,然后 technical-director |
| 性能预算超标 | performance-analyst 标记,technical-director 裁决 |

## 常见工作流模式

### 模式 1:新功能(完整流水线)

```
1. creative-director  -- Approves feature concept aligns with vision
2. game-designer      -- Creates design document with full spec
3. producer           -- Schedules work, identifies dependencies
4. lead-programmer    -- Designs code architecture, creates interface sketch
5. [specialist-programmer] -- Implements the feature
6. technical-artist   -- Implements visual effects (if needed)
7. writer             -- Creates text content (if needed)
8. sound-designer     -- Creates audio event list (if needed)
9. qa-tester          -- Writes test cases
10. qa-lead           -- Reviews and approves test coverage
11. lead-programmer   -- Code review
12. qa-tester         -- Executes tests
13. producer          -- Marks task complete
```

### 模式 2:缺陷修复

```
1. qa-tester          -- Files bug report with /bug-report
2. qa-lead            -- Triages severity and priority
3. producer           -- Assigns to sprint (if not S1)
4. lead-programmer    -- Identifies root cause, assigns to programmer
5. [specialist-programmer] -- Fixes the bug
6. lead-programmer    -- Code review
7. qa-tester          -- Verifies fix and runs regression
8. qa-lead            -- Closes bug
```

### 模式 3:平衡性调整

```
1. analytics-engineer -- Identifies imbalance from data (or player reports)
2. game-designer      -- Evaluates the issue against design intent
3. economy-designer   -- Models the adjustment
4. game-designer      -- Approves the new values
5. [data file update] -- Change configuration values
6. qa-tester          -- Regression test affected systems
7. analytics-engineer -- Monitor post-change metrics
```

### 模式 4:新区域/关卡

```
1. narrative-director -- Defines narrative purpose and beats for the area
2. world-builder      -- Creates lore and environmental context
3. level-designer     -- Designs layout, encounters, pacing
4. game-designer      -- Reviews mechanical design of encounters
5. art-director       -- Defines visual direction for the area
6. audio-director     -- Defines audio direction for the area
7. [implementation by relevant programmers and artists]
8. writer             -- Creates area-specific text content
9. qa-tester          -- Tests the complete area
```

### 模式 5:Sprint 周期

```
1. producer           -- Plans sprint with /sprint-plan new
2. [All agents]       -- Execute assigned tasks
3. producer           -- Daily status with /sprint-plan status
4. qa-lead            -- Continuous testing during sprint
5. lead-programmer    -- Continuous code review during sprint
6. producer           -- Sprint retrospective with post-sprint hook
7. producer           -- Plans next sprint incorporating learnings
```

### 模式 6:里程碑检查点

```
1. producer           -- Runs /milestone-review
2. creative-director  -- Reviews creative progress
3. technical-director -- Reviews technical health
4. qa-lead            -- Reviews quality metrics
5. producer           -- Facilitates go/no-go discussion
6. [All directors]    -- Agree on scope adjustments if needed
7. producer           -- Documents decisions and updates plans
```

### 模式 7:发布流水线

```text
1. producer             -- Declares release candidate, confirms milestone criteria met
2. release-manager      -- Cuts release branch, generates /release-checklist
3. qa-lead              -- Runs full regression, signs off on quality
4. localization-lead    -- Verifies all strings translated, text fitting passes
5. performance-analyst  -- Confirms performance benchmarks within targets
6. devops-engineer      -- Builds release artifacts, runs deployment pipeline
7. release-manager      -- Generates /changelog, tags release, creates release notes
8. technical-director   -- Final sign-off on major releases
9. release-manager      -- Deploys and monitors for 48 hours
10. producer            -- Marks release complete
```

### 模式 8:概念原型(早期——在 GDD 之前)

```text
1. game-designer        -- Defines the hypothesis and success criteria
2. prototyper           -- Scaffolds concept prototype with /prototype
3. prototyper           -- Builds minimal implementation (1-3 days)
4. game-designer        -- Evaluates prototype against criteria
5. prototyper           -- Documents findings in REPORT.md
6. creative-director    -- PROCEED / PIVOT / KILL decision (full mode only)
7. game-designer        -- Informs GDD writing with prototype learnings if PROCEED
```

### 模式 8b:垂直切片(预制作——在 GDD 与架构之后)

```text
1. game-designer        -- Confirms slice scope against GDDs
2. prototyper           -- Builds production-quality end-to-end build with /vertical-slice
3. prototyper           -- Conducts internal playtest sessions (minimum 1)
4. prototyper           -- Documents findings in REPORT.md
5. creative-director    -- Go/no-go decision on proceeding to Production (full mode)
6. producer             -- Schedules Production epics/sprints if PROCEED
```

### 模式 9:在线活动/赛季上线

```text
1. live-ops-designer     -- Designs event/season content, rewards, schedule
2. game-designer         -- Validates gameplay mechanics for event
3. economy-designer      -- Balances event economy and reward values
4. narrative-director    -- Provides seasonal narrative theme
5. writer                -- Creates event descriptions and lore
6. producer              -- Schedules implementation work
7. [implementation by relevant programmers]
8. qa-lead               -- Test event flow end-to-end
9. community-manager     -- Drafts event announcement and patch notes
10. release-manager      -- Deploys event content
11. analytics-engineer   -- Monitors event participation and metrics
12. live-ops-designer    -- Post-event analysis and learnings
```

## 跨领域沟通协议

### 设计变更通知

设计文档发生变更时,game-designer 必须通知:
- lead-programmer(实现影响)
- qa-lead(需要更新测试计划)
- producer(排期影响评估)
- 视变更内容而定的相关专家代理

### 架构变更通知

ADR 创建或修改时,technical-director 必须通知:
- lead-programmer(需要改动代码)
- 所有受影响的专家程序员
- qa-lead(测试策略可能变化)
- producer(排期影响)

### 资产标准变更通知

美术圣经或资产标准变更时,art-director 必须通知:
- technical-artist(管线变更)
- 所有使用受影响资产的内容创作者
- devops-engineer(若构建管线受影响)

## 应避免的反模式

1. **绕过层级**:专家代理绝不应在未咨询其主管的情况下,
   擅自做出属于主管职责的决策。
2. **跨领域实现**:代理绝不应在未获相关负责人明确委派的情况下,
   修改其指定范围之外的文件。
3. **影子决策**:所有决策必须记录在案。没有书面记录的口头约定
   会导致前后矛盾。
4. **巨型任务**:分配给代理的每项任务应可在 1-3 天内完成。
   若超出,必须先拆分。
5. **基于猜测的实现**:若规格说明有歧义,实现者必须向规格制定者
   求证,而不是靠猜。猜错的代价比提一个问题高得多。
