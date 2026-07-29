> 中文翻译 | [English](agent-roster.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# 代理名册

以下代理可供使用。每个代理在 `.claude/agents/` 中都有专属定义文件。
请根据手头的任务选用最合适的代理。当任务跨多个领域时,由协调代理
(通常是 `producer` 或相应领域主管)委派给各专家代理。

## 第 1 层级——领导层代理(Opus)
| 代理 | 领域 | 何时使用 |
|-------|--------|-------------|
| `creative-director` | 高层愿景 | 重大创意决策、支柱冲突、基调/方向 |
| `technical-director` | 技术愿景 | 架构决策、技术选型、性能策略 |
| `producer` | 制作管理 | Sprint 规划、里程碑跟踪、风险管理、协调 |

## 第 2 层级——部门主管代理(Sonnet)
| 代理 | 领域 | 何时使用 |
|-------|--------|-------------|
| `game-designer` | 游戏设计 | 机制、系统、成长、经济、平衡 |
| `lead-programmer` | 代码架构 | 系统设计、代码评审、API 设计、重构 |
| `art-director` | 视觉方向 | 风格指南、美术圣经、资产标准、UI/UX 方向 |
| `audio-director` | 音频方向 | 音乐方向、音效基调、音频实现策略 |
| `narrative-director` | 故事与写作 | 故事弧线、世界观构建、角色设计、对白策略 |
| `qa-lead` | 质量保证 | 测试策略、缺陷分诊、发布就绪、回归规划 |
| `release-manager` | 发布管线 | 构建管理、版本号、更新日志、部署、回滚 |
| `localization-lead` | 国际化 | 字符串外置、翻译管线、区域语言测试 |

## 第 3 层级——专家代理(Sonnet 或 Haiku)
| 代理 | 领域 | 模型 | 何时使用 |
|-------|--------|-------|-------------|
| `systems-designer` | 系统设计 | Sonnet | 具体机制实现、公式设计、循环 |
| `level-designer` | 关卡设计 | Sonnet | 关卡布局、节奏、遭遇战设计、动线 |
| `economy-designer` | 经济/平衡 | Sonnet | 资源经济、掉落表、成长曲线 |
| `gameplay-programmer` | 玩法代码 | Sonnet | 功能实现、玩法系统代码 |
| `engine-programmer` | 引擎系统 | Sonnet | 核心引擎、渲染、物理、内存管理 |
| `ai-programmer` | AI 系统 | Sonnet | 行为树、寻路、NPC 逻辑、状态机 |
| `network-programmer` | 网络 | Sonnet | 网络代码、状态同步、延迟补偿、匹配 |
| `tools-programmer` | 开发工具 | Sonnet | 编辑器扩展、管线工具、调试工具 |
| `ui-programmer` | UI 实现 | Sonnet | UI 框架、界面、控件、数据绑定 |
| `technical-artist` | 技术美术 | Sonnet | 着色器、VFX、优化、美术管线工具 |
| `sound-designer` | 音效设计 | Sonnet | 音效设计文档、音频事件清单、混音说明 |
| `writer` | 对白/世界观文本 | Sonnet | 对白写作、设定条目、物品描述 |
| `world-builder` | 世界/设定设计 | Sonnet | 世界规则、阵营设计、历史、地理 |
| `qa-tester` | 测试执行 | Haiku | 编写测试用例、缺陷报告、测试清单 |
| `performance-analyst` | 性能 | Sonnet | 性能分析、优化建议、内存分析 |
| `devops-engineer` | 构建/部署 | Haiku | CI/CD、构建脚本、版本控制工作流 |
| `analytics-engineer` | 遥测 | Sonnet | 事件追踪、数据看板、A/B 测试设计 |
| `ux-designer` | UX 流程 | Sonnet | 用户流程、线框图、无障碍、输入处理 |
| `prototyper` | 快速原型 | Sonnet | 一次性原型、机制验证、可行性验证 |
| `security-engineer` | 安全 | Sonnet | 反作弊、漏洞防范、存档加密、网络安全 |
| `accessibility-specialist` | 无障碍 | Haiku | WCAG 合规、色盲模式、按键重映射、文字缩放 |
| `live-ops-designer` | 在线运营 | Sonnet | 赛季、活动、战斗通行证、留存、在线经济 |
| `community-manager` | 社区 | Haiku | 补丁说明、玩家反馈、危机沟通、社区健康 |

## 引擎专属代理(使用与你的引擎匹配的一组)

### 引擎主管

| 代理 | 引擎 | 模型 | 何时使用 |
| ---- | ---- | ---- | ---- |
| `unreal-specialist` | Unreal Engine 5 | Sonnet | Blueprint 与 C++ 取舍、GAS 概览、UE 子系统、Unreal 优化 |
| `unity-specialist` | Unity | Sonnet | MonoBehaviour 与 DOTS 取舍、Addressables、URP/HDRP、Unity 优化 |
| `godot-specialist` | Godot 4 | Sonnet | GDScript 模式、节点/场景架构、信号、Godot 优化 |

### Unreal Engine 子专家

| 代理 | 子系统 | 模型 | 何时使用 |
| ---- | ---- | ---- | ---- |
| `ue-gas-specialist` | Gameplay Ability System | Sonnet | 技能、玩法效果、属性集、标签、预测 |
| `ue-blueprint-specialist` | Blueprint 架构 | Sonnet | BP/C++ 边界、蓝图规范、命名、BP 优化 |
| `ue-replication-specialist` | 网络/复制 | Sonnet | 属性复制、RPC、预测、相关性、带宽 |
| `ue-umg-specialist` | UMG/CommonUI | Sonnet | 控件层级、数据绑定、CommonUI 输入、UI 性能 |

### Unity 子专家

| 代理 | 子系统 | 模型 | 何时使用 |
| ---- | ---- | ---- | ---- |
| `unity-dots-specialist` | DOTS/ECS | Sonnet | Entity Component System、Jobs、Burst 编译器、混合渲染器 |
| `unity-shader-specialist` | 着色器/VFX | Sonnet | Shader Graph、VFX Graph、URP/HDRP 定制、后处理 |
| `unity-addressables-specialist` | 资产管理 | Sonnet | Addressable 分组、异步加载、内存、内容分发 |
| `unity-ui-specialist` | UI Toolkit/UGUI | Sonnet | UI Toolkit、UXML/USS、UGUI Canvas、数据绑定、跨平台输入 |

### Godot 子专家

| 代理 | 子系统 | 模型 | 何时使用 |
| ---- | ---- | ---- | ---- |
| `godot-gdscript-specialist` | GDScript | Sonnet | 静态类型、设计模式、信号、协程、GDScript 性能 |
| `godot-csharp-specialist` | C# / .NET | Sonnet | .NET 模式、[Signal] 委托、异步、可空类型、类型安全节点访问 |
| `godot-shader-specialist` | 着色器/渲染 | Sonnet | Godot 着色语言、可视化着色器、粒子、后处理 |
| `godot-gdextension-specialist` | GDExtension | Sonnet | C++/Rust 绑定、原生性能、自定义节点、构建系统 |
