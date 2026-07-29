> 中文翻译 | [English](accessibility-requirements.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# 无障碍需求:[Game Title]

> **状态**:Draft | Committed | Audited | Certified
> **作者**:[ux-designer / producer]
> **最后更新**:[Date]
> **无障碍等级目标**:[Basic / Standard / Comprehensive / Exemplary]
> **平台**:[PC / Xbox / PlayStation 5 / Nintendo Switch / iOS / Android]
> **对标的外部标准**:
> - WCAG 2.1 Level [A / AA / AAA]
> - AbleGamers CVAA Guidelines
> - Xbox Accessibility Guidelines (XAG) [Yes / No / Partial]
> - PlayStation Accessibility (Sony Guidelines) [Yes / No / Partial]
> - Apple / Google Accessibility Guidelines [Yes / No / N/A — mobile only]
> **无障碍顾问**:[Name and organization, or "None engaged"]
> **关联文档**:`design/gdd/systems-index.md`、`docs/ux/interaction-pattern-library.md`

> **本文档为何存在**:逐屏的无障碍标注属于 UX 规格书。
> 本文档记录项目级无障碍承诺、覆盖所有系统的功能矩阵、测试计划,
> 以及审计历史。它由 UX 设计师(ux-designer)与制作人(producer)
> 在技术搭建阶段创建一次,随后随功能新增与审计完成持续更新。若某个功能
> 与此处的承诺冲突,以本文档为准——修改功能,而不是修改承诺,
> 除非制作人批准正式修订。
>
> **何时更新**:每次 `/gate-check` 通过后、每次无障碍审计完成后,
> 以及每当有新游戏系统加入 `systems-index.md` 时。

---

## 无障碍等级定义

> **为何要定义等级**:无障碍不是二元的。定义四个等级能给团队一套
> 共同语言,迫使团队在制作初期做出明确承诺,并防止两个方向上的范围
> 蔓延(「我们以后再加」和「我们必须全部支持」)。下面的等级定义是本项目
> 的口径——行业使用的语言相近但并不完全相同。承诺要落到带具体功能目标
> 的等级上,而不只是等级名称。

### 等级定义

| 等级 | 核心承诺 | 典型投入 |
|------|----------------|----------------|
| **Basic** | 面向玩家的关键文本在标准分辨率下可读。没有任何功能仅依赖颜色辨别。音乐、SFX 与语音各自有独立音量控制。游戏可在无光敏风险的情况下通关。 | 低——主要是设计约束 |
| **Standard** | 包含 Basic 全部内容,另加:全平台完整输入重映射(input remapping)、带说话人标识的字幕、可调文本大小、至少一种色盲模式,且不存在无法延长或切换的限时输入。 | 中——需要专门的实现工作 |
| **Comprehensive** | 包含 Standard 全部内容,另加:菜单的屏幕阅读器(screen reader)支持、单声道音频选项、难度辅助模式、HUD 元素位置调整、减少动态效果模式,以及所有玩法关键音频的视觉指示。 | 高——需要平台 API 集成和大量 UI 架构工作 |
| **Exemplary** | 包含 Comprehensive 全部内容,另加:完整字幕自定义(字体、大小、颜色、背景、位置)、高对比度模式、认知负荷辅助工具、所有纯音频提示的触觉/震动替代方案,以及外部第三方无障碍审计。 | 很高——需要专门的无障碍预算与专家咨询 |

### 本项目的承诺

**目标等级**:[Standard]

**理由**:[Write 3-5 sentences justifying the tier choice. Do not simply
state the tier — explain the reasoning. Consider: What is the game's genre and
how does it map to common accessibility barriers (e.g., fast-twitch games have
motor barriers; reading-heavy games have visual barriers)? Who is the target
player and what does the research say about disability prevalence in that group?
What are the platform requirements (Xbox requires XAG compliance for ID@Xbox)?
What is the team's capacity? What would dropping one tier cost the player base,
in concrete terms?

Example: "This is a narrative RPG with turn-based combat targeted at players
25-45. The turn-based structure eliminates the most severe motor barriers common
in action games, but the reading-heavy design creates significant visual and
cognitive barriers. Standard tier addresses all of these. Exemplary tier is not
achievable without a dedicated accessibility engineer. Xbox ID@Xbox program
requires XAG compliance for Game Pass consideration, which Standard meets.
Dropping to Basic would exclude players who rely on colorblind modes or input
remapping, estimated at 8-12% of the target audience based on AbleGamers data."]

**明确纳入范围的功能(超出等级基线)**:
- [e.g., "Full subtitle customization — elevated from Comprehensive because our
  game is dialogue-heavy and subtitles are a primary channel"]
- [e.g., "One-hand mode for controller — we have hold inputs critical to combat"]

**明确排除在范围外的功能**:
- [e.g., "Screen reader for in-game world (not menus) — requires engine work
  beyond current capacity. Documented in Known Intentional Limitations."]

---

## 视觉无障碍(Visual Accessibility)

> **为什么本节在最前**:视觉障碍影响着使用无障碍功能的玩家中最大的
> 群体。仅色觉异常就影响约 8% 的男性和 0.5% 的女性。电视观看距离下的
> 文本可读性,常常是已发售游戏中最严重的单一项无障碍失败。在实现开始
> 之前记录每一项视觉功能,因为资产锁定后再返工最小文本大小或颜色决策,
> 代价高昂。

| 功能 | 目标等级 | 范围 | 状态 | 实现备注 |
|---------|-------------|-------|--------|---------------------|
| 最小文本大小——菜单 UI | Standard | 所有菜单界面 | Not Started | 1080p 下最小 24px。4K 时按比例缩放。参考:WCAG 2.1 SC 1.4.4 要求文本可放大至 200% 且不丢失内容。 |
| 最小文本大小——字幕 | Standard | 所有配音/字幕内容 | Not Started | 1080p 下最小 32px。约束条件是 3 米外观看电视的玩家。 |
| 最小文本大小——HUD | Standard | 游戏内 HUD | Not Started | 关键信息(生命、弹药、目标)最小 20px。非关键 HUD 元素可更小。 |
| 文本对比度——背景上的 UI 文本 | Standard | 所有 UI 文本 | Not Started | 正文文本最低 4.5:1(WCAG AA)。大文本(18px+ 或 14px 粗体)3:1。用自动化对比度检查工具对最终颜色值测试。 |
| 文本对比度——字幕 | Standard | 字幕显示 | Not Started | 字幕最低 7:1(WCAG AAA)——玩家阅读速度快且无法控制背景。默认使用投影阴影或不透明背景框。 |
| 色盲模式——红色盲(Protanopia)| Standard | 所有颜色编码玩法 | Not Started | 红绿色觉异常——影响约 6% 的男性。重点关注:血条、敌人指示、地图标记。将红色信号改为橙/黄色;将绿色信号改为青绿色。 |
| 色盲模式——绿色盲(Deuteranopia)| Standard | 所有颜色编码玩法 | Not Started | 绿红色觉异常——影响约 1% 的男性。实际影响与红色盲相近。通常同一套调色板调整即可同时覆盖两者。用 Coblis 或 Colour Blindness Simulator 验证。 |
| 色盲模式——蓝色盲(Tritanopia)| Standard | 所有颜色编码玩法 | Not Started | 蓝黄色觉异常——较罕见(约 0.001%)。将蓝色 UI 元素改为紫色;将黄色改为橙色。 |
| 「颜色作为唯一指示」审计 | Basic | 所有 UI 与玩法 | Not Started | 在下表中列出颜色作为唯一区分手段的每一处。发售前每处都必须有非颜色备份(图标、形状、图案、文本标签)。 |
| UI 缩放 | Standard | 所有 UI 元素 | Not Started | 范围:75% 至 150%。默认:100%。缩放不得破坏布局——在最小与最大值下测试所有界面。HUD 缩放应独立于菜单缩放。 |
| 高对比度模式 | Comprehensive | 菜单(最低要求);HUD(优先)| Not Started | 将所有半透明背景替换为完全不透明。将中间调 UI 颜色替换为黑/白/系统高对比度颜色。所有可交互元素描边。 |
| 亮度/伽马控制 | Basic | 全局 | Not Started | 在画面设置中提供。包含一张参考校准图(校准正确时刚好隐约可见的渐变或符号)。范围:相对默认值 -50% 至 +50%。 |
| 屏幕闪光/频闪警告 | Basic | 所有过场动画、VFX | Not Started | (1)启动前警告界面,含光敏性癫痫提示。(2)按 Harding FPA 标准审计所有强闪光 VFX(亮度阈值以上每秒不超过 3 次闪光)。(3)可选:闪光减弱模式,将闪光幅度降低 80%。 |
| 动态/动画减弱模式 | Standard | 所有 UI 过渡、镜头抖动、VFX | Not Started | 减少或消除:屏幕震动、镜头摇晃、动态模糊、菜单视差滚动、循环背景动画。无法完全消除:玩家移动动画(会破坏可读性)。在无障碍设置中开关。 |
| 字幕——开/关 | Basic | 所有配音内容 | Not Started | 默认:关(行业惯例——许多玩家偏好沉浸感)。首次启动时显著提供。 |
| 字幕——说话人标识 | Standard | 所有配音内容 | Not Started | 对话行前显示说话人姓名。仅当颜色差异不只依赖色相时,才按说话人做颜色编码(需测试色盲兼容性)。 |
| 字幕——样式自定义 | Comprehensive | 字幕显示 | Not Started | 字号(至少 4 档)、背景不透明度(0–100%)、文本颜色(白/黄/自定义)、位置(底部/顶部/相对玩家)。 |
| 字幕——音效说明文字 | Comprehensive | 玩法关键 SFX | Not Started | 哪些 SFX 需要,见「听觉无障碍」一节。格式:方括号内的 [SOUND DESCRIPTION],与对话区分。 |

### 「颜色作为唯一指示」审计

> 填入当前颜色作为唯一区分手段的每个玩法或 UI 元素。发售前逐项解决。
> 已解决的条目须在上述三种色盲模式下都有可用的非颜色备份。

| 位置 | 颜色信号 | 传达的信息 | 非颜色备份 | 状态 |
|----------|-------------|---------------------|-----------------|--------|
| [Health bar] | [Red = low health] | [Player is near death] | [Bar also shows numeric value and flashes] | [Not Started] |
| [Minimap markers] | [Red = enemy, green = ally] | [Unit allegiance] | [Enemy markers are triangles; ally markers are circles] | [Not Started] |
| [Inventory item rarity] | [Color-coded border (grey/blue/purple/gold)] | [Item quality tier] | [Rarity name shown on hover/focus; icon star count] | [Not Started] |
| [Add row for each color-coded element] | | | | |

---

## 肢体操作无障碍(Motor Accessibility)

> **为什么肢体操作无障碍对游戏重要**:游戏比大多数软件更考验操作能力。
> 网页表单只需要精确点击;游戏可能要求快速同时按下多个按键并保持特定
> 时长。运动障碍涵盖范围很广——从震颤(影响精度)到偏瘫(只有一只手
> 可用)再到 RSI(影响长按时长)。AbleGamers 的 Able Assistance 项目
> 估计,美国有 3500 万玩家存在影响游戏能力的残障。以下许多功能如果从
> 一开始就规划,实现成本很低;而发售后补做则极其昂贵。

| 功能 | 目标等级 | 范围 | 状态 | 实现备注 |
|---------|-------------|-------|--------|---------------------|
| 完整输入重映射 | Standard | 所有玩法输入、所有平台 | Not Started | 每个默认绑定的输入都必须可重新绑定。重映射分别独立作用于键盘、鼠标、手柄及任何支持的外设。不允许两个动作同时绑定到同一输入(冲突时警告)。重映射持久化到玩家档案。 |
| 输入方式切换 | Standard | PC | Not Started | 玩家必须能随时在键鼠与手柄之间切换,无需重启。UI 必须动态更新提示(按当前输入方式显示正确的按键图标)。 |
| 单手模式 | [Tier] | [Identify which features require two simultaneous hands] | Not Started | 审计每个多输入动作。逐项确认:能否单手完成?若不能,提供开关式替代或长按转开关版本。在此注明哪些功能有单手路径、哪些没有。 |
| 长按转点按替代 | Standard | 所有长按输入 | Not Started | 每个「按住 [button] 以 [action]」都必须提供开关式替代。开关模式:第一次按下激活,第二次按下取消。示例:「按住冲刺」变为可选的「切换冲刺」模式。在此列出游戏中的所有长按输入。 |
| 快速连打替代 | Standard | 任何连打/快速输入序列 | Not Started | 任何需要持续每秒超过 3 次按下的输入,都必须提供单次按下的开关式替代。示例:《Hades》的「按住以连续冲刺」优雅地解决了这个问题。 |
| 输入时机调整 | Standard | QTE、限时按键、节奏输入 | Not Started | 在无障碍设置中提供时机窗口倍率。最小范围:0.5x 至 3.0x。默认:1.0x。3.0x 时,500ms 的窗口变为 1500ms。记录本游戏中的每个限时输入,并在所有倍率取值下测试。 |
| 瞄准辅助 | Standard | 所有远程战斗/瞄准 | Not Started | 不只是开/关——要提供细粒度:辅助强度(0–100%)、辅助半径、瞄准磁吸(吸附到目标)、瞄准减速(接近目标时减速),各自独立滑条。默认值应调到「有帮助但不打扰」的手感。 |
| 自动冲刺/移动辅助 | Standard | 移动系统 | Not Started | 「按住冲刺」开关(上文已覆盖)。另外:自动奔跑选项(推住方向后,玩家无需持续输入即可继续移动)。注明正常玩法中任何需要持续按住的移动输入。 |
| 平台跳跃/跑酷辅助 | [Tier] | [If game has platforming] | Not Started | 评估自动抓握(宽松的平台边缘检测)、土狼时间(coyote time)延长和跳跃高度调整是否适合本游戏的设计。若平台跳跃不是游戏系统,标记 N/A。 |
| HUD 元素位置调整 | Comprehensive | 所有 HUD 元素 | Not Started | 允许玩家将血条、小地图和任务追踪器移动到其偏好的屏幕位置。对使用头部追踪或眼动硬件、周边视野覆盖可能受限的玩家尤其重要。 |

---

## 认知无障碍(Cognitive Accessibility)

> **为什么认知无障碍常常规格不足**:认知无障碍影响着 ADHD、阅读障碍、
> 自闭症谱系、获得性脑损伤和焦虑障碍的玩家——合计人数比许多工作室
> 意识到的要多。它也能让所有玩家在高压时刻受益。最常见的失败是:
> 无法随时暂停、只能看一次的教学信息,以及要求同时追踪过多状态的系统。
> 《Hades》和《Celeste》已经证明,认知辅助选项(无敌模式、持续提醒、
> 延长文本显示)不会损害不使用这些选项的玩家的体验。

| 功能 | 目标等级 | 范围 | 状态 | 实现备注 |
|---------|-------------|-------|--------|---------------------|
| 难度选项 | Standard | 所有玩法难度参数 | Not Started | 尽可能提供独立的细粒度滑条(造成伤害、承受伤害、敌人攻击性、敌人速度),而不是单一的简单/普通/困难标签。记录哪些参数可调、哪些固定。固定参数需要设计理由。 |
| 随时暂停 | Basic | 所有玩法状态 | Not Started | 玩家必须能在任何玩法状态下暂停,包括过场动画、对话和教学序列。记录当前禁止暂停的任何状态,以及该限制的设计理由。任何限制都是风险。 |
| 教学信息可回看 | Standard | 所有教学与帮助文本 | Not Started | 关闭教学提示后,玩家必须能从菜单的帮助区重新查看。不要指望玩家第一次见面就吸收教学内容——AbleGamers 的研究表明,许多玩家会条件反射地关掉提示。 |
| 任务/目标清晰度 | Standard | 任务与目标系统 | Not Started | 玩法过程中,当前激活目标必须能在 2 次按键内查看。按需显示完整目标文本,而不只是截断的标记。避免需要推断的目标(「调查北部区域」——具体是哪里?)。 |
| 纯音频信息的视觉指示 | Standard | 所有携带玩法信息的 SFX | Not Started | 审计每个传达玩法关键状态的音效。逐项确认:是否有视觉等价物?方向性音频(屏幕外敌人)需要屏幕边缘指示。关键警告(Boss 阶段转换、陷阱触发)需要视觉提示。完整清单见「听觉无障碍」。 |
| UI 阅读时间 | Standard | 所有自动消失的对话框 | Not Started | 任何包含可操作信息的对话框、通知或工具提示,不得在 5 秒内自动消失。推荐:完全不自动消失——要求玩家确认。在此记录每个自动消失的元素及其当前时长。 |
| 认知负荷文档 | Comprehensive | 按游戏系统 | Not Started | 对 systems-index.md 中的每个系统,记录它要求玩家同时追踪的最大事项数。标记任何超过 4 的系统。这不是硬性规则,而是评审触发器——高认知负荷系统需要补偿性的 UI 清晰度。见下方「逐功能无障碍矩阵」。 |
| 导航辅助 | Standard | 世界导航 | Not Started | 快速旅行(前往已访问地点)、当前目标的路径点系统、可选的常显目标指示。记录哪些适用于本游戏的设计、哪些是有意省略。 |

---

## 听觉无障碍(Auditory Accessibility)

> **为什么听觉无障碍对没有听力损失的玩家也重要**:7% 的玩家失聪或
> 听力受损。此外,很大一部分玩家经常在音频减弱或缺失的环境中游戏
> (通勤、合住、婴儿在睡觉)。任何只通过音频传达的玩法关键信息,
> 在考虑无障碍之前就已经是设计失败。指导原则:每一个会改变玩家下一步
> 该做什么的声音,都必须有视觉等价物。

| 功能 | 目标等级 | 范围 | 状态 | 实现备注 |
|---------|-------------|-------|--------|---------------------|
| 所有口语对话的字幕 | Basic | 所有配音内容 | Not Started | 100% 覆盖——没有例外。包括旁白、引擎内对话、远处听到的无线电/环境对话。对照配音节奏测试字幕同步。 |
| 玩法关键 SFX 的隐藏字幕(closed captions)| Comprehensive | 已识别的 SFX 清单(见下)| Not Started | 并非所有 SFX 都需要说明文字——只有那些传达玩家无法从视觉推断的状态的才需要。见下方 SFX 审计表。 |
| 单声道音频选项 | Comprehensive | 全局音频输出 | Not Started | 将立体声/空间音频折叠为单声道。保留声道间的音量平衡,而不是两侧都叠加到全音量。对单侧失聪的玩家必不可少。 |
| 独立音量控制 | Basic | 音乐/SFX/语音/UI 音频总线 | Not Started | 至少四个独立滑条。持久化到玩家档案。范围:0–100%,默认 80%。在主设置和暂停菜单中都提供。 |
| 方向性音频的视觉呈现 | Comprehensive | 所有屏幕外威胁与音频事件 | Not Started | 指向声源的屏幕边缘指示。不透明度随音量缩放(越近越不透明)。两种变体:威胁指示(红色)与信息指示(中性色)。示例:《The Last of Us Part II》用屏幕边缘指示表现屏幕外敌人位置。 |
| 助听器兼容模式 | Standard | 高频音频提示 | Not Started | 审计所有音频提示的频率范围。任何仅通过高频声音(4kHz 以上)传达关键信息的提示,都必须有低频或视觉等价物。助听器通常会滤掉高频。 |

### 玩法关键 SFX 审计

> 识别每一个传达玩家需要据此行动的状态的音效。表中每个条目都需要
> 一个确认的视觉备份或说明文字。

| 音效 | 传达的信息 | 视觉备份 | 是否需要说明文字 | 状态 |
|-------------|---------------------|--------------|-----------------|--------|
| [Enemy attack windup sound] | [Incoming damage — player should dodge] | [Enemy animation telegraph visible from all camera angles] | [No — visual is sufficient] | [Not Started] |
| [Trap trigger click] | [Trap is about to fire] | [Not always visible depending on camera angle] | [Yes — "[CLICK]" caption with directional indicator] | [Not Started] |
| [Low health heartbeat] | [Player health critical] | [Health bar also shows critical state visually] | [No — visual is sufficient] | [Not Started] |
| [Quest completion chime] | [Objective completed] | [Quest tracker updates visually] | [No — visual is sufficient] | [Not Started] |
| [Add each SFX that changes what the player should do] | | | | |

---

## 平台无障碍 API 集成

> **本节为何存在**:每个平台都提供原生无障碍 API;使用它们后,
> 操作系统级功能(系统屏幕阅读器、显示辅助、操作无障碍服务)才能与
> 你的游戏协同工作。忽略这些 API 不会让游戏坏掉,但意味着依赖系统级
> 无障碍工具的玩家在你的游戏中得不到任何帮助。Xbox 尤其要求 XAG 合规
> 才能通过认证。在承诺某个等级之前先核实平台要求——平台要求是下限,
> 不是上限。

| 平台 | API / 标准 | 计划功能 | 状态 | 备注 |
|----------|---------------|-----------------|--------|-------|
| Xbox (GDK) | Xbox Game Core Accessibility / XAG | [Input remapping via Xbox Ease of Access, high contrast support, narrator integration for menus] | Not Started | ID@Xbox Game Pass 评估要求 XAG 合规。XAG 检查清单见 https://docs.microsoft.com/gaming/accessibility/guidelines |
| PlayStation 5 | Sony Accessibility Guidelines / AccessibilityNode API | [Screen reader passthrough for menus, mono audio, high contrast] | Not Started | 若游戏在 UI 元素上暴露 AccessibilityNode 数据,PS5 原生支持系统级音频描述与单声道音频。 |
| Steam (PC) | Steam Accessibility Features / SDL | [Controller input remapping via Steam Input, subtitle support] | Not Started | Steam Input 允许独立于游戏内重映射的系统级重映射。键鼠仍需游戏内重映射。 |
| iOS | UIAccessibility / VoiceOver | [VoiceOver support for menus if mobile port planned] | N/A | 仅在移动版在范围内时需要。 |
| Android | AccessibilityService / TalkBack | [TalkBack support for menus if mobile port planned] | N/A | 仅在移动版在范围内时需要。 |
| PC(屏幕阅读器)| JAWS / NVDA / Windows Narrator | [Menu navigation announcements] | Not Started | 要求 UI 元素通过平台 UI 层暴露无障碍名称与角色。Godot 4.5+ 的 AccessKit 集成覆盖了受支持控件类型的此项需求。对照 engine-reference/godot/ 文档核实。 |

---

## 逐功能无障碍矩阵

> **这个矩阵为何存在**:无障碍不是一份设置清单——它是每个游戏系统的
> 属性。这个矩阵创建了游戏的「无障碍影响」视图:哪些系统存在哪些障碍,
> 以及这些障碍是否已被解决。当新系统加入 systems-index.md 时,必须在
> 此新增一行。若某系统存在未解决的无障碍问题,它在系统索引中不能被
> 标记为 Approved。

| 系统 | 视觉问题 | 肢体操作问题 | 认知问题 | 听觉问题 | 已解决 | 备注 |
|--------|----------------|---------------|-------------------|------------------|-----------|-------|
| [Combat System] | [Enemy health bars are color-coded; attack animations may cause motion sickness] | [Rapid input required for combos; hold inputs for guard] | [Track enemy patterns + cooldowns + player resources simultaneously] | [Audio cues for off-screen attacks; critical damage warning sounds] | [Partial] | [Colorblind palette applied; hold-to-block toggle needed] |
| [Inventory / Equipment] | [Item rarity conveyed by border color] | [No motor concerns — turn-based] | [Item stats comparison requires reading multiple values] | [None — no critical audio in this system] | [Partial] | [Non-color rarity indicators in progress] |
| [Dialogue System] | [Subtitle display depends on contrast settings] | [No motor concerns] | [Long dialogue trees with time pressure on dialogue choices] | [All dialogue must be subtitled] | [Not Started] | [Timed dialogue choices must support extended timer option] |
| [Navigation / World Map] | [Map marker colors] | [No motor concerns] | [Quest objective clarity; waypoint visibility] | [Audio pings for objectives have no visual equivalent] | [Not Started] | |
| [Add system from systems-index.md] | | | | | | |

---

## 无障碍测试计划

> **为什么无障碍测试要独立于 QA**:标准 QA 测试功能是否工作。无障碍
> 测试测试功能对使用它们的玩家是否工作。这是不同的测试。字幕系统可以
> 通过 QA(它能显示文本)却不通过无障碍测试(低视力玩家在电视距离下
> 读不清)。规划三类测试:自动化(对比度、文本大小)、内部人工(团队
> 成员用无障碍模拟器模拟障碍),以及用户测试(真正使用这些功能的玩家)。

| 功能 | 测试方法 | 测试用例 | 通过标准 | 负责人 | 状态 |
|---------|------------|------------|--------------|-------------|--------|
| 文本对比度 | 自动化——对所有 UI 截图运行对比度分析工具 | 所有游戏状态下的所有文本/背景组合 | 所有正文文本 ≥ 4.5:1;所有大文本 ≥ 3:1;字幕背景 ≥ 7:1 | ux-designer | Not Started |
| 色盲模式 | 人工——启用各模式后用 Coblis 模拟器检查所有游戏截图 | 每种模式下探索、战斗、物品栏的玩法截图 | 任何模式下都不丢失关键信息;玩家无需颜色辨别即可完成所有目标 | ux-designer | Not Started |
| 输入重映射 | 人工——将所有输入重绑到非默认键位,完成教学与第一关 | 所有默认输入均已重绑;玩法功能正常;不可能产生绑定冲突 | 重映射后所有动作可用;冲突预防生效;绑定在重启后保留 | qa-tester | Not Started |
| 字幕准确性 | 人工——对照配音剧本核对,检查所有台词 | 所有配音内容;字幕时机;说话人标识 | 100% 配音台词有字幕;所有多角色场景均标识说话人;台词结束后字幕停留不超过 3 秒 | qa-tester | Not Started |
| 长按输入开关 | 人工——启用所有开关式替代,完成所有战斗与跑酷序列 | 所有长按输入的开关模式 | 所有长按动作均可在开关模式下完成;启用开关后没有任何玩法状态要求持续按住 | qa-tester | Not Started |
| 减少动态效果模式 | 人工——启用模式,浏览所有菜单并完成第一个小时的玩法 | 所有菜单过渡;所有 HUD 动画;所有镜头抖动事件 | 菜单中无循环动画;无超过阈值的镜头抖动;所有画面过渡为淡入淡出或硬切 | ux-designer | Not Started |
| 平台屏幕阅读器(菜单)| 人工——启用系统屏幕阅读器,浏览所有菜单 | 主菜单、设置、暂停菜单、物品栏、地图 | 所有可交互菜单元素都有屏幕阅读器播报;导航顺序合乎逻辑;没有键盘/十字键无法到达的元素 | ux-designer | Not Started |
| 用户测试——色盲 | 与色盲参与者进行用户测试 | 每种色盲模式下的完整游戏流程 | 参与者无需询问颜色含义即可完成所有内容;没有导致流程中断的困惑 | producer | Not Started |
| 用户测试——运动障碍 | 与使用单手或自适应控制器的参与者进行用户测试 | 启用开关与延长时机模式的完整游戏流程 | 参与者在健全玩家完成时间的可容忍偏差内完成所有 MVP 内容 | producer | Not Started |

---

## 已知的有意限制

> **为什么要记录未纳入的内容**:未记录的遗漏会在认证或社区反馈时变成
> 「惊喜」。附上理由记录限制,说明这是深思熟虑的选择,而非疏忽。它同时
> 也标明了哪些玩家未被服务,以及缓解措施是什么。这里的每个条目都是
> 风险——诚实评估。

| 功能 | 所需等级 | 未纳入原因 | 风险/影响 | 缓解措施 |
|---------|--------------|-----------------|--------------|------------|
| [Screen reader support for in-game world (NPCs, objects, environmental text)] | Exemplary | Engine (Godot 4.6) AccessKit integration covers menus only; extending to the game world requires a custom spatial audio description system beyond current scope | Affects blind and low-vision players who can navigate menus but cannot independently explore the game world | Ensure all critical world information is duplicated in accessible menu systems (quest log, map); evaluate for post-launch DLC |
| [Full subtitle customization (font/color/background)] | Comprehensive | Scope reduction — targeting Standard tier. Custom font rendering in Godot requires additional asset pipeline work | Affects deaf and hard-of-hearing players with specific legibility needs; particularly affects players with dyslexia who use custom fonts | Provide two preset subtitle styles (default and high-readability) as a partial mitigation; log for post-launch update |
| [Tactile/haptic alternatives for all audio cues] | Exemplary | Platform rumble API integration for non-Xbox platforms is out of scope for v1.0 | Affects deaf players relying on haptic feedback; PC players with non-Xbox controllers get no haptic response | Xbox controller haptic integration is in scope; evaluate PlayStation DualSense haptic API for a post-launch patch |
| [Add any other intentionally excluded accessibility feature] | | | | |

---

## 审计历史

> **为什么要跟踪审计历史**:无障碍不是认证一次就一劳永逸。平台要求会
> 变。新功能可能引入新障碍。法律标准在演进。审计历史证明了尽职调查,
> 也有助于发现审计之间的回退。

| 日期 | 审计方 | 类型 | 范围 | 发现摘要 | 状态 |
|------|---------|------|-------|-----------------|--------|
| [Date] | [Internal — ux-designer] | Internal review | [Pre-submission checklist against committed tier] | [e.g., "12 items verified, 3 open issues: subtitle contrast below target in 2 scenes, color-only indicator on minimap not resolved"] | [In Progress] |
| [Date] | [External — AbleGamers Player Panel] | User testing | [Motor accessibility — one-hand mode and timing adjustments] | [e.g., "Toggle modes functional. Timed QTE window at 3x still failed for one participant — recommend 5x option."] | [Findings addressed] |
| [Add row for each audit] | | | | | |

---

## 外部资源

| 资源 | URL | 相关性 |
|----------|-----|-----------|
| WCAG 2.1 (Web Content Accessibility Guidelines) | https://www.w3.org/TR/WCAG21/ | 基础性无障碍标准——对比度、文本大小、输入要求 |
| Game Accessibility Guidelines | https://gameaccessibilityguidelines.com | 按类别与成本组织的全面游戏专项清单 |
| AbleGamers Player Panel | https://ablegamers.org/player-panel/ | 面向残障玩家的用户测试服务与咨询 |
| Xbox Accessibility Guidelines (XAG) | https://docs.microsoft.com/gaming/accessibility/guidelines | Xbox 认证必读;结构良好的功能检查清单 |
| PlayStation Accessibility Guidelines | https://www.playstation.com/en-us/accessibility/ | Sony 平台要求;也包含写得很好的设计指引 |
| Colour Blindness Simulator (Coblis) | https://www.color-blindness.com/coblis-color-blindness-simulator/ | 在截图上模拟色盲模式的免费工具 |
| Accessible Games Database | https://accessible.games | 无障碍游戏设计决策的研究与示例 |
| CVAA (21st Century Communications and Video Accessibility Act) | https://www.fcc.gov/consumers/guides/21st-century-communications-and-video-accessibility-act-cvaa | 美国对含通信功能(语音聊天、消息)游戏的法律要求 |

---

## 待定问题

| 问题 | 负责人 | 截止时间 | 结论 |
|----------|-------|----------|-----------|
| [Does Godot 4.6 AccessKit support dynamic accessibility node updates for HUD elements, or only static menus?] | [ux-designer] | [Before Technical Setup gate] | [Unresolved — check engine-reference/godot/ docs] |
| [What is the Xbox ID@Xbox minimum XAG compliance requirement for our release window?] | [producer] | [Before Pre-Production gate] | [Unresolved] |
| [Will the dialogue system support timed choice extensions without a full architecture change?] | [lead-programmer] | [During Technical Design] | [Unresolved] |
| [Add question] | [Owner] | [Deadline] | [Resolution] |
