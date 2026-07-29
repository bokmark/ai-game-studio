> 中文翻译 | [English](director-gates.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# 总监门 —— 共享评审模式

本文档为所有工作流阶段中的总监与主管评审定义了标准门提示词。技能引用本文档中的
门 ID,而不再内联嵌入完整提示词 —— 从而在提示词需要更新时消除漂移。

**适用范围**:全部 7 个生产阶段(概念 → 发布)、全部 3 位 Tier 1 总监,以及所有
关键的 Tier 2 主管。任何技能、团队编排器或工作流均可调用这些门。

---

## 如何使用本文档

在任意技能中,将内联的总监提示词替换为引用:

```
Spawn `creative-director` via Task using gate **CD-PILLARS** from
`.claude/docs/director-gates.md`.
```

传入该门 **Context to pass**(待传入上下文)字段中列出的内容,然后按下文的
**Verdict handling**(裁决处理)规则处理裁决(verdict)结果。

---

## 评审模式

评审强度控制总监门是否运行。可全局设置(跨会话保持),也可按单次技能运行覆盖。

**全局配置**:`production/review-mode.txt` —— 一个单词:`full`、`lean` 或 `solo`。
在 `/start` 期间设置一次。之后可随时直接编辑该文件修改。

**单次覆盖**:任何使用门的技能都接受 `--review [full|lean|solo]` 参数。该参数仅
覆盖本次运行的全局配置。

示例:
```
/brainstorm space horror           → uses global mode
/brainstorm space horror --review full   → forces full mode this run
/architecture-decision --review solo     → skips all gates this run
```

| 模式 | 运行内容 | 最适合 |
|------|----------|--------|
| `full` | 所有门全部启用 —— 每个工作流步骤都经过评审 | 团队、学习型用户,或希望在每一步都获得完整总监反馈时 |
| `lean` | 仅运行阶段门(`/gate-check`)—— 跳过逐技能门 | **默认** —— 独立开发者与小团队;总监只在里程碑处评审 |
| `solo` | 不运行任何总监门 | Game Jam、原型、极致速度 |

**检查模式 —— 每次生成门之前执行:**

```
Before spawning gate [GATE-ID]:
1. If skill was called with --review [mode], use that
2. Else read production/review-mode.txt
3. Else default to lean

Apply the resolved mode:
- solo → skip all gates. Note: "[GATE-ID] skipped — Solo mode"
- lean → skip unless this is a PHASE-GATE (CD-PHASE-GATE, TD-PHASE-GATE, PR-PHASE-GATE, AD-PHASE-GATE)
         Note: "[GATE-ID] skipped — Lean mode"
- full → spawn as normal
```

---

## 调用模式(可复制到任意技能)

**强制要求:每次生成门之前先解析评审模式。** 未经检查绝不生成门。解析结果在每次
技能运行中只确定一次:
1. 若技能以 `--review [mode]` 被调用,使用该模式
2. 否则读取 `production/review-mode.txt`
3. 否则默认为 `lean`

应用解析出的模式:
- `solo` → **跳过所有门**。在输出中注明:`[GATE-ID] skipped — Solo mode`
- `lean` → **除非是阶段门,否则跳过**(CD-PHASE-GATE、TD-PHASE-GATE、PR-PHASE-GATE、AD-PHASE-GATE)。注明:`[GATE-ID] skipped — Lean mode`
- `full` → 正常生成

```
# Apply mode check, then:
Spawn `[agent-name]` via Task:
- Gate: [GATE-ID] (see .claude/docs/director-gates.md)
- Context: [fields listed under that gate]
- Await the verdict before proceeding.
```

并行生成(多位总监在同一门点):

```
# Apply mode check for each gate first, then spawn all that survive:
Spawn all [N] agents simultaneously via Task — issue all Task calls before
waiting for any result. Collect all verdicts before proceeding.
```

---

## 标准裁决格式

所有门返回三种裁决之一。技能必须能处理全部三种:

| 裁决 | 含义 | 默认动作 |
|------|------|----------|
| **APPROVE / READY** | 无问题。继续。 | 继续工作流 |
| **CONCERNS [list]** | 存在问题但不阻塞。 | 通过 `AskUserQuestion` 提交给用户 —— 选项:`Revise flagged items` / `Accept and proceed` / `Discuss further` |
| **REJECT / NOT READY [blockers]** | 阻塞性问题。不得继续。 | 向用户说明阻塞项。在解决之前不写入文件、不推进阶段。 |

**升级规则**:多位总监并行生成时,采用最严格的裁决 —— 一个 NOT READY 覆盖所有
READY。

---

## 记录门结果

门结束后,在相关文档的状态头中记录裁决:

```markdown
> **[Director] Review ([GATE-ID])**: APPROVED [date] / CONCERNS (accepted) [date] / REVISED [date]
```

对于阶段门,视情况记录到 `docs/architecture/architecture.md` 或
`production/session-state/active.md`。

---

## Tier 1 —— 创意总监门

代理:`creative-director` | 模型档位:Opus | 领域:愿景、支柱、玩家体验

---

### CD-PILLARS —— 支柱压力测试

**触发条件(Trigger)**:游戏支柱(pillar)与反支柱定义完成之后(brainstorm 第 4
阶段,或支柱被修订的任何时间)

**待传入上下文(Context to pass)**:
- 完整支柱集:名称、定义与设计检验
- 反支柱列表
- 核心幻想(core fantasy)陈述
- 独特钩子("Like X, AND ALSO Y")

**提示词(Prompt)**:
> "评审这些游戏支柱。它们是否可证伪 —— 一个真实的设计决策是否可能真的通不过该
> 支柱?它们彼此之间是否形成有意义的张力?它们能否让本游戏与最接近的参照作品区
> 分开?在实践中它们能否帮助化解设计分歧,还是模糊到毫无用处?请逐支柱给出具体
> 反馈,并给出总体裁决:APPROVE(有力)、CONCERNS [list](需要打磨),或 REJECT
> (薄弱 —— 支柱不具约束力)。"

**裁决(Verdicts)**:APPROVE / CONCERNS / REJECT

---

### CD-GDD-ALIGN —— GDD 支柱对齐检查

**触发条件**:系统 GDD 撰写完成后(design-system、quick-design,或任何产出 GDD
的工作流)

**待传入上下文**:
- GDD 文件路径
- 游戏支柱(来自 `design/gdd/game-concept.md` 或 `design/gdd/game-pillars.md`)
- 本游戏的 MDA 美学目标
- 该系统所述的玩家幻想(Player Fantasy)一节

**提示词**:
> "评审这份系统 GDD 的支柱对齐情况。每个章节是否都服务于所述支柱?是否存在与支
> 柱相矛盾或削弱支柱的机制或规则?玩家幻想一节是否与游戏的核心幻想一致?返回
> APPROVE、CONCERNS [存在问题的具体章节],或 REJECT [在该系统可实施之前必须重新
> 设计的支柱违规项]。"

**裁决**:APPROVE / CONCERNS / REJECT

---

### CD-SYSTEMS —— 系统分解愿景检查

**触发条件**:`/map-systems` 写完系统索引之后 —— 在 GDD 撰写开始前校验完整的
系统集合

**待传入上下文**:
- 系统索引路径(`design/gdd/systems-index.md`)
- 游戏支柱与核心幻想(来自 `design/gdd/game-concept.md`)
- 优先级层级划分(MVP / Vertical Slice / Alpha / Full Vision)
- 依赖图中识别出的任何高风险或瓶颈系统

**提示词**:
> "对照游戏设计支柱评审这份系统分解。全部 MVP 层系统合起来能否交付核心幻想?是
> 否存在机制不服务于任何所述支柱的系统 —— 表明它们可能是范围蔓延?是否存在对支
> 柱至关重要、却没有系统负责交付的玩家体验?核心循环所需的系统是否有缺失?返回
> APPROVE(系统服务于愿景)、CONCERNS [具体缺口或错位及其支柱影响],或 REJECT
> [根本性缺口 —— 该分解遗漏了关键设计意图,必须在 GDD 撰写开始前修订]。"

**裁决**:APPROVE / CONCERNS / REJECT

---

### CD-NARRATIVE —— 叙事一致性检查

**触发条件**:叙事 GDD、设定文档、对白规格或世界观构建文档撰写完成后
(team-narrative、故事系统的 design-system、编剧交付物)

**待传入上下文**:
- 文档文件路径
- 游戏支柱
- 叙事方向简报或基调指南(若存在于 `design/narrative/`)
- 新文档引用的任何既有设定

**提示词**:
> "评审这份叙事内容与游戏支柱及既定世界规则的一致性。基调是否符合游戏既定的叙
> 事声音?是否与既有设定或世界观构建相矛盾?内容是否服务于玩家体验支柱?返回
> APPROVE、CONCERNS [具体不一致之处],或 REJECT [破坏世界连贯性的矛盾]。"

**裁决**:APPROVE / CONCERNS / REJECT

---

### CD-PLAYTEST —— 玩家体验验证

**触发条件**:试玩测试报告生成后(`/playtest-report`),或任何产生玩家反馈的
会话之后

**待传入上下文**:
- 试玩测试报告文件路径
- 游戏支柱与核心幻想陈述
- 本次测试的具体假设

**提示词**:
> "对照游戏设计支柱与核心幻想评审这份试玩测试报告。玩家体验是否契合预期幻想?
> 是否存在代表支柱漂移的系统性问题 —— 某些机制单独看没问题,却削弱了预期体验?
> 返回 APPROVE(核心幻想立住了)、CONCERNS [预期体验与实际体验的差距],或
> REJECT [核心幻想未呈现 —— 继续试玩测试前需要重新设计]。"

**裁决**:APPROVE / CONCERNS / REJECT

---

### CD-PHASE-GATE —— 阶段转换时的创意就绪度

**触发条件**:每次 `/gate-check` 必触发 —— 与 TD-PHASE-GATE、PR-PHASE-GATE
并行生成

**待传入上下文**:
- 目标阶段名称
- 现有全部产物的清单(文件路径)
- 游戏支柱与核心幻想

**提示词**:
> "从创意方向角度,评审当前项目状态对 [target phase] 的门就绪度。游戏支柱是否
> 在所有设计产物中得到忠实呈现?当前状态是否保持了核心幻想?GDD 或架构中是否存
> 在损害预期玩家体验的设计决策?返回 READY、CONCERNS [list],或 NOT READY
> [blockers]。"

**裁决**:READY / CONCERNS / NOT READY

---

## Tier 1 —— 技术总监门

代理:`technical-director` | 模型档位:Opus | 领域:架构、引擎风险、性能

---

### TD-SYSTEM-BOUNDARY —— 系统边界架构评审

**触发条件**:`/map-systems` 第 3 阶段依赖映射达成一致之后、GDD 撰写开始之前
—— 在各团队投入撰写 GDD 之前,验证系统结构在架构上是健全的

**待传入上下文**:
- 系统索引路径(若索引尚未写完,则为依赖映射摘要)
- 分层划分(Foundation / Core / Feature / Presentation / Polish)
- 完整依赖图(每个系统依赖什么)
- 任何被标记的瓶颈系统(依赖者众多)
- 发现的任何循环依赖及其拟议解决方案

**提示词**:
> "在 GDD 撰写开始之前,从架构角度评审这份系统分解。系统边界是否干净 —— 每个
> 系统是否各自拥有职责清晰、重叠最小的关注点?是否存在 God Object 风险(系统承
> 担过多)?依赖排序是否会制造实现顺序问题?拟议边界中是否存在隐式共享状态问题,
> 会在实现时导致紧耦合?是否有 Foundation 层系统实际上依赖 Feature 层系统(依赖
> 倒置)?返回 APPROVE(边界在架构上健全 —— 可进入 GDD 撰写)、CONCERNS [需在
> GDD 中处理的具体边界问题],或 REJECT [根本性边界问题 —— 该系统结构会引发架构
> 问题,必须在撰写任何 GDD 之前重构]。"

**裁决**:APPROVE / CONCERNS / REJECT

---

### TD-FEASIBILITY —— 技术可行性评估

**触发条件**:在范围/可行性评估中识别出最大技术风险之后(brainstorm 第 6 阶段、
quick-design,或任何存在技术未知数的早期概念)

**待传入上下文**:
- 概念的核心循环描述
- 目标平台
- 引擎选择(或 "undecided")
- 已识别技术风险清单

**提示词**:
> "评审一款面向 [platform]、使用 [engine or 'undecided engine'] 的 [genre] 游
> 戏的这些技术风险。标记:任何可能使所述概念不成立的 HIGH 风险项;任何引擎特有、
> 应影响引擎选择的风险;以及任何独立开发者普遍低估的风险。返回 VIABLE(风险可
> 控)、CONCERNS [附缓解建议的清单],或 HIGH RISK [需要修订概念或范围的阻塞
> 项]。"

**裁决**:VIABLE / CONCERNS / HIGH RISK

---

### TD-ARCHITECTURE —— 架构签核

**触发条件**:主架构文档起草完成后(`/create-architecture` 第 7 阶段),以及
任何重大架构修订之后

**待传入上下文**:
- 架构文档路径(`docs/architecture/architecture.md`)
- 技术需求基线(TR-ID 及数量)
- ADR 清单及状态
- 引擎知识缺口清单

**提示词**:
> "评审这份主架构文档的技术健全性。检查:(1) 基线中的每条技术需求是否都有架
> 构决策覆盖?(2) 所有 HIGH 风险的引擎领域是否已明确处理或标记为待定问题?
> (3) API 边界是否干净、最小且可实现?(4) Foundation 层的 ADR 缺口是否在实现
> 开始前已解决?返回 APPROVE、CONCERNS [list],或 REJECT [开始编码前必须解决的
> 阻塞项]。"

**裁决**:APPROVE / CONCERNS / REJECT

---

### TD-ADR —— 架构决策评审

**触发条件**:单个 ADR 撰写完成后(`/architecture-decision`)、标记为 Accepted
之前

**待传入上下文**:
- ADR 文件路径
- 该领域的引擎版本与知识缺口风险等级
- 相关 ADR(如有)

**提示词**:
> "评审这份架构决策记录(ADR)。问题陈述与理由是否清晰?被否决的备选方案是否经
> 过认真考量?Consequences 一节是否诚实地承认了权衡?是否标注了引擎版本?是否
> 标记了知识截止后的 API 风险?是否链接到它所覆盖的 GDD 需求?返回 APPROVE、
> CONCERNS [具体缺口],或 REJECT [决策规格不足,或基于不成立的技术假设]。"

**裁决**:APPROVE / CONCERNS / REJECT

---

### TD-ENGINE-RISK —— 引擎版本风险评审

**触发条件**:当架构决策涉及知识截止(knowledge cutoff)后的引擎 API 时,或在
最终确定任何引擎特定的实现方案之前

**待传入上下文**:
- 所使用的具体 API 或特性
- 引擎版本与 LLM 知识截止时间(来自 `docs/engine-reference/[engine]/VERSION.md`)
- breaking-changes 或 deprecated-apis 文档中的相关摘录

**提示词**:
> "对照版本参考评审这一引擎 API 用法。该 API 是否存在于 [engine version]?自
> LLM 知识截止以来,其签名、行为或命名空间是否发生变化?是否存在已知的弃用或知
> 识截止后的替代方案?返回 APPROVE(可按所述安全使用)、CONCERNS [实现前需核
> 实],或 REJECT [API 已变更 —— 请给出修正方案]。"

**裁决**:APPROVE / CONCERNS / REJECT

---

### TD-PHASE-GATE —— 阶段转换时的技术就绪度

**触发条件**:每次 `/gate-check` 必触发 —— 与 CD-PHASE-GATE、PR-PHASE-GATE
并行生成

**待传入上下文**:
- 目标阶段名称
- 架构文档路径(如存在)
- 引擎参考路径
- ADR 清单

**提示词**:
> "从技术方向角度,评审当前项目状态对 [target phase] 的门就绪度。架构对本阶段
> 是否健全?所有高风险引擎领域是否已处理?性能预算是否现实且成文?Foundation 层
> 决策是否完备到可以开始实现?返回 READY、CONCERNS [list],或 NOT READY
> [blockers]。"

**裁决**:READY / CONCERNS / NOT READY

---

## Tier 1 —— 制作人门

代理:`producer` | 模型档位:Opus | 领域:范围、进度、依赖、生产风险

---

### PR-SCOPE —— 范围与进度验证

**触发条件**:范围层级(scope tier)定义完成后(brainstorm 第 6 阶段、
quick-design,或任何产出 MVP 定义与进度估算的工作流)

**待传入上下文**:
- 完整愿景范围描述
- MVP 定义
- 进度估算
- 团队规模(独立 / 小团队 / 等)
- 范围层级(时间耗尽时交付什么)

**提示词**:
> "评审这份范围估算。对所述团队规模,MVP 能否在所述时间线内达成?范围层级是否
> 按风险正确排序 —— 若工作在某一层级停止,该层级能否交付可发布的产品?时间压力
> 下最可能的砍裁点在哪里,它是优雅降级还是残缺产品?返回 REALISTIC(范围匹配产
> 能)、OPTIMISTIC [建议的具体调整],或 UNREALISTIC [阻塞项 —— 必须修订时间线
> 或 MVP]。"

**裁决**:REALISTIC / OPTIMISTIC / UNREALISTIC

---

### PR-SPRINT —— Sprint 可行性评审

**触发条件**:最终确定 Sprint 计划之前(`/sprint-plan`),以及任何 Sprint 中途
范围变更之后

**待传入上下文**:
- 拟议的 Sprint 故事清单(标题、估算、依赖)
- 团队产能(可用工时)
- 当前 Sprint 积压债(如有)
- 里程碑约束

**提示词**:
> "评审这份 Sprint 计划的可行性。故事负载对可用产能是否现实?故事是否按依赖正
> 确排序?故事之间是否存在可能在 Sprint 中途造成阻塞的隐藏依赖?是否有故事相对
> 其技术复杂度被低估?返回 REALISTIC(计划可达成)、CONCERNS [具体风险],或
> UNREALISTIC [Sprint 必须缩减范围 —— 指出应推迟哪些故事]。"

**裁决**:REALISTIC / CONCERNS / UNREALISTIC

---

### PR-MILESTONE —— 里程碑风险评估

**触发条件**:里程碑评审时(`/milestone-review`)、Sprint 中途复盘时,或提出
影响里程碑的范围变更时

**待传入上下文**:
- 里程碑定义与目标日期
- 当前完成百分比
- 被阻塞故事数量
- Sprint 速率(velocity)数据(如有)

**提示词**:
> "评审这个里程碑状态。基于当前速率与被阻塞故事数量,该里程碑能否按期达成?从
> 现在到里程碑之间的前 3 大生产风险是什么?为保护里程碑日期,应砍掉哪些范围项,
> 哪些又不可妥协?返回 ON TRACK、AT RISK [具体缓解措施],或 OFF TRACK [日期必
> 须顺延或范围必须砍裁 —— 两种方案都给出]。"

**裁决**:ON TRACK / AT RISK / OFF TRACK

---

### PR-EPIC —— Epic 结构可行性评审

**触发条件**:`/create-epics` 定义完 Epic 之后、拆分故事之前 —— 在调用
`/create-stories` 之前验证 Epic 结构是可生产的

**待传入上下文**:
- Epic 定义文件路径(刚创建的所有 Epic)
- Epic 索引路径(`production/epics/index.md`)
- 里程碑时间线与目标日期
- 团队产能(独立 / 小团队 / 规模)
- 正在 Epic 化的层(Foundation / Core / Feature / 等)

**提示词**:
> "在故事拆分开始之前,评审这套 Epic 结构的生产可行性。Epic 边界范围是否恰当
> —— 每个 Epic 能否现实地在里程碑期限前完成?Epic 是否按系统依赖正确排序 ——
> 是否有 Epic 必须等待另一个 Epic 的产出才能开工?是否有 Epic 范围过小(应合并)
> 或过大(应拆成 2-3 个聚焦的 Epic)?Foundation 层 Epic 的范围是否能让 Core 层
> Epic 在 Foundation 完成后的下一个 Sprint 开始时启动?返回 REALISTIC(Epic 结
> 构可生产)、CONCERNS [写故事前需要的具体结构调整],或 UNREALISTIC [Epic 必须
> 拆分、合并或重排 —— 解决前不得开始故事拆分]。"

**裁决**:REALISTIC / CONCERNS / UNREALISTIC

---

### PR-PHASE-GATE —— 阶段转换时的生产就绪度

**触发条件**:每次 `/gate-check` 必触发 —— 与 CD-PHASE-GATE、TD-PHASE-GATE
并行生成

**待传入上下文**:
- 目标阶段名称
- 现有的 Sprint 与里程碑产物
- 团队规模与产能
- 当前被阻塞故事数量

**提示词**:
> "从生产角度,评审当前项目状态对 [target phase] 的门就绪度。对所述时间线与团
> 队规模,范围是否现实?依赖是否排序得当,团队能否真正按序执行?是否存在可能在
> 前两个 Sprint 内使本阶段脱轨的里程碑或 Sprint 风险?返回 READY、CONCERNS
> [list],或 NOT READY [blockers]。"

**裁决**:READY / CONCERNS / NOT READY

---

## Tier 1 —— 美术总监门

代理:`art-director` | 模型档位:Sonnet | 领域:视觉识别、美术圣经、视觉生产
就绪度

---

### AD-CONCEPT-VISUAL —— 视觉识别锚点

**触发条件**:游戏支柱锁定后(brainstorm 第 4 阶段),与 CD-PILLARS 并行

**待传入上下文**:
- 游戏概念(电梯演讲、核心幻想、独特钩子)
- 完整支柱集:名称、定义与设计检验
- 目标平台(如已知)
- 用户提到的任何参考游戏或视觉参照

**提示词**:
> "基于这些游戏支柱与核心概念,提出 2-3 个互不相同的视觉识别方向。每个方向给
> 出:(1) 一条可以指导所有视觉决策的一句话视觉规则(如 'everything must
> move'、'beauty is in the decay');(2) 情绪与氛围目标;(3) 形状语言(尖锐/
> 圆润/有机/几何的侧重);(4) 色彩哲学(色板方向、色彩在这个世界中的含义)。务
> 必具体 —— 避免泛泛而谈。其中一个方向应直接服务首要设计支柱。为每个方向命名。
> 推荐最服务所述支柱的方向并说明理由。"

**裁决**:CONCEPTS(多个有效选项 —— 由用户选择)/ STRONG(一个方向明显占优)/
CONCERNS(支柱尚不足以区分视觉识别方向)

---

### AD-ART-BIBLE —— 美术圣经签核

**触发条件**:美术圣经(Art Bible)起草完成后(`/art-bible`)、资产生产开始前

**待传入上下文**:
- 美术圣经路径(`design/art/art-bible.md`)
- 游戏支柱与核心幻想
- 平台与性能约束(如已配置,来自 `.claude/docs/technical-preferences.md`)
- brainstorm 期间选定的视觉识别锚点(来自 `design/gdd/game-concept.md`)

**提示词**:
> "评审这份美术圣经的完整性与内部一致性。色彩系统是否符合情绪目标?形状语言是
> 否源于视觉识别陈述?资产标准在平台约束内是否可达成?角色设计方向是否给了美术
> 足够的依据且不过度规定?章节之间是否存在矛盾?外包团队能否仅凭本文档生产资产
> 而无需额外简报?返回 APPROVE(美术圣经可投产)、CONCERNS [需要澄清的具体章
> 节],或 REJECT [资产生产开始前必须解决的根本性不一致]。"

**裁决**:APPROVE / CONCERNS / REJECT

---

### AD-PHASE-GATE —— 阶段转换时的视觉就绪度

**触发条件**:每次 `/gate-check` 必触发 —— 与 CD-PHASE-GATE、TD-PHASE-GATE、
PR-PHASE-GATE 并行生成

**待传入上下文**:
- 目标阶段名称
- 现有全部美术/视觉产物清单(文件路径)
- 来自 `design/gdd/game-concept.md` 的视觉识别锚点(如存在)
- 美术圣经路径(如存在,`design/art/art-bible.md`)

**提示词**:
> "从视觉方向角度,评审当前项目状态对 [target phase] 的门就绪度。视觉识别是否
> 已建立并记录到本阶段所需的程度?应有的视觉产物是否就位?视觉团队能否开工,而
> 不存在会导致日后昂贵返工的视觉方向缺口?是否有视觉决策被推迟到超过其最迟负责
> 任时点?返回 READY、CONCERNS [可能导致生产返工的具体视觉方向缺口],或 NOT
> READY [本阶段要成功就必须先具备的视觉阻塞项 —— 指明缺少什么产物、为何在此阶
> 段重要]。"

**裁决**:READY / CONCERNS / NOT READY

---

## Tier 2 —— 主管门

当需要领域专家的可行性签核时,这些门由编排技能和高级技能调用。Tier 2 主管使用
Sonnet(默认)。

---

### LP-FEASIBILITY —— 首席程序员实现可行性

**触发条件**:主架构文档写完后(`/create-architecture` 第 7b 阶段),或提出新的
架构模式时

**待传入上下文**:
- 架构文档路径
- 技术需求基线摘要
- ADR 清单及状态

**提示词**:
> "评审这份架构的实现可行性。标记:(a) 任何用所述引擎与语言难以或不可能实现的
> 决策;(b) 任何缺失的接口定义 —— 否则程序员只能自行发明;(c) 任何会造成可避
> 免的技术债、或与标准 [engine] 惯用法相矛盾的模式。返回 FEASIBLE、CONCERNS
> [list],或 INFEASIBLE [使该架构按文无法实现的阻塞项]。"

**裁决**:FEASIBLE / CONCERNS / INFEASIBLE

---

### LP-CODE-REVIEW —— 首席程序员代码评审

**触发条件**:开发故事实现完成后(`/dev-story`、`/story-done`),或作为
`/code-review` 的一部分

**待传入上下文**:
- 实现文件路径
- 故事文件路径(验收标准)
- 相关 GDD 章节
- 管辖该系统的 ADR

**提示词**:
> "对照故事验收标准与管辖 ADR 评审这份实现。代码是否符合架构边界定义?是否存在
> 违反编码标准或禁用模式之处?公开 API 是否可测试且有文档?对照 GDD 规则是否有
> 正确性问题?返回 APPROVE、CONCERNS [具体问题],或 REJECT [合并前必须修改]。"

**裁决**:APPROVE / CONCERNS / REJECT

---

### QL-STORY-READY —— QA 主管故事就绪检查

**触发条件**:故事被接纳入 Sprint 之前 —— 由 `/create-stories`、
`/story-readiness` 及 `/sprint-plan` 在故事筛选时调用

**待传入上下文**:
- 故事文件路径
- 故事类型(Logic / Integration / Visual/Feel / UI / Config/Data)
- 验收标准清单(从故事原文逐字摘录)
- 该故事覆盖的 GDD 需求(TR-ID 及文本)

**提示词**:
> "在该故事进入 Sprint 之前,评审其验收标准的可测试性。所有标准是否具体到开发
> 者能毫无歧义地判断何时算完成?对 Logic 类故事:每条标准能否用自动化测试验证?
> 对 Integration 类故事:每条标准在受控测试环境中是否可观测?标记过于模糊、无法
> 据以实现的标准;标记需要完整游戏构建才能测试的标准(记为 DEFERRED,而非
> BLOCKED)。返回 ADEQUATE(标准按文可实施)、GAPS [需要细化的具体标准],或
> INADEQUATE [标准过于模糊 —— 故事必须修改后才能纳入 Sprint]。"

**裁决**:ADEQUATE / GAPS / INADEQUATE

---

### QL-TEST-COVERAGE —— QA 主管测试覆盖评审

**触发条件**:实现故事完成后、标记 Epic 完成前,或在 `/gate-check` Production
→ Polish 时

**待传入上下文**:
- 已实现故事清单及故事类型(Logic / Integration / Visual / UI / Config)
- `tests/` 中的测试文件路径
- 该系统的 GDD 验收标准

**提示词**:
> "评审这些实现故事的测试覆盖情况。所有 Logic 故事是否都有通过的单元测试?
> Integration 故事是否有集成测试或成文的试玩测试?GDD 的每条验收标准是否都映射
> 到至少一个测试?GDD Edge Cases 一节中是否还有未测试的边缘情形?返回 ADEQUATE
> (覆盖达标)、GAPS [具体缺失的测试],或 INADEQUATE [关键逻辑未测试 —— 不得推
> 进]。"

**裁决**:ADEQUATE / GAPS / INADEQUATE

---

### ND-CONSISTENCY —— 叙事总监一致性检查

**触发条件**:编剧交付物(对白、设定、物品描述)撰写完成后,或某个设计决策具有
叙事影响时

**待传入上下文**:
- 文档或内容文件路径
- 叙事圣经或基调指南路径(如存在)
- 相关世界观构建规则
- 受影响的角色或派系档案

**提示词**:
> "评审这份叙事内容的内部一致性及对既定世界规则的遵守。角色声音是否与其既定档
> 案一致?设定是否与任何既定事实矛盾?基调是否符合游戏的叙事方向?返回
> APPROVE、CONCERNS [需要修正的具体不一致],或 REJECT [破坏叙事根基的矛盾]。"

**裁决**:APPROVE / CONCERNS / REJECT

---

### AD-VISUAL —— 美术总监视觉一致性评审

**触发条件**:美术方向决策做出后、引入新资产类型时,或技术美术决策影响视觉风格
时

**待传入上下文**:
- 美术圣经路径(如存在于 `design/art/art-bible.md`)
- 被评审的具体资产类型、风格决策或视觉方向
- 参考图或风格描述
- 平台与性能约束

**提示词**:
> "评审这一视觉方向决策与既定美术风格及生产约束的一致性。是否符合美术圣经?在
> 平台性能预算内是否可达成?是否存在会带来技术风险的资产管线影响?返回
> APPROVE、CONCERNS [具体调整],或 REJECT [必须先解决的风格违规或生产风险]。"

**裁决**:APPROVE / CONCERNS / REJECT

---

## 并行门协议

当工作流需要在同一检查点引入多位总监时(最常见于 `/gate-check`),同时生成所有
代理:

```
Spawn in parallel (issue all Task calls before waiting for any result):
1. creative-director  → gate CD-PHASE-GATE
2. technical-director → gate TD-PHASE-GATE
3. producer           → gate PR-PHASE-GATE
4. art-director       → gate AD-PHASE-GATE

Collect all four verdicts, then apply escalation rules:
- Any NOT READY / REJECT → overall verdict minimum FAIL
- Any CONCERNS → overall verdict minimum CONCERNS
- All READY / APPROVE → eligible for PASS (still subject to artifact checks)
```

---

## 新增门

当新技能或工作流需要新门时:

1. 分配门 ID:`[DIRECTOR-PREFIX]-[DESCRIPTIVE-SLUG]`
   - 前缀:`CD-` `TD-` `PR-` `LP-` `QL-` `ND-` `AD-`
   - 为新代理添加新前缀:`audio-director` → `AU-`、`ux-designer` → `UX-`
2. 在相应总监章节下添加该门,包含全部五个字段:触发条件、待传入上下文、提示词、
   裁决,以及任何特殊处理说明
3. 技能中只按 ID 引用 —— 切勿把提示词文本复制进技能

---

## 各阶段门覆盖

| 阶段 | 必需门 | 可选门 |
|------|--------|--------|
| **概念(Concept)** | CD-PILLARS、AD-CONCEPT-VISUAL | TD-FEASIBILITY、PR-SCOPE |
| **系统设计(Systems Design)** | TD-SYSTEM-BOUNDARY、CD-SYSTEMS、PR-SCOPE、CD-GDD-ALIGN(每份 GDD) | ND-CONSISTENCY、AD-VISUAL |
| **技术搭建(Technical Setup)** | TD-ARCHITECTURE、TD-ADR(每份 ADR)、LP-FEASIBILITY、AD-ART-BIBLE | TD-ENGINE-RISK |
| **预制作(Pre-Production)** | PR-EPIC、QL-STORY-READY(每个故事)、PR-SPRINT、全部四个阶段门(经 gate-check) | CD-PLAYTEST |
| **制作(Production)** | LP-CODE-REVIEW(每个故事)、QL-STORY-READY、PR-SPRINT(每个 Sprint)、QL-TEST-COVERAGE(每次 Sprint 收尾) | PR-MILESTONE、AD-VISUAL |
| **打磨(Polish)** | QL-TEST-COVERAGE、CD-PLAYTEST、PR-MILESTONE | AD-VISUAL |
| **发布(Release)** | 全部四个阶段门(经 gate-check) | QL-TEST-COVERAGE |
