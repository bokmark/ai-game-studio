> 中文翻译 | [English](interaction-pattern-library.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# 交互模式库:[Game Title]

> **Status**: Draft | Stable | Under Revision
> **Author**: [ux-designer]
> **Last Updated**: [Date]
> **Version**: [1.0]
> **Engine**: [Godot 4.6 / Unity 6 / Unreal Engine 5]
> **UI Framework**: [Godot Control nodes / Unity UI Toolkit / Unreal UMG]
> **相关文档**:
> - `design/art/art-bible.md` ——视觉标准(颜色、字体、图标)
> - `docs/accessibility-requirements.md` ——按功能划分的无障碍承诺
> - `docs/ux/ux-spec-[screen].md` ——引用这些模式的单个界面规格

> **本文档存在的意义**:每个 UI 界面规格都应该能写「使用 Button
> (Primary) 模式」,而不是从头重新规定悬停状态、按压动画、焦点行为、
> 键盘处理和屏幕阅读器播报。这个库是可复用交互行为的唯一事实来源。
> 界面规格引用模式名时,程序员来这里查完整规格。行为要变更时,在这里
> 改一次,处处生效。
>
> 这是一份活文档。模式随新界面的设计而增加——设计任何新交互前先来
> 这里查。如果需要新模式,先在这里添加(或向 ux-designer 提议),再写
> 第一个使用它的界面规格。
>
> **状态定义**:
> - **Draft**:交互已定义但尚未实现或验证
> - **Stable**:已实现、已测试,并在至少一个已交付界面中验证过
> - **Deprecated**:正在淘汰——现有用法会被迁移,新界面不要使用

---

## 如何使用本库

**如果你在设计界面**:先浏览下面的模式目录索引,再发明新交互。有
标准模式可用时,在界面规格中按名字引用(如「确认按钮使用 Button
(Primary) 模式」)。没有合适的现有模式时,提议一个新模式——在引入
它的界面规格之前或同时,把它记录在这里。

**如果你在实现界面**:当界面规格写「使用 [PatternName] 模式」时,
在本文档中找到完整规格。实现备注(Implementation Notes)章节包含
引擎专属指引。无障碍章节包含不可妥协的要求。

**如果你在评审界面规格**:验证所有可交互元素都引用了本库中的模式,
或者自带完整的交互规格。「标准按钮」或「老样子」不是有效引用。

**如果你在更新模式**:改动一个 Stable 模式会影响使用它的每一个界面。
改动前,审计所有用法(在界面规格中搜索模式名),评估影响,获得
ux-designer 批准,并在任何实现变更之前或同时更新本文档。

---

## 模式目录索引

> 每次向本文档新增模式时,在这里加一行。
> 「Used In」列是用法审计追踪——新界面采用该模式时更新它。

| Pattern Name | Category | Description | Used In (Screens) | Status |
|-------------|----------|-------------|------------------|--------|
| Button (Primary) | Input | 主要行动召唤。视觉权重最高。每屏一个。 | [Main Menu, Pause Menu, Settings] | Draft |
| Button (Secondary) | Input | 备选动作或取消。视觉权重低于 Primary。 | [All modal dialogs, settings screens] | Draft |
| Button (Destructive) | Input | 不可逆动作。执行前需要确认。 | [Delete Save, Reset Settings] | Draft |
| Toggle | Input | 二元开/关状态选择。 | [Accessibility settings, audio settings] | Draft |
| Slider | Input | 连续数值选择。 | [Volume controls, brightness, text size] | Draft |
| Dropdown / Select | Input | 从离散选项列表中选择。 | [Resolution, language, key binding] | Draft |
| List Item | Layout / Input | 垂直可滚动列表中的可选中行。 | [Achievements, quest log, settings list] | Draft |
| Grid Item | Layout / Input | 二维网格中的可选中格子。 | [Inventory, ability select, item shop] | Draft |
| Modal Dialog | Feedback / Layout | 需要玩家明确决策的阻断式覆盖层。 | [Confirmation dialogs, error prompts] | Draft |
| Confirmation Dialog | Feedback / Layout | 专门用于危险动作确认的模态框。 | [Delete Save, Leave Match, Reset] | Draft |
| Toast / Notification | Feedback | 屏幕角落的非阻断临时消息。 | [Achievement unlock, autosave notification] | Draft |
| Tooltip | Feedback | 悬停或聚焦时的上下文信息。 | [Inventory items, ability descriptions, settings] | Draft |
| Progress Bar | Feedback / Layout | 线性进度指示。 | [Loading screen, XP bar, quest progress] | Draft |
| Input Field | Input | 文本输入控件。 | [Player name, search, key binding entry] | Draft |
| Tab Bar | Navigation | 单屏内的分页区导航。 | [Character sheet, settings, crafting] | Draft |
| Scroll Container | Layout | 带可见滚动指示的可滚动内容区。 | [Inventory, lore entries, credits] | Draft |
| Inventory Slot | Game-Specific | 背包网格中的物品容器(空、已装、已装备、锁定)。 | [Inventory screen, equipment screen] | Draft |
| Ability / Skill Icon | Game-Specific | 带冷却、充能和锁定状态的技能按钮。 | [HUD ability bar, skill tree] | Draft |
| Health / Resource Bar | Game-Specific | 带阈值状态和受击闪烁的数值条。 | [HUD] | Draft |
| Minimap | Game-Specific | 带玩家标记和兴趣点的总览地图。 | [HUD] | Draft |
| Quest / Objective Tracker | Game-Specific | 带接近与完成状态的活跃目标显示。 | [HUD] | Draft |
| Dialogue Box | Game-Specific | 带说话者标识的 NPC 对话 UI。 | [All dialogue sequences] | Draft |
| Context Action Prompt | Game-Specific | 可交互物体附近的情境化「Press X to [action]」提示。 | [World interaction] | Draft |
| Damage Number | Game-Specific | 浮动的战斗反馈数字。 | [Combat HUD] | Draft |
| Status Effect Icon | Game-Specific | 带时长的增益/减益指示。 | [HUD status bar, enemy health display] | Draft |
| Notification Banner | Game-Specific | 成就、升级、获得物品通知。 | [Global overlay] | Draft |
| Screen Push | Navigation | 带方向动画的前进导航。 | [All menu navigation] | Draft |
| Screen Pop (Back) | Navigation | 带反向动画的返回导航。 | [All menu navigation] | Draft |
| Screen Replace | Navigation | 不堆叠历史地替换当前界面。 | [Main Menu to Loading Screen] | Draft |
| Modal Open / Close | Navigation | 压暗背景界面的覆盖层。 | [All modal dialogs] | Draft |
| Tab Switch | Navigation | 同屏内容在分页间切换。 | [All tabbed screens] | Draft |
| Focus Management | Navigation | 界面打开、关闭或变化时焦点去向的规则。 | [All screens] | Draft |
| Escape / Cancel | Navigation | 跨平台、跨输入方式的统一返回行为。 | [All screens] | Draft |
| Loading State | Feedback | 界面和组件如何指示加载中。 | [All loading states] | Draft |
| Empty State | Feedback | 空列表和空网格如何呈现。 | [Empty inventory, no quests, no saves] | Draft |
| Error State | Feedback | 错误如何传达。 | [Save failed, network error, invalid input] | Draft |
| Success Confirmation | Feedback | 完成的动作如何确认。 | [Settings saved, item crafted, quest turned in] | Draft |
| Optimistic UI | Feedback | 在系统确认前先展示假定成功。 | [If online features are present] | Draft |

---

## 标准控件模式

---

#### Button (Primary)

**Category**: Input
**Status**: Draft
**何时使用**:界面上最重要的单一动作。「Start Game」「Confirm」
「Accept」「Buy」。同一时间最多可见一个 Primary 按钮。它是「玩家
在这里最想做什么?」的答案。
**何时不用**:备选或次要动作;执行后不可逆、需要确认的危险动作;
任何不是本界面主要意图的动作。

**交互规格**:

| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Default | 全不透明填充,来自美术圣经的主色。标签居中。 | — | — | — | — |
| Hovered (mouse) | 亮度 +15%,轻微缩放 1.03x,光标变为 pointer | 鼠标移入元素 | 从 Default 过渡 | 80ms ease-out | [UI hover sound——见 Sound Standards] |
| Focused (keyboard/gamepad) | 焦点环可见(2px,偏移 3px,高对比色)。亮度同 Hovered。 | Tab / 十字键导航 | 从 Default 过渡 | 80ms ease-out | [UI focus sound——同 hover] |
| Pressed | 缩放 0.97x,亮度 -10% | Click / Enter / A (Xbox) / Cross (PS) | 动作在按下松开(press-up)时触发,而非按下时。按下时缩放。 | 按压 60ms ease-in;松开 80ms ease-out | [UI confirm sound] |
| Disabled | 40% 不透明度,无 pointer 光标,无 hover 状态 | — | 无响应 | — | — |
| Loading(post-press) | 标签替换为 spinner。按钮保持按压缩放,处于禁用状态。 | — | 防止重复提交 | 异步操作持续期间 | — |

**无障碍**:
- 键盘:Tab 聚焦,Enter 或 Space 激活。必须能从界面上任何其他可
  交互元素经 Tab 序列到达。
- 手柄:十字键或左摇杆导航聚焦到按钮。A (Xbox) / Cross (PS) 激活。
  界面打开时焦点必须默认放在 Primary 按钮上。
- 屏幕阅读器:按钮必须暴露与可见标签匹配的无障碍名称。角色(role):
  "button"。禁用时状态:"dimmed"。激活播报:"[Label] button——[动作
  结果(如已知)]"。
- 色盲:不要只靠颜色区分 Primary 与 Secondary。Primary 在颜色差异
  之外使用更高的视觉权重(填充 vs 描边,或更大尺寸)。
- 最小触摸目标:44x44pt(iOS HIG)/ 48x48dp(Android)。即使 PC
  平台,只要可能支持触摸也要应用。

**实现备注**:
[Godot:扩展 `Button` 控件。自定义状态用重写 `_draw()` 实现,而不是
在状态中途修改 theme。设置 `focus_mode = FOCUS_ALL` 确保键盘可聚焦。
设置 `mouse_default_cursor_shape = CURSOR_POINTING_HAND`。缩放动画用
对按钮父级 Control 的 `scale` 属性做 Tween——直接缩放 Button 本身
可能裁剪子元素。]

---

#### Button (Secondary)

**Category**: Input
**Status**: Draft
**何时使用**:备选或取消动作。「Back」「Cancel」「Skip」「Maybe
Later」。视觉权重低于 Primary——它应该在视觉上退后,而不是争抢眼。
**何时不用**:危险动作(用 Button (Destructive))。界面上最重要的
动作(用 Button (Primary))。

**交互规格**:

| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Default | 描边样式(仅边框,透明填充),次要色。比 Primary 略小或视觉权重更低。 | — | — | — | — |
| Hovered | 背景以 15% 不透明度填充。边框变亮。缩放 1.02x。 | 鼠标移入 | 从 Default 过渡 | 80ms ease-out | [UI hover sound——比 Primary 更柔和的变体] |
| Focused | 焦点环,规格同 Primary。 | Tab / 十字键 | 从 Default 过渡 | 80ms ease-out | [UI focus sound] |
| Pressed | 缩放 0.97x,填充不透明度升到 30% | Click / Enter / B (Xbox) / Circle (PS)(聚焦状态下) | 动作在 press-up 时触发 | 60ms ease-in | [UI cancel/back sound] |
| Disabled | 40% 不透明度 | — | 无响应 | — | — |

**无障碍**:要求同 Button (Primary)。无障碍名称必须匹配可见标签。
在同时有 Primary 和 Secondary 按钮的对话框中,Secondary 按钮通常还要
映射到平台「取消」输入(B / Circle / Escape),以及直接聚焦激活。

**实现备注**:[同 Button (Primary)。Primary 与 Secondary 同时出现时,
确保 Secondary 的位置始终一致——水平布局中在 Primary 的右/下方,垂直
布局中在 Primary 下方。跨界面的一致性比单屏的审美偏好更重要。]

---

#### Button (Destructive)

**Category**: Input
**Status**: Draft
**何时使用**:任何不可逆、会导致玩家数据丢失或重大进度损失的动作:
「Delete Save File」「Reset All Settings」「Leave Match」「Discard
Changes」。视觉处理要在玩家按下之前就传递危险信号。
**何时不用**:可撤销的动作,或只是影响较大但可逆的动作。

**交互规格**:

| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Default | 描边或填充危险色(通常是低饱和度的红——在 accessibility-requirements 中确认色盲兼容性)。标签可带警告图标。 | — | — | — | — |
| Hovered / Focused | 行为同 Button (Primary) 的 hover/focus,但用危险色 | — | — | 80ms | [UI hover sound] |
| Pressed(第一次按下) | 不执行动作。改为打开 Confirmation Dialog 模式(见下)。按钮本身显示一次短脉冲动画。 | Click / Enter | 触发 Confirmation Dialog | 100ms 脉冲 | [UI warning sound——与标准 confirm 明显不同] |
| — | 实际执行由 Confirmation Dialog 处理 | — | — | — | — |
| Disabled | 40% 不透明度 | — | 无响应 | — | — |

> **关键规则**:Button (Destructive) 绝不直接执行它的动作。它永远
> 触发 Confirmation Dialog。没有例外。误按的玩家必须永远还有一次
> 反悔的机会。在危险动作上跳过确认的游戏,会招来所有 UX 失败类型中
> 最显眼的负面社区情绪。参见:任何游戏论坛上的每一个「误删存档」
> 投诉帖。

**无障碍**:屏幕阅读器必须播报其危险性质:"[Label] button——this
action cannot be undone." 除无障碍名称外,如可用,使用 `description`
属性附加警告文本。

**实现备注**:[危险按钮触发独立的 Confirmation Dialog 场景。把动作
回调传给对话框——按钮本身不持有执行逻辑。这种分离能防止确认对话框
出 bug 时的误执行。]

---

#### Toggle

**Category**: Input
**Status**: Draft
**何时使用**:两种状态都同等有效、且当前状态必须一目了然的二元开关
设置。「Subtitles: On/Off」「Aim Assist: On/Off」「Notifications:
On/Off」。
**何时不用**:两个以上选项的选择(用 Dropdown)。只发生一次、不代表
持续状态的动作(用 Button)。切换后果复杂到需要解释的情况(在旁边
放描述字段)。

**交互规格**:

| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Off / Default | 轨道:暗色填充。滑块:最左位置。标签:"Off" 或状态标签。 | — | — | — | — |
| Hovered | 轨道变亮 10%。光标:pointer。 | 鼠标移入 | 过渡 | 60ms | [UI hover sound] |
| Focused | 整个开关元素(轨道 + 滑块)周围出现焦点环。 | Tab / 十字键 | — | 60ms | [UI focus sound] |
| Pressed / Activated | 滑块滑到右侧。轨道填充变为激活色。标签变为 "On" 或激活状态标签。状态持久化。 | Click / Enter / A / Cross | 开关状态变更。触发 onChange 事件。持久化数值。 | 滑动 150ms ease-in-out | [Toggle ON sound] |
| Pressed / Deactivated | 滑块滑到左侧。轨道恢复暗色填充。 | 同上 | 开关状态变更 | 150ms ease-in-out | [Toggle OFF sound——与 ON 有细微差别] |
| Disabled | 40% 不透明度。不可交互。当前状态仍可见。 | — | 无响应 | — | — |

**无障碍**:
- 键盘/手柄:Space 或 Enter 切换。避免要求方向输入(左/右)来切换
  ——部分用户无法预判这种行为。
- 屏幕阅读器:角色:"switch"。状态:"on" 或 "off"——无障碍名称
  不应包含状态(屏幕阅读器会单独播报状态)。正确:无障碍名称
  "Subtitles",状态 "on"。错误:无障碍名称 "Subtitles On"。
- 开关的标签(不只是滑块的视觉位置)必须变化以显示当前状态,服务
  于无法可靠区分左右位置的玩家。

**实现备注**:[Godot:用自定义 Control 或 CheckButton。内置
CheckButton 提供无障碍角色但视觉是复选框样式;目标美术风格可能需要
自定义滑动开关动画。减少动态模式激活时确保跳过滑动动画——此时瞬时
切换到最终状态。]

---

#### Slider

**Category**: Input
**Status**: Draft
**何时使用**:从连续范围中取值,允许近似值,且范围与相对位置本身
有意义。音量(0–100%)、亮度、文本大小。位置的视觉表达本身就是
有用信息。
**何时不用**:精确数值输入(用 Input Field)。短离散列表的选择
(用 Dropdown)。二元状态(用 Toggle)。

**交互规格**:

| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Default | 轨道(全宽)。填充(滑块左侧,显示当前值)。滑块(可拖动手柄)。当前值标签(轨道右侧或滑块上方)。 | — | — | — | — |
| Hovered | 滑块略微放大(1.2x)。轨道变亮。 | 鼠标移入 | — | 60ms | — |
| Focused | 滑块上出现焦点环。轨道变亮。 | Tab / 十字键 | — | 60ms | [UI focus sound] |
| Dragging(mouse) | 滑块跟随光标。填充实时更新。数值标签实时更新。 | 按住滑块拖动 | 连续数值更新。持续触发 onChange。 | 实时 | [Slider adjust sound——轻微,拖动时循环] |
| 键盘/十字键调节 | 滑块移动一步(每次按键为范围的 5%,或 1 个离散单位)。 | 聚焦状态下左/右方向键或十字键左右 | 步进数值变更。每步触发 onChange。 | 瞬时 | [Slider step sound——每步一声咔哒] |
| 键盘快速调节 | 更大步长(范围的 25%)。 | 聚焦状态下 Page Up / Page Down | 大步进数值变更 | 瞬时 | [同 step sound] |
| Released | 数值锁定。onChange 触发最终值。 | 鼠标松开 | — | — | — |
| Disabled | 40% 不透明度。不可交互。数值可见。 | — | 无响应 | — | — |

**无障碍**:
- 键盘:左/右方向键小步调节。Page Up/Page Down 大步。Home/End
  跳到最小/最大值。
- 屏幕阅读器:角色:"slider"。无障碍名称:标签(如 "Music
  Volume")。每次变更播报当前值:"Music Volume, 80 percent。" 首次
  聚焦时播报最小/最大值。
- 所有滑杆必须在视觉位置旁显示数值。只依赖轨道填充位置会排除无法
  感知相对位置的玩家。

**实现备注**:[Godot `HSlider`:把 `step` 设为合适的步进。重写键盘
输入,通过 `_input()` 增加 Page Up/Down 支持。绑定 `value_changed`
信号更新显示的数值标签。减少动态模式开启时,确保数值标签更新是唯一
反馈——不要抑制它们。手柄滑杆调节时的震动反馈是不错的无障碍增强。]

---

#### Dropdown / Select

**Category**: Input
**Status**: Draft
**何时使用**:从 3-15 个离散选项中选择,且静止时只需显示当前选中值。
显示分辨率、语言、窗口模式、输入预设。关闭状态只显示当前选择。
**何时不用**:二元选择(用 Toggle)。超过约 15 个选项(用完整 List
模式或可滚动 Select)。选项间的对比与选择同样重要时(把选项可见地
展示,如水平选择器或列表)。

**交互规格**:

| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Closed / Default | 标签(左)。当前值(右)。下箭头图标(最右)。 | — | — | — | — |
| Hovered | 行背景以 10% 不透明度填充 | 鼠标移入 | — | 60ms | — |
| Focused(closed) | 整行出现焦点环。 | Tab / 十字键 | — | 60ms | [UI focus sound] |
| Opening | 下拉列表出现在下方(接近屏幕底部时在上方)。列表项可见。此前选中项高亮。焦点移入列表中的选中项。 | Click / Enter / A / Cross | 打开列表 | 100ms ease-out(展开) | [UI expand sound] |
| 列表项 hovered/focused | 列表项高亮 | 鼠标 / 十字键 | — | 60ms | [UI hover sound] |
| 列表项 selected | 列表关闭。关闭状态显示新值。触发 onChange 事件。 | 在列表项上 Click / Enter / A / Cross | 选择值,关闭列表 | 80ms ease-in(收起) | [UI confirm sound] |
| 未选择而解散 | 列表关闭。值不变。 | Escape / B / Circle / 点击外部 | 解散 | 80ms | [UI cancel sound] |
| Disabled | 40% 不透明度。不可交互。 | — | — | — | — |

**无障碍**:
- 键盘:打开状态下上/下方向键导航列表项。Enter 选择。Escape 解散。
  输入选项首字母把焦点跳到第一个匹配项。
- 屏幕阅读器:角色:"combobox"。无障碍名称:字段标签。播报展开/
  收起状态。聚焦时播报当前值。每个列表项播报其值与位置:"English,
  1 of 12。"
- 下拉列表绝不能遮住当前项或打开它的控件——这是小屏上的常见失败。

**实现备注**:[Godot:自定义实现,用一个 `Button`(关闭状态)加一个
`PopupMenu` 或由动画展开的 `VBoxContainer`。原生 `OptionButton` 提供
无障碍支持但视觉定制有限。确保弹窗在会被屏幕底部裁剪时自动转到控件
上方。在 `_input` 检测到点击其矩形区域外时关闭弹窗。]

---

#### List Item

**Category**: Layout / Input
**Status**: Draft
**何时使用**:垂直可滚动列表中的单个可选中行。成就、任务日志条目、
设置分类、存档槽位。列表是容器;本模式是其中的行。
**何时不用**:二维网格布局(用 Grid Item)。不可选中的内容行(移除
hover/focus 状态与 pressed 状态)。

**交互规格**:

| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Default | 全宽行。图标(可选,左)。主标签。次级标签/元数据(右侧或主标签下方)。箭头(右,若可深入导航)。 | — | — | — | — |
| Hovered | 行背景 12% 不透明度的高亮。 | 鼠标移入 | — | 60ms | — |
| Focused | 行上的焦点环,或行背景 20% 不透明度(与平台惯例一致)。 | 十字键 / Tab | — | 60ms | [UI focus sound] |
| Selected(持久) | 行背景 25% 不透明度。可显示选中指示(左边框、对勾)。与 focused 状态不同——一行可以选中但未聚焦。 | — | 渲染状态 | — | — |
| Pressed / Activated | 短暂亮度闪烁,然后导航或执行动作 | Click / Enter / A / Cross | 导航或动作 | 80ms 闪烁 | [UI confirm sound] |
| Disabled | 40% 不透明度。不可交互。 | — | — | — | — |

**无障碍**:
- 键盘/手柄:上/下方向键或十字键在列表项间移动。列表必须处理焦点
  循环——到达底部应停止(不回绕),除非明确设计了回绕。
- 屏幕阅读器:角色:"listitem"。父列表角色:"list"。无障碍名称:
  主标签内容。元数据(次级标签)可选地包含在描述中。播报位置:
  "Quest Log, 3 of 12。"
- 最小行高:触摸 44pt / 48dp。手柄为主的平台,56px 行高更舒适。

**实现备注**:[Godot:`ScrollContainer` 内用 `VBoxContainer`。每行
是自定义 `Control` 或 `PanelContainer`,重写 `_gui_input`。滚动容器
内的键盘导航要实现自定义焦点遍历——Godot 默认的 Tab 导航不会滚动
容器来保持聚焦项可见。对滚动容器使用 `ensure_control_visible()`。]

---

#### Grid Item

**Category**: Layout / Input
**Status**: Draft
**何时使用**:二维网格中的可选中格子。背包槽位、技能选择、合成材料
选择、角色头像选择。网格是容器;本模式是格子。
**何时不用**:单列内容(用 List Item)。不可选中的展示格(移除交互
状态)。

**交互规格**:

| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Empty | 空槽视觉(细微边框或虚线描边)。与 disabled 不同。 | — | — | — | — |
| Populated | 物品图标填满格子。堆叠数量(右下,如适用)。品质指示(边框颜色或图标叠加)。 | — | — | — | — |
| Hovered | 亮度 +15%。400ms 延迟后出现 tooltip。 | 鼠标移入 | — | 60ms | — |
| Focused | 焦点环(2px,偏移 2px)。亮度同 hovered。400ms 延迟后出现 tooltip,手柄上立即出现。 | 十字键导航 | — | 60ms | [UI focus sound] |
| Selected(持久) | 明显边框(更粗、对比色)。可显示选对勾。 | Click / Enter / A / Cross | 选中物品。可与另一格子上的 focused 状态共存。 | 瞬时 | [UI select sound] |
| Pressed | 短暂缩放 0.95x,然后执行动作 | 双击 / Enter / A / Cross | 动作(装备、使用、查看——由上下文定义) | 80ms | [UI confirm sound] |
| Locked | 已装内容上叠加挂锁图标。无 hover/focus 状态。 | — | 不可交互 | — | — |
| Drag source | 格子变暗(50% 不透明度),拖拽预览出现在光标处。 | 按住拖动(仅鼠标) | 开始拖拽操作 | 瞬时 | [UI grab sound] |
| Drop target(有效) | 格子变亮,接受色指示 | 物品拖过 | — | 60ms | — |
| Drop target(无效) | 红色染色或抖动动画 | 物品拖过无效槽位 | — | 60ms | [UI error sound] |

**无障碍**:
- 键盘/手柄:十字键或方向键在格子间导航。网格必须向屏幕阅读器传达
  其维度。播报行/列位置。
- 屏幕阅读器:角色:"gridcell"。父角色:"grid"。无障碍名称:物品
  名(空格子为 "empty slot")。状态:选中时 "selected",锁定时
  "dimmed"。位置:"row 2, column 3。"
- Tooltip 必须键盘可达——必须在格子聚焦时出现,而不只是悬停时。

**实现备注**:[Godot:固定列数的 `GridContainer`。每个格子是自定义
`Control`。通过重写 `_gui_input` 并根据索引与列数计算左/右/上/下
的格子来实现自定义十字键导航。`GridContainer` 不原生提供这个功能。]

---

#### Modal Dialog

**Category**: Feedback / Layout
**Status**: Draft
**何时使用**:玩家继续之前必须解决的决策或确认。对话框是阻断式的
 ——背景内容被压暗且不可交互。「Are you sure?」「Your progress
will be saved.」、错误状态。
**何时不用**:非阻断通知(用 Toast / Notification)。可以等玩家方便
时再看的信息(放进持久帮助系统)。应该允许玩家在其后继续游玩的
对话框。

**交互规格**:

| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Opening | 背景覆盖层从 0 动画到 60% 不透明度。对话框面板从 0.9 缩放到 1.0。对话框从中心进入(不从边缘)。 | 由代码触发 | 焦点移到对话框内第一个可交互元素(或 Primary 按钮) | 200ms ease-out | [UI modal open sound] |
| Active | 背景不可交互。对话框持有全部输入焦点。玩家无法与背景交互。 | 键盘/手柄只在对话框内导航 | — | — | — |
| Dismissing(confirmed) | 对话框面板缩放到 1.1 然后淡出。覆盖层淡到 0%。 | 按下 Primary 按钮 | 执行动作,焦点回到触发元素 | 180ms | [UI confirm sound] |
| Dismissing(cancelled) | 对话框面板缩放到 0.9 然后淡出。覆盖层淡到 0%。 | Secondary 按钮 / Escape / B / Circle | 无动作,焦点回到触发元素 | 150ms | [UI cancel sound] |
| 不可解散 | 如果对话框代表阻断性错误,不提供取消路径。只提供解决方案选项。 | — | — | — | — |

> **焦点陷阱规则**:模态对话框打开期间,Tab 与十字键导航必须只在
> 对话框的可交互元素内循环。绝不能把焦点导航到对话框外的背景内容。
> 这既是无障碍要求(WCAG 2.1 SC 2.1.2),也是 UX 完整性要求。对话框
> 关闭时,焦点必须回到触发它的元素,而不是页面顶部。

**无障碍**:
- 屏幕阅读器:对话框容器角色:"dialog"。无障碍名称:对话框标题
  (必需——每个对话框都必须有标题,即使视觉上隐藏)。打开时,屏幕
  阅读器播报对话框标题与第一个可聚焦元素。焦点陷阱激活。
- 键盘:Escape 永远映射到取消/解散动作(同 Secondary 按钮或关闭
  按钮)。Enter 永远映射到主要/确认动作。
- 减少动态:缩放动画替换为瞬时出现/消失。覆盖层淡入保留但加速到
  100ms。

**实现备注**:[Godot:用高 layer 值(100+)的 `CanvasLayer` 实现,
确保渲染在所有游戏内容之上。背景覆盖层是全屏 `ColorRect`,60% 黑色
不透明度。打开动画完成后对对话框的 primary 按钮调用 `grab_focus()`。
重写 `_input()` 实现焦点陷阱——拦截 Tab 导航并重路由到对话框的
可聚焦元素。]

---

#### Confirmation Dialog

**Category**: Feedback / Layout
**Status**: Draft
**何时使用**:确认危险动作的特定场景。永远由 Button (Destructive)
触发。永远恰好有两个选项:确认(用具体动作命名,不是 "OK")和取消。
**何时不用**:非危险的确认。不需要决策的错误或通知。任何有两个以上
动作的对话框。

> **标签规则**:确认按钮必须用具体动作命名,不能用泛泛的 "OK" 或
> "Yes"。用 "Delete Save File" 而不是 "OK"。用 "Leave Match" 而不是
> "Yes"。这能减少阅读对话框内容有困难的玩家的误操作。该模式源自
> Apple HIG,并经数十年可用性研究验证。

**结构**:
- 标题:简短、描述动作。用 "Delete save file?" 而不是 "Are you sure?"
- 正文:一句话说明后果。"This cannot be undone."
- 确认按钮:Button (Primary)——用具体动作命名。"Delete Save File."
- 取消按钮:Button (Secondary)——"Cancel."
- 默认焦点:Cancel(更安全的默认——减少误触危险动作)。

**无障碍**:继承 Modal Dialog 的全部无障碍要求。另外:屏幕阅读器
播报 "Alert dialog, [title]" 以提示危险上下文。默认焦点在 Cancel
是硬性要求,不是偏好。

**实现备注**:[Confirmation Dialog 是 Modal Dialog 的特定实例——
用子类或参数化场景实现。默认焦点在 Cancel 至关重要:打开动画完成后
对 Cancel 按钮而不是 Confirm 按钮调用 `grab_focus()`。]

---

#### Toast / Notification

**Category**: Feedback
**Status**: Draft
**何时使用**:不需要玩家决策的简短非阻断信息。「Game saved.」
「Achievement unlocked.」「Your inventory is full.」玩家可以继续玩;
通知会自己消失。
**何时不用**:需要决策的信息(用 Modal Dialog)。需要玩家采取行动的
错误。玩家绝不能错过的关键信息。

**交互规格**:

| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Entering | 从屏幕边缘滑入(通常右下,远离主要操作区)。不透明度从 0 淡到 100%。 | 由代码触发 | — | 200ms ease-out | [与通知类型匹配的声音——见 Sound Standards] |
| Displayed | 全不透明。可选:图标(左)、标题、正文(可选)、关闭按钮(X,可选)。 | 指针悬停暂停自动消失计时 | 暂停自动消失 | — | — |
| Auto-dismiss | 不透明度从 100 淡到 0%,滑出 | 计时到期(单行默认 5 秒;两行 8 秒) | 从队列移除 | 200ms ease-in | — |
| Manual dismiss | 立即淡出并滑出 | 点击/触摸 X 按钮,或触摸平台上滑动 | 移除 | 150ms | [UI cancel sound,安静] |
| Queue overflow | 新通知把最旧的提前挤出 | 上一条仍在显示时触发新通知 | FIFO 队列,同时最多 3 条 | — | — |

**无障碍**:
- 屏幕阅读器:toast 必须在不需要聚焦的情况下被读出。在 HTML 中用
  `role="status"` 或 `role="alert"`。在游戏 UI 中,这需要引擎的
  无障碍通知系统。在 engine-reference 文档中确认引擎支持。
- 减少动态:滑动动画替换为仅淡入淡出。
- toast 绝不能是玩家需要据以行动的信息的唯一传达渠道。如果信息
  需要行动,在 toast 之外还要有一个持久 UI 元素。
- 自动消失计时:5 秒是下限。认知处理有差异的玩家可能需要更多时间。
  考虑提供延长到 10 或 15 秒的设置。

**实现备注**:[Godot:在锚定屏幕角落的 `VBoxContainer` 中管理
`PanelContainer` 场景队列。每个 toast 实例化后加入容器,计时后自动
移除。容器应在高 `CanvasLayer`(50+)但低于模态对话框(100+)。
用 `Tween` 对 `modulate.a` 与 `position.x` 做动画。减少动态激活时
跳过位移动画。]

---

#### Tooltip

**Category**: Feedback
**Status**: Draft
**何时使用**:补充可见标签的上下文信息。背包中的物品描述。角色面板
上的属性解释。无障碍选项中的设置说明。玩家必须能获取这些信息,或
在没有它们的情况下继续。
**何时不用**:玩家完成动作必须阅读的信息——放进标签或正文,不要放
tooltip。tooltip 在没有悬停状态的移动触摸设备上不可发现。纯触摸平台
上,改用信息按钮打开描述模态框。

**交互规格**:

| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Hidden | — | — | — | — | — |
| Hover trigger | — | 鼠标进入元素 | 开始 400ms 延迟计时 | — | — |
| Gamepad/keyboard trigger | — | 元素获得焦点 | 开始 300ms 延迟计时(更短,因为导航是有意的) | — | — |
| Appearing | tooltip 面板淡入并从 0.95 缩放到 1.0。定位在元素附近(优先上方,接近屏幕边缘时调整)。 | 计时到期 | 显示 tooltip | 120ms ease-out | — |
| Displayed | tooltip 可见。标题(可选)。正文。最大宽度:300px。允许多行。 | — | — | — | — |
| Hiding | tooltip 淡出 | 鼠标离开元素 / 焦点移走 | 隐藏 tooltip | 80ms ease-in | — |

**无障碍**:
- 屏幕阅读器:tooltip 内容必须无需悬停即可达。父元素的无障碍名称
  应包含最关键的 tooltip 信息。完整 tooltip 文本可选地放在
  `description` 属性中。元素聚焦时屏幕阅读器读出 tooltip 内容。
- 延迟(300-400ms)防止意外触发 tooltip,是必需的——手柄导航中
  即时 tooltip 很干扰。
- tooltip 文本必须满足与正文相同的对比度要求(最低 4.5:1)。

**实现备注**:[Godot:把自定义 `TooltipControl` 场景挂为触发元素的
子节点。用 `Timer` 节点控制显隐。用 `CanvasLayer` 定位 tooltip 以确保
它出现在所有其他 UI 之上。对屏幕边缘,检测 tooltip 矩形是否超出
`get_viewport_rect()`,超出时翻转到对侧。]

---

#### Progress Bar

**Category**: Feedback / Layout
**Status**: Draft
**何时使用**:朝明确终点的线性进度。加载界面(距完成的时间)、距
下一级的 XP 进度、有可计数进度的任务目标(「3 of 10 enemies
defeated」)、下载进度。
**何时不用**:圆形或径向进度(需要时用独立的 Radial Progress 模式)。
快速上下波动的值(用 Health/Resource Bar 模式)。没有明确终点的值。

**交互规格**:

| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Default | 轨道(全宽,背景色)。填充(从左到右,数值色)。数值标签(百分比或 N/M,填充外或填充内)。 | — | — | — | — |
| Value increasing | 填充宽度动画到新值 | 数值变化 | 平滑填充动画 | 300ms ease-out | [依情境——XP 获得有音效;加载没有] |
| Value at maximum | 填充到达全宽。可选:完成动画(脉冲、发光)。 | 数值到达 100% | 触发完成事件 | 200ms | [完成音效(如合适)] |
| Value at zero | 填充隐藏(零宽度)。轨道仍可见。 | — | — | — | — |
| Indeterminate(时长未知) | 循环动画(填充段从左向右移动,重复)。用于时长未知的加载。 | — | — | 无限循环 | — |

**无障碍**:
- 屏幕阅读器:角色:"progressbar"。无障碍名称:什么在进度中(如
  "Experience Points"、"Loading")。值:当前数值 + 百分比 + 最大值。
  "Experience Points, 450 of 1000, 45 percent。" 在显著变化时更新
  (不是每像素都更新)。
- 不要只依赖填充颜色传达数值。要包含数值标签。
- 不确定进度条:播报 "Loading, in progress"——不要播报变化,因为
  值未知。
- 减少动态:不确定动画替换为静态「加载中」指示。平滑填充动画替换
  为瞬时跳到新值。

**实现备注**:[Godot:内置 `ProgressBar` 加自定义主题。不确定模式:
`ProgressBar` 在 Godot 4.x 没有原生不确定状态——用对填充元素位置的
循环 `Tween` 实现。减少动态激活时确保暂停该 Tween 并显示静态指示。]

---

#### Input Field

**Category**: Input
**Status**: Draft
**何时使用**:文本输入。新存档的玩家名、列表内搜索、重映射键位
(特殊情况——显示按下的键,而非输入的文本)、精确输入数值。
**何时不用**:从已知选项中选择(用 Dropdown 或 List)。主机为主的
平台上,尽量少用文本输入——它需要虚拟键盘,摩擦很大。

**交互规格**:

| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Default | 字段边框、占位文本(标签样式,暗色)、空输入区。 | — | — | — | — |
| Hovered | 边框略微变亮 | 鼠标移入 | — | 60ms | — |
| Focused | 边框完全变亮。光标(闪烁,530ms 亮/530ms 灭)。占位文本隐藏。 | Tab / 点击 | 主机/移动端打开虚拟键盘 | 瞬时 | [UI focus sound] |
| Typing | 字符出现。光标前进。 | 键盘输入 | 更新字段值 | 即时 | [轻微击键声,可选] |
| Value present | 字段显示已输入的值。占位符隐藏。值非空时出现清除按钮(X,字段右侧)。 | — | — | — | — |
| Character limit reached | 不再接受输入。可选:短暂抖动动画,限制指示变色。 | 达到上限时的输入 | 拒绝后续字符 | 200ms 抖动 | [UI error sound,轻微] |
| Clear | 字段清空。光标复位。清除按钮消失。 | 点击 X / 手柄清除输入 | 清空值 | 瞬时 | [UI cancel sound,轻微] |
| Validation error | 边框变为错误色(红——确保色盲安全)。字段下方出现错误信息。 | 提交时或失焦时 | 显示错误 | 瞬时 | [UI error sound] |
| Validated / correct | 边框变为成功色(绿——确保色盲安全)。成功图标可选。 | 验证通过时 | — | 瞬时 | — |
| Disabled | 40% 不透明度,不可交互。值仍可见。 | — | — | — | — |

**无障碍**:
- 键盘:所有标准文本编辑快捷键(Home、End、Ctrl+A、Ctrl+C、
  Ctrl+V、Ctrl+Z)。
- 屏幕阅读器:角色:"textbox"。无障碍名称:字段标签(不是占位
  文本)。播报当前值。达到字符上限时播报。验证错误出现时立即播报。
- 占位文本不得作为唯一标签——字段上方或旁边必须有可见标签。占位
  文本在玩家输入时消失,会让有认知或记忆障碍的玩家困惑。

**实现备注**:[Godot `LineEdit`:设置 `placeholder_text` 作为提示,
但永远包含一个可见的 `Label` 节点作为字段的无障碍名称。绑定
`text_changed` 信号做实时验证。绑定 `text_submitted` 实现 Enter 提交。
主机平台上,`LineEdit.call("_popup_keyboard")` 或使用 OS 虚拟键盘
API——Godot 4.6 主机键盘 API 细节请对照 engine-reference/godot/ 核实。]

---

#### Tab Bar

**Category**: Navigation
**Status**: Draft
**何时使用**:把单屏内容分成离散区块,一次只显示一个区块。角色面板
分页(Stats / Equipment / Skills)、设置分页(Gameplay / Graphics /
Audio / Accessibility)。最多 5-6 个分页,再多这个模式就会失效,应
考虑侧边栏导航。
**何时不用**:超过 6 个分页。受益于同时可见的内容(改用布局模式)。
不同界面间的导航(用 Screen Push)。

**交互规格**:

| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Default(inactive tab) | 分页标签。无激活指示。 | — | — | — | — |
| Active tab | 分页标签。激活指示(下划线、填充或对比背景)。内容区显示该分页内容。 | — | — | — | — |
| Hovered(inactive) | 分页背景轻微填充 | 鼠标移入 | — | 60ms | — |
| Focused(keyboard/gamepad) | 分页标签上的焦点环。 | Tab 键(分页栏内)或分页行上的十字键左右 | — | 60ms | [UI focus sound] |
| Activated | 激活指示过渡到该分页。内容区过渡(淡入或滑动)。 | Click / Enter / A / Cross | 切换激活分页。内容更新。 | 150ms ease | [UI tab switch sound] |
| 手柄肩键 | — | L1/R1 (PS) 或 LB/RB (Xbox) | 切到上/下一个分页(平台标准惯例) | 150ms | [UI tab switch sound] |

**无障碍**:
- 键盘:方向键在分页栏内左右导航分页。Tab 键把焦点移入下方内容区。
  这遵循 ARIA tab panel 模式。
- 屏幕阅读器:单个分页角色:"tab"。容器角色:"tablist"。内容区
  角色:"tabpanel"。激活分页状态:"selected"。无障碍名称:分页标签。
  tabpanel 由其对应分页标注。
- 激活分页必须在颜色之外还可区分(下划线、填充图案或字重变化)。

**实现备注**:[Godot:内置 `TabContainer`。需要自定义视觉样式时,
用一个分页按钮的 `HBoxContainer` 加内容用的 `MarginContainer` 手动
实现。肩键快捷方式(LB/RB)必须在界面的 `_input()` 重写中实现——
Godot 分页系统不内置。注意平台惯例:Xbox 用 LB/RB;PlayStation 用
L1/R1;两者是同一物理按键,一个绑定即可通用。]

---

#### Scroll Container

**Category**: Layout
**Status**: Draft
**何时使用**:内容超出容器可见区域。背包列表、lore 条目文本、制作
名单、长设置列表。滚动指示告诉玩家还有更多内容。
**何时不用**:可以改为分页的内容(对密集列表导航,分页可能更清晰)。
无限滚动(永远要提供加载状态与结束状态)。

**交互规格**:

| State | Visual | Input | Response | Duration | Audio |
|-------|--------|-------|----------|----------|-------|
| Content fits | 滚动条不可见(或按美术方向始终可见的全高滚动条)。 | — | — | — | — |
| Scrollable | 滚动条出现(右边缘)。滚动条滑块大小代表视口与内容之比。 | — | — | — | — |
| Scrolling(mouse) | 内容移动。滚动条滑块成比例移动。 | 鼠标滚轮 | 每滚一格滚 3 行(可在 OS 配置) | 平滑 | — |
| Scrollbar drag | 内容移动。滑块跟随指针。 | 按住拖动滚动条滑块 | 成比例滚动 | 实时 | — |
| Keyboard scroll | 每次按键内容移动一个条目高度。 | 容器聚焦且无子元素聚焦时的上/下方向键 | 滚动一个单位 | 即时 | — |
| Gamepad scroll | 内容移动以保持聚焦条目可见。 | 十字键导航到可见区域外的条目 | 自动滚动保持聚焦项可见 | 平滑 150ms | — |
| Scroll top / bottom | 内容停止。滚动条滑块到头。 | 到达内容边界 | 停止滚动 | — | — |
| Focus follows scroll | 子元素获得焦点时,滚动容器确保它完全可见。 | 任意子元素获得焦点 | 滚动以露出聚焦元素 | 200ms ease | — |

**无障碍**:
- 键盘/手柄:滚动容器本身不应要求显式的滚动条交互——在其中导航
  列表项时应自动滚动以保持聚焦项可见。
- 屏幕阅读器:滚动容器播报 "scrollable" 及滚动位置("showing items
  5 through 15 of 30")。这需要引擎无障碍支持——在
  engine-reference/godot/ 中核实。
- 边缘渐隐(内容在滚动边界渐隐以暗示还有更多内容)是有用的视觉
  示能,但不得作为表明可见区域外还有内容的唯一指示。要包含滚动条。

**实现备注**:[Godot `ScrollContainer`:容器内 `gui_focus_changed`
触发时,对聚焦子元素调用 `ensure_control_visible()`。通过对容器
`gui_focus_changed` 信号的递归 `connect` 来绑定。平滑滚动动画用对
`scroll_vertical` 的 `Tween`,而不是直接赋值。]

---

## 游戏专属 UI 模式

---

#### Inventory Slot

**Category**: Game-Specific
**Status**: Draft
**何时使用**:背包网格中的每个物品容器。空槽、已装槽、已装备槽、
锁定槽。槽位是框;物品图标是内容。

**状态**:

| State | Visual | Notes |
|-------|--------|-------|
| Empty | 细微槽位边框,无内容。与 disabled 不同。空槽是可交互的(接收物品)。 | 避免完全不可见的空槽——玩家会失去对网格维度的感知 |
| Populated | 物品图标填充槽位面积 80%。堆叠数量在右下(如适用)。品质边框(色盲安全——图标 + 颜色)。已装备徽章(右上,若已装备)。 | |
| Focused | 焦点环。300ms 后出现 tooltip。 | |
| Selected | 更粗或对比色边框。支持多选时使用。 | |
| Drag source | 槽位变暗,拖拽虚影跟随指针。 | 完整拖拽规格见 Grid Item |
| Locked | 挂锁图标叠加。不可交互。锁后物品可以 50% 不透明度显示。 | 用于锁定的配装槽位、DLC 内容等 |
| Highlighted | 动画边框发光(脉冲)。用于任务相关物品或新获得物品。 | 尊重减少动态——用静态徽章替代脉冲 |
| Cooldown overlay | 从 12 点方向开始的径向填充叠加,随冷却结束顺时针消减。 | 仅当槽位代表有冷却的主动物品时适用 |

**无障碍**:堆叠数量与品质等级必须有颜色编码之外的文本或图标替代。
tooltip 是主要的无障碍机制——确保键盘与屏幕阅读器可达。锁定槽位必须
向屏幕阅读器播报 "locked"。

**实现备注**:[Godot:自定义 `Control` 节点。品质边框用按稀有度切换的
`StyleBoxFlat` 实现——避免用 `modulate` 颜色表示品质,因为它会影响
图标颜色。拖放通过 `get_drag_data()` 与 `can_drop_data()` / `drop_data()`
重写方法实现。]

---

#### Ability / Skill Icon

**Category**: Game-Specific
**Status**: Draft
**何时使用**:HUD 技能栏中的技能按钮、技能树节点,以及任何需要显示
技能可用状态的场合。

**状态**:

| State | Visual | Notes |
|-------|--------|-------|
| Available | 全不透明图标。键位标签在下方。 | |
| On cooldown | 径向叠加从 12 点方向顺时针消减。剩余时间 > 2 秒时在中心显示数字。 | |
| Charges remaining | 图标下方的充能点指示(如 3 个实心圆 = 3 次充能)。为屏幕阅读器提供数字替代。 | |
| Out of resource | 图标去饱和至约 20%。边框变暗。键位标签变暗。与冷却不同——这是资源门控,不是时间门控。 | |
| Locked / not unlocked | 仅图标剪影(不见完整美术)。挂锁徽章。可在 tooltip 中显示解锁条件。 | |
| Active / channeling | 脉冲边框。径向填充显示剩余引导时间。 | |
| Just activated | 短暂缩放 0.9x 然后弹到 1.0x(过冲到 1.05x)。 | 示例:Guild Wars 2 与 Path of Exile 都在技能使用时做按下回弹动画来确认激活。尊重减少动态。 |

**无障碍**:所有冷却/充能信息必须有数值(屏幕阅读器无法解析径向
叠加)。冷却计时数字满足此要求。技能名称与描述必须通过 tooltip 暴露
给屏幕阅读器。

**实现备注**:[Godot:自定义 `TextureButton` 子类,冷却径向与充能点
用叠加 `Control` 节点。冷却径向用 `ColorRect` 上旋转遮罩的自定义
shader——或如引擎支持,用圆形样式的 `ProgressBar` 实现。此模式的
Godot 4.6 shader 支持请对照 engine-reference/godot/ 核实。]

---

#### Health / Resource Bar

**Category**: Game-Specific
**Status**: Draft
**何时使用**:HUD 中任何代表关键玩家资源的连续变化数值。生命、法力、
体力、护盾、燃料。

**状态与行为**:

| Event | Visual | Audio | Duration |
|-------|--------|-------|---------|
| 数值减少(受伤) | 填充缩短。填充上的短暂「受击闪烁」(白色或红色)。残影条停留在先前数值并在 0.5s 内消减到新值(「伤害指示」)。 | [受伤音效——随伤害量变化] | 瞬时减少,500ms 残影条消减 |
| 数值增加(治疗) | 填充增长。短暂治疗色闪烁(绿——用图标/光晕备份确保色盲安全)。 | [治疗音效] | 300ms ease-in |
| 低于 25% 阈值 | 填充变为警告色。边框脉冲(减少动态模式下为静态徽章)。可选:心跳听觉线索(若音频是唯一信号,与视觉配对)。 | [低血量音效——循环直至高于阈值] | 持续 |
| 归零 | 条空。可选:条短暂抖动。触发死亡/耗尽事件。 | [死亡/耗尽音效] | 200ms 抖动 |
| 满值 | 填充 100%,短暂发光。 | — | 200ms |
| 溢出(护盾) | 自然填充区之外出现一个独立条段,用护盾色。 | [护盾获得音效] | 200ms |

**无障碍**:当前值必须能以数字形式获取(tooltip 或常驻显示,或两者)。
颜色编码的阈值状态必须有非颜色备份(图标、闪烁或视觉警告)。25% 的
警告状态必须有独立于颜色变化的视觉信号。

**实现备注**:[Godot:两个重叠的 `ProgressBar` 节点实现残影条效果
——后条保持先前值(经 Tween 消减),前条保持当前值(即时更新)。
阈值状态触发前条的 `StyleBoxFlat` 切换。残影条 Tween 时长可作为
设计师参数调节。]

---

#### Dialogue Box

**Category**: Game-Specific
**Status**: Draft
**何时使用**:NPC 对话、配音叙事对话、通过角色传达的教程文本。所有
有说话者的对话。

**结构**:说话者头像或名牌(框顶部或左侧)。对话文本主体。继续/推进
提示(右下)。可选:全跳过按钮、配音指示、字幕指示。

**状态与行为**:

| State | Visual | Input | Response | Duration |
|-------|--------|-------|----------|---------|
| Line entering | 文本逐字显现(打字机效果)。或:无障碍选项设定时全速淡入。 | — | — | 速度:无障碍设置中可配置 |
| Revealing | 文本动画中。继续提示隐藏或缓慢脉冲。 | [任意推进输入] | 立即跳到当前行末尾(显示整行,停止打字机) | 即时 |
| Line complete | 整行显示。继续提示可见并有动画。 | — | — | — |
| Advancing to next line | 继续提示隐藏。文本淡出或擦除。新行开始。 | [任意推进输入]——Enter / A / Cross / Space / 鼠标点击 | 推进 | 100ms 过渡 |
| Choices appearing | 选项按钮出现在对话文本下方。继续提示隐藏。导航焦点移到第一个选项。 | 十字键/键盘选择,Enter / A / Cross 确认 | 选择选项 | 150ms 进入动画 |
| Closing | 对话框淡出 | 最后一行推进完毕 | 控制权交还玩家 | 200ms |
| Skipping all(若支持) | 简短确认提示:"Skip dialogue?" | 专用跳过按钮 | 跳到对话后状态 | — |

**无障碍**:所有配音对话的字幕永远默认开启。打字机动画速度是用户
设置(见 accessibility-requirements.md)。对话框不得自动推进——节奏
必须由玩家掌控。说话者名字永远显示。所有选项按钮必须键盘与手柄可
导航。选项必须对屏幕阅读器可达并播报位置。

**实现备注**:[Godot:`RichTextLabel` 开 `bbcode_enabled` 做格式化。
打字机效果用 `Timer` 驱动 `visible_characters` 属性的动画。把推进输入
绑定到这样一个函数:跳过打字机(设 `visible_characters = -1`)或推进
对话状态。说话者名字用对话框上方或旁边的独立 `Label` 显示。对话数据
从 JSON 或专用对话格式加载(如 Dialogic、Yarn Spinner for Godot)。]

---

#### Context Action Prompt

**Category**: Game-Specific
**Status**: Draft
**何时使用**:出现在可交互游戏物体附近、指示玩家可以做什么的提示。
「Press [A] to open chest.」「Hold [E] to pick up.」玩家进入交互区时
出现,离开时消失。

**状态**:

| State | Visual | Notes |
|-------|--------|-------|
| Appearing | 淡入并从物体锚点上升 8px。 | 尊重减少动态——只淡入,不上升 |
| Idle | 平台正确的按键图标 + 动作标签。图标匹配当前输入方式(玩家切换时更新)。 | 永远显示平台正确的图标——不要为所有平台硬编码 "Press A" |
| Holding(长按输入) | 按键图标上的径向填充显示长按进度。标签变为进行时动词("Opening...")。 | |
| Cannot interact(被阻止) | 图标变暗。原因已知时标签显示原因("Too heavy"、"Need key")。 | 可选——仅当原因对玩家有意义时才显示阻止状态 |
| Disappearing | 淡出。 | 玩家离开交互区时触发 |

**无障碍**:按键图标必须配文本标签——不要只依赖图标(部分玩家使用
自定义按键标签或非标准图标的自适应控制器)。提示的位置不得与角色
血量或关键 HUD 信息重叠。

**实现备注**:[Godot:作为可交互物体的 `Node3D` 子节点(2D 游戏中
`Node2D`)挂载。3D 游戏用 `BillboardMesh` 或带 UI 场景的 `SubViewport`
——这样无需代码即可让提示面向镜头。根据 `Input.get_joy_name()` 或通过
`InputEventKey` vs `InputEventJoypadButton` 的键盘检测更新按键图标纹理。
长按进度用 `AnimationPlayer` 或对径向遮罩 shader 的 `Tween` 实现。]

---

#### Damage Number

**Category**: Game-Specific
**Status**: Draft
**何时使用**:战斗参与者上方浮动的反馈数字。普通伤害、暴击伤害、
治疗、未命中。

**变体**:

| Variant | Visual | Notes |
|---------|--------|-------|
| Normal damage | 白色数字,常规字重,中等尺寸。 | |
| Critical hit | 更大尺寸(1.5x),粗体,橙色或黄色——验证色盲安全。出现时的短暂缩放冲击(1.3x → 1.0x)。 | 示例:Path of Exile 与 Diablo IV 都对暴击使用缩放宽弹出,使其仅凭尺寸即可辨认,不依赖颜色。 |
| Healing | 绿色(验证色盲安全——用 + 前缀与向上轨迹作为非颜色备份)。 | |
| Miss / Evade | "MISS" 文本,灰色,斜体。以更小尺寸浮动。 | |
| Status damage (DoT) | 更小尺寸,与状态效果匹配的独特颜色。 | |

**行为**:数字从受击位置向上浮动 1.0 秒。最后 0.4 秒内从 100% 淡到
0%。快速连续命中的多个数字在水平方向错开以避免重叠。同屏伤害数字
上限:[按游戏定义——通常每角色 8-12 个]。

**无障碍**:伤害数字纯粹是补充反馈——绝不能是理解战斗状态的唯一
途径。血条是权威来源。提供完全关闭伤害数字的选项(部分玩家觉得视觉
过载)。关闭时游戏必须保持完全可玩。

**实现备注**:[Godot:`Label3D`(3D 游戏)或 `Label`(2D 游戏)
实例经对象池回收。每个实例生成时给一个随机小水平偏移(±20px)以减少
重叠。浮动动画用对 `position.y` 与 `modulate.a` 的 `Tween`。暴击缩放
弹出用先 `EASE_OUT` 后线性回落的缩放 Tween。]

---

## 导航模式

---

#### Screen Push / Pop / Replace

**Category**: Navigation
**Status**: Draft

这三个模式定义界面如何进出导航栈。

| Pattern | Trigger | Animation | Stack Behavior | Focus Behavior |
|---------|---------|-----------|---------------|----------------|
| Push | 深入导航(打开子菜单、打开详情视图) | 新界面从右侧滑入。前一界面向左滑出并压暗。 | 前一界面留在栈中 | 焦点移到新界面的第一个可交互元素 |
| Pop (Back) | 返回按钮 / Escape / B / Circle | 当前界面向右滑出。前一界面从左侧滑入并变亮。 | 当前界面从栈中移除 | 焦点回到触发 Push 的元素 |
| Replace | 导航到平级界面(非子级、非父级)。加载界面。 | 当前淡出,新界面淡入。无方向性。 | 当前界面移除。新界面入栈。 | 焦点移到新界面的第一个可交互元素 |

**动画时长**:Push/Pop:250ms ease-in-out。Replace:200ms 淡出 +
200ms 淡入。

**减少动态**:所有滑动动画变为淡入淡出。时长减到 100ms。

**实现备注**:[Godot:实现为管理 `Control` 场景栈的 `ScreenManager`
单例。`push(screen_scene)` 实例化并动画进入。`pop()` 动画退出并释放。
`replace(screen_scene)` 无中间栈状态地先 pop 再 push。每个界面用
`CanvasLayer` 隔离输入处理。push 前存下「返回焦点」元素的引用,以便
pop 时恢复。]

---

#### Focus Management

**Category**: Navigation
**Status**: Draft

> 焦点管理是游戏 UI 中最常见的键盘与手柄无障碍失败。这些规则必须
> 一致地实现。玩家绝不应该处于看不到哪个元素被聚焦、或 Tab/十字键
> 没有任何可见结果的状态。

| Rule | Description |
|------|-------------|
| Screen open | 焦点放在最合乎逻辑的可交互元素上——通常是 Primary 按钮、第一个列表项,或界面此前访问过时的最后聚焦元素。绝不放在不可交互元素上。 |
| Screen close / pop | 焦点回到触发导航的元素(打开该界面的按钮、被选中的列表项)。如果该元素已不存在,焦点移到最近的前一个可交互元素。 |
| Modal open | 焦点被困在模态框内。见 Modal Dialog 模式。 |
| Modal close | 焦点回到触发模态框的元素。 |
| Element disabled | 如果聚焦元素被禁用,焦点移到 Tab 顺序中的下一个可用可交互元素。 |
| Element destroyed | 如果聚焦元素被从场景中移除,焦点移到 Tab 顺序中最近的前一个元素。 |
| Screen without interactive elements | 焦点管理为空操作。确保返回/取消输入仍可用。 |
| Tab key(keyboard) | 按文档顺序(从左到右、从上到下)在可交互元素间前移焦点。Shift+Tab 后移。 |
| D-pad(gamepad) | 焦点按所按的空间方向移动。手柄优先空间导航而非严格 Tab 顺序。绝不在无关区域间回绕焦点(如分页栏与内容区应是独立的导航区域)。 |
| Focus is always visible | 元素经键盘或手柄聚焦时,焦点环或等效聚焦指示必须永远可见。绝不抑制聚焦指示。 |

---

#### Escape / Cancel

**Category**: Navigation
**Status**: Draft

> 「返回」动作是所有菜单系统中使用最多的导航输入。它必须在每个
> 界面保持一致,没有例外。

| Platform | Input | Behavior |
|----------|-------|---------|
| PC(键盘) | Escape | 关闭最上层模态框 / 在栈中后退一个界面 / 如在根界面(主菜单),打开「退出?」确认 |
| PC(手柄) | B(Xbox 布局)/ Circle(PS 布局) | 同 Escape |
| Xbox | B 键 | 同 Escape |
| PlayStation | Circle 键 | 同 Escape |
| Nintendo Switch | B 键 | 同 Escape(注意:任天堂部分第一方作品用 B 确认——为本次发布核实平台惯例并记录该决策) |

**规则**:此输入绝不可被改写为「返回/取消」之外的功能。如果一个
界面没有返回动作(如游戏暂停且玩家必须做选择),Escape 不做任何事
或显示「你必须做出选择」提示——它不会导航离开。每个界面必须在其
UX 规格中显式定义自己的 Escape 行为。

---

## 反馈与加载模式

---

#### Loading State

**Category**: Feedback
**Status**: Draft

| Scope | Pattern | Notes |
|-------|---------|-------|
| 全屏(初始加载) | 全屏加载界面,带游戏美术、进度条(尽可能确定性)、提示文本(可选)。 | 绝不用纯黑屏。给玩家可读或可看的东西。 |
| 全屏(关卡切换) | 淡入黑,加载界面,再淡出到新场景。 | 淡变消除上一场景突然消失的跳变感。 |
| 组件/内联 | spinner 或骨架占位替换加载中的组件。内容加载完成时组件不移动布局。 | 对重布局内容,骨架占位(近似内容形状的灰块)优于 spinner——它防止加载时的布局位移。 |
| 后台/异步 | 操作超过 2 秒才显示指示。2 秒后显示小 spinner 或 toast。 | 2 秒内完成的操作不要显示加载指示——指示的闪现比等待本身更打扰。 |

**无障碍**:加载状态必须向屏幕阅读器播报:"[Context] loading,
please wait." 完成必须播报 "[Context] loaded." 全屏加载时,确保加载
界面本身对屏幕阅读器可导航——提示文本与任何 UI 元素都必须被暴露。

---

#### Empty State

**Category**: Feedback
**Status**: Draft

> 空状态一直是游戏 UI 中最缺乏设计的部分。它决定了玩家感到的是
> 「这里将存放我的物品」还是「怎么什么都没有?是不是坏了?」每个
> 空列表与空网格都必须有设计过的空状态。空状态不是错误——它是
> 起点。

| Location | Empty State Content | Notes |
|----------|--------------------|----|
| Inventory(无物品) | 图标(不抢眼、大、居中)。文案:"Your inventory is empty." 副文案:"Items you find on your journey will appear here." | 不要说 "No items found"——"found" 暗示一次失败的搜索。 |
| Quest Log(无活跃任务) | 图标。文案:"No active quests." 副文案:"Talk to characters marked with [quest marker icon] to start a quest." | 给玩家明确的行动指引。 |
| Achievements(未获得) | 图标。文案:"No achievements yet." 提示成就列表:"Try [Action] to earn your first achievement." | 游戏化的激励,而不只是空。 |
| Search results(无匹配) | 图标。文案:"No results for '[search term]'." 副文案:"Try a different search or [browse all]." | 把搜索词回显给他们。给出替代行动。 |

**规则**:每个空状态必须包含图标、文案,以及副文案或行动按钮之一。
没有任何解释的空白容器绝不可接受。

---

#### Error State

**Category**: Feedback
**Status**: Draft

| Error Type | Pattern | Tone |
|-----------|---------|------|
| 输入验证(表单字段) | 字段下方的内联错误信息。信息左侧错误图标。字段红色边框(配图标确保色盲安全)。 | 中性且具体——"Username must be 3-20 characters." 而不是 "Invalid input." |
| 操作失败(存档错误、网络错误) | 非关键失败用 toast 通知。关键失败用 Modal Dialog(存档无法写入)。 | 冷静且可行动——"Save failed. Check storage space." 而不是 "FATAL ERROR." |
| 系统错误(崩溃、数据损坏) | 全屏错误界面,带错误码、恢复选项("Restart Game"、"Load last save")与支持联系方式。 | 安抚——承认问题,给玩家掌控感。绝不责怪玩家。 |
| 软错误(动作无法执行) | toast 或内联信息。 | 解释性——"Not enough gold" 而不是 "Action unavailable." |

**原则**:错误信息永远不是玩家的错。它们是游戏在告诉玩家发生了什么、
下一步该做什么。把所有错误信息中的 "invalid" 一词删掉——换成具体的
解释。

---

## 动画标准

> 这些时长值适用于本库中的所有模式。当某个模式写「150ms ease-out」
> 时,缓动函数在此定义。时长的一致性让 UI 感觉像一个整体设计出来的
> 系统,而不是一堆各自为政的决策。

| Animation Type | Duration (ms) | Easing Function | Notes |
|---------------|--------------|----------------|-------|
| Button hover / focus enter | 80 | ease-out | 快——利落,不拖沓 |
| Button hover / focus exit | 60 | ease-in | 退出比进入略快 |
| Button press scale down | 60 | ease-in | 即时反馈 |
| Button press scale up(release) | 80 | ease-out | 略带弹性 |
| Screen push(enter) | 250 | ease-in-out | 界面从右侧滑入 |
| Screen pop(exit) | 250 | ease-in-out | 界面向右滑出 |
| Modal open | 200 | ease-out | 从中心展开 |
| Modal close | 150 | ease-in | 收起比打开快 |
| Toast enter | 200 | ease-out | 从屏幕边缘滑入 |
| Toast exit | 200 | ease-in | |
| Tab switch | 150 | ease-in-out | 内容交叉淡变或滑动 |
| Tooltip appear | 120 | ease-out | 300-400ms 延迟后 |
| Tooltip disappear | 80 | ease-in | |
| Progress bar fill | 300 | ease-out | 数值变化平滑动画 |
| Value flash(damage, gain) | 100ms on + 100ms off | linear | 短暂,抓注意 |
| Dialogue text reveal(每字符) | 每字符 30ms | linear | 无障碍设置中可配置 |
| HUD damage flash | 80 | linear | 白色或红色叠加,即时 |

**减少动态覆盖**:减少动态模式开启时(见
accessibility-requirements.md),所有滑动与缩放动画替换为淡入淡出。
淡变时长减少 50%。循环动画(不确定 spinner、脉冲指示)替换为静态
等效物。

---

## 音效标准

> 每个交互事件都应该有音频反馈。声音是主要的反馈渠道,不是装饰。
> 这里定义的声音是事件类别——具体音频资产在 `docs/sound-bible.md`
> 中定义。这张表把交互事件映射到声音类别,让音效设计师与 UI 程序员
> 使用同一套词汇。

| Interaction Event | Sound Category | Notes |
|------------------|---------------|-------|
| Button hover / focus | UI Hover | 轻微、短(< 80ms),快速导航时不疲劳。Hades 用非常安静的高频咔哒声,快速导航时隐入背景。 |
| Button (Primary) confirm | UI Confirm — Primary | 比次要确认略突出。「好,出发」的声音。 |
| Button (Secondary) cancel / back | UI Cancel | 音高轻微下行。「返回」的声音。Mass Effect 用干净独特的嗖声做返回导航。 |
| Button (Destructive)——打开确认 | UI Warning | 与标准 confirm 明显不同。简短抓注意的声音。 |
| Confirmation dialog——确认危险动作 | UI Confirm — Destructive | 终局感,略带分量。动作正在执行。 |
| Toggle ON | UI Toggle On | 简短、利落、略明亮。Celeste 的无障碍开关有令人满足的咔哒声。 |
| Toggle OFF | UI Toggle Off | 同一咔哒家族,略平。 |
| Slider adjust | UI Slider | 拖动时轻微的连续声。十字键每步一声咔哒。绝不疲劳。 |
| Dropdown open | UI Expand | 简短,有方向感(打开感)。 |
| Dropdown close / select | UI Select | 确认感。 |
| Tab switch | UI Tab | 水平移动感。与垂直导航区分。 |
| Modal open | UI Modal Open | 比标准导航更突出——吸引注意。 |
| Modal close(cancel) | UI Modal Close | 回到先前上下文。 |
| Toast——信息性 | UI Notification | 背景级,不打扰。 |
| Toast——成就 | UI Achievement | 有庆祝感但不过长。玩家应感到被奖励,而非被打断。 |
| Toast——警告 | UI Warning — Toast | 与错误区分。警觉,不惊恐。 |
| Error state | UI Error | 友好但清晰。不是刺耳的蜂鸣。Dark Souls 对失败动作用轻微的闷响——传达「不行」而不刺耳。 |
| Success confirmation | UI Success | 干净、令人满足。 |
| Ability activate | Gameplay — Ability Activate | 世界内感,与纯 UI 区分。属于游戏手感,不是菜单感。 |
| Damage received | Gameplay — Damage | 完整规格见 sound-bible.md。 |
| Item pickup | Gameplay — Item Acquire | 简短,有奖励感。 |
| Level up / rank up | Gameplay — Progression | 庆祝感,恰当突出。 |
| Dialogue advance | UI Dialogue | 轻微,打字机激活时匹配打字机节奏。 |

---

## 待定问题

| Question | Owner | Deadline | Resolution |
|----------|-------|----------|-----------|
| [引擎的无障碍节点系统是否支持无需聚焦即可播报 toast 通知?请对照 engine-reference/godot/ 核实 Godot 4.6 情况。] | [ux-designer] | [首个菜单实现前] | [未解决] |
| [Nintendo Switch 发布的平台正确确认/取消按键映射是什么?任天堂第一方惯例与 Xbox/PlayStation 不同。] | [producer] | [平台认证提交前] | [未解决] |
| [伤害数字应该用 Label3D 节点池化还是在 SubViewport 中渲染?与 technical-director 协调验证性能预算。] | [lead-programmer, ux-designer] | [战斗 HUD 实现前] | [未解决] |
| [toast 通知同屏上限是多少才不会在视觉上过载?需要试玩验证。] | [ux-designer] | [首次试玩会话] | [未解决] |
| [添加问题] | [Owner] | [Deadline] | [Resolution] |
