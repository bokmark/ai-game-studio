> 中文翻译 | [English](technical-preferences.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# 技术偏好

<!-- 由 /setup-engine 填写。随用户在开发中做出决策而更新。 -->
<!-- 所有代理查阅本文件,获取项目特定的标准与约定。 -->

## 引擎与语言

- **引擎**: [TO BE CONFIGURED — run /setup-engine]
- **语言**: [TO BE CONFIGURED]
- **渲染**: [TO BE CONFIGURED]
- **物理**: [TO BE CONFIGURED]

## 输入与平台

<!-- 由 /setup-engine 写入。由 /ux-design、/ux-review、/test-setup、/team-ui 和 /dev-story 读取, -->
<!-- 用于把交互规格、测试辅助与实现限定到正确的输入方式。 -->

- **目标平台**: [TO BE CONFIGURED — e.g., PC, Console, Mobile, Web]
- **输入方式**: [TO BE CONFIGURED — e.g., Keyboard/Mouse, Gamepad, Touch, Mixed]
- **主要输入**: [TO BE CONFIGURED — the dominant input for this game]
- **手柄支持**: [TO BE CONFIGURED — Full / Partial / None]
- **触屏支持**: [TO BE CONFIGURED — Full / Partial / None]
- **平台说明**: [TO BE CONFIGURED — any platform-specific UX constraints]

## 命名约定

- **类**: [TO BE CONFIGURED]
- **变量**: [TO BE CONFIGURED]
- **信号/事件**: [TO BE CONFIGURED]
- **文件**: [TO BE CONFIGURED]
- **场景/预制体**: [TO BE CONFIGURED]
- **常量**: [TO BE CONFIGURED]

## 性能预算

- **目标帧率**: [TO BE CONFIGURED]
- **帧预算**: [TO BE CONFIGURED]
- **Draw Call**: [TO BE CONFIGURED]
- **内存上限**: [TO BE CONFIGURED]

## 测试

- **框架**: [TO BE CONFIGURED]
- **最低覆盖率**: [TO BE CONFIGURED]
- **必需测试**: 平衡公式、玩法系统、网络(如适用)

## 禁用模式

<!-- 添加绝不应出现在本项目代码库中的模式 -->
- [None configured yet — add as architectural decisions are made]

## 允许的库 / 插件

<!-- 在此添加已批准的第三方依赖 -->
- [None configured yet — add as dependencies are approved]

## 架构决策日志

<!-- 快速引用,链接到 docs/architecture/ 中的完整 ADR -->
- [No ADRs yet — use /architecture-decision to create one]

## 引擎专家

<!-- 配置引擎后由 /setup-engine 写入。 -->
<!-- 由 /code-review、/architecture-decision、/architecture-review 和团队技能读取, -->
<!-- 以确定引擎特定校验该生成哪个专家。 -->

- **主专家**: [TO BE CONFIGURED — run /setup-engine]
- **语言/代码专家**: [TO BE CONFIGURED]
- **Shader 专家**: [TO BE CONFIGURED]
- **UI 专家**: [TO BE CONFIGURED]
- **其他专家**: [TO BE CONFIGURED]
- **路由说明**: [TO BE CONFIGURED]

### 文件扩展名路由

<!-- 技能用此表为每种文件类型选择合适的专家。 -->
<!-- 若某行为 [TO BE CONFIGURED],该文件类型回退到 Primary。 -->

| 文件扩展名 / 类型 | 应生成的专家 |
|-----------------------|---------------------|
| 游戏代码(主语言) | [TO BE CONFIGURED] |
| Shader / 材质文件 | [TO BE CONFIGURED] |
| UI / 屏幕文件 | [TO BE CONFIGURED] |
| 场景 / 预制体 / 关卡文件 | [TO BE CONFIGURED] |
| 原生扩展 / 插件文件 | [TO BE CONFIGURED] |
| 通用架构评审 | Primary |
