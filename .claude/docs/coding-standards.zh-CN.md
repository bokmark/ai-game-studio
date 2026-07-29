> 中文翻译 | [English](coding-standards.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# 编码规范

- 所有游戏代码必须在公开 API 上包含文档注释
- 每个系统必须在 `docs/architecture/` 中有对应的架构决策记录(ADR)
- 玩法数值必须数据驱动(外部配置),严禁硬编码
- 所有公开方法必须可单元测试(依赖注入优于单例)
- 提交必须引用相关设计文档或任务 ID
- **提交信息**:使用约定式提交(Conventional Commits)格式——`feat:`、`fix:`、`chore:`、`docs:`、`test:`、`refactor:`。在正文中引用故事或任务 ID(如 `Story: EPIC-001-S02`)。
- **验证驱动开发**:新增玩法系统时先写测试。
  UI 变更用截图验证。标记完成前,将预期输出与实际输出
  进行比对。每项实现都应有办法证明其有效。

# 设计文档规范

- 所有设计文档使用 Markdown
- 每个机制在 `design/gdd/` 下有专属文档
- 文档必须包含以下 8 个必备小节:
  1. **概览(Overview)**——一段话总结
  2. **玩家幻想(Player Fantasy)**——预期的感受与体验
  3. **详细规则(Detailed Rules)**——无歧义的机制描述
  4. **公式(Formulas)**——所有数学定义,含变量
  5. **边界情况(Edge Cases)**——异常情形的处理
  6. **依赖(Dependencies)**——列出其他相关系统
  7. **调优旋钮(Tuning Knobs)**——标明可配置数值
  8. **验收标准(Acceptance Criteria)**——可测试的成功条件
- 平衡数值必须链接到其来源公式或设计依据

# 测试规范

## 按故事类型划分的测试证据

所有故事在标记为 Done 之前必须具备相应的测试证据:

| 故事类型 | 必需证据 | 位置 | 门禁级别 |
|---|---|---|---|
| **逻辑类**(公式、AI、状态机) | 自动化单元测试——必须通过 | `tests/unit/[system]/` | BLOCKING |
| **集成类**(多系统) | 集成测试或有记录的试玩测试 | `tests/integration/[system]/` | BLOCKING |
| **视觉/手感类**(动画、VFX、手感) | 截图 + 主管签核 | `production/qa/evidence/` | ADVISORY |
| **UI 类**(菜单、HUD、界面) | 手动走查文档或交互测试 | `production/qa/evidence/` | ADVISORY |
| **配置/数据类**(平衡调优) | 冒烟检查通过 | `production/qa/smoke-[date].md` | ADVISORY |

## 自动化测试规则

- **命名**:文件用 `[system]_[feature]_test.[ext]`;函数用 `test_[scenario]_[expected]`
- **确定性**:测试每次运行必须产生相同结果——不使用随机种子,不做时间相关断言
- **隔离性**:每个测试自行建立和清理状态;测试不得依赖执行顺序
- **无硬编码数据**:测试夹具使用常量文件或工厂函数,不用内联魔法数
  (例外:边界值测试中精确数值本身就是测试目的)
- **独立性**:单元测试不调用外部 API、数据库或文件 I/O——使用依赖注入

## 不应自动化的内容

- 视觉保真度(着色器输出、VFX 外观、动画曲线)
- “手感”类品质(输入响应、感知重量感、时机感)
- 平台特定渲染(在目标硬件上测试,而非无头环境)
- 完整游玩流程(由试玩测试覆盖,而非自动化)

## CI/CD 规则

- 自动化测试套件在每次推送 main 和每个 PR 上运行
- 测试失败不得合并——测试是 CI 中的阻断门禁
- 绝不为让 CI 通过而禁用或跳过失败的测试——修复根本问题
- 各引擎 CI 命令:
  - **Godot**:`godot --headless --script tests/gdunit4_runner.gd`
  - **Unity**:`game-ci/unity-test-runner@v4`(GitHub Actions)
  - **Unreal**:使用 `-nullrhi` 参数的无头运行器
