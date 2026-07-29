> 中文翻译 | [English](test-plan.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# QA 计划:[Sprint/Feature Name]

> **日期**:[date]
> **生成者**:/qa-plan
> **范围**:[N 个故事,横跨 N 个系统]
> **引擎**:[引擎名称与版本]
> **Sprint 文件**:[Sprint 计划路径]

---

## 故事覆盖摘要

| 故事 | 类型 | 所需自动化测试 | 所需手动验证 |
|-------|------|------------------------|------------------------------|
| [story title] | Logic | 单元测试 —— `tests/unit/[system]/` | 无 |
| [story title] | Integration | 集成测试 —— `tests/integration/[system]/` | 冒烟检查 |
| [story title] | Visual/Feel | 无(无法自动化) | 截图 + 主管签核 |
| [story title] | UI | 无(无法自动化) | 手动逐步走查 |
| [story title] | Config/Data | 数据校验(可选) | 抽查游戏内数值 |

**合计**:[N] Logic,[N] Integration,[N] Visual/Feel,[N] UI,[N] Config/Data

---

## 所需自动化测试

### [Story Title] —— Logic

**测试文件路径**:`tests/unit/[system]/[story-slug]_test.[ext]`

**要测什么**:
- [来自 GDD Formulas 章节的公式或规则 —— 例如「damage = base * multiplier,其中 multiplier ∈ [0.5, 3.0]」]
- [每个具名状态转换]
- [每个应发生 / 不应发生的副作用]

**要覆盖的边缘情况**:
- 零 / 最小输入值
- 最大 / 边界输入值
- 非法或空输入
- [GDD 指定的边缘情况]

**预估测试数量**:约 [N] 个单元测试

---

### [Story Title] —— Integration

**测试文件路径**:`tests/integration/[system]/[story-slug]_test.[ext]`

**要测什么**:
- [跨系统交互 —— 例如「施加增益会更新 CharacterStats 并触发 UI 刷新」]
- [往返 —— 例如「保存 → 读取后所有字段还原」]

---

## 手动 QA 检查清单

### [Story Title] —— Visual/Feel

**验证方法**:截图 + [设计师 / 美术主管] 签核
**证据文件**:`production/qa/evidence/[story-slug]-evidence.md`
**必须签核的人**:[designer / lead-programmer / art-lead]

- [ ] [具体可观察条件 —— 例如「受击闪白出现在命中帧,而非下一帧」]
- [ ] [另一个可证伪的条件]

### [Story Title] —— UI

**验证方法**:手动逐步走查
**证据文件**:`production/qa/evidence/[story-slug]-evidence.md`

- [ ] [将每条验收标准转化为一个手动检查项]

---

## 冒烟测试范围

QA 移交前要验证的关键路径(通过 `/smoke-check` 运行):

1. 游戏启动到主菜单不崩溃
2. 可以开始新游戏 / 会话
3. [本 Sprint 引入或变更的主要机制]
4. [因本 Sprint 变更而有回归风险的系统]
5. 保存 / 读取循环完成且无数据丢失(若已有存档系统)
6. 性能在目标硬件上处于预算内

---

## 试玩测试要求

| 故事 | 试玩目标 | 最少场次 | 目标玩家类型 |
|-------|--------------|--------------|-------------------|
| [story] | [必须回答什么问题?] | [N] | [新手 / 老手 / 等] |

签核要求:试玩笔记 → `production/session-logs/playtest-[sprint]-[story-slug].md`

若无需试玩场次:*本 Sprint 无需试玩测试场次。*

---

## 完成定义(Definition of Done)—— 本 Sprint

满足以下全部条件时,故事方为 DONE:

- [ ] 所有验收标准已验证 —— 自动化测试结果,或有文档记录的手动证据
- [ ] 所有 Logic 与 Integration 故事均有测试文件且通过
- [ ] 所有 Visual/Feel 与 UI 故事均有手动证据文档
- [ ] 冒烟检查通过(QA 移交前运行 `/smoke-check sprint`)
- [ ] 未引入回归 —— 上一 Sprint 的功能仍通过
- [ ] 代码已评审(通过 `/code-review` 或有记录的同行评审)
- [ ] 故事文件已通过 `/story-done` 更新为 `Status: Complete`

**关闭前需要试玩签核的故事**:[列表,或「None」]

---

---

*结果与签核在 `/team-qa` 生成的 QA 签核报告中追踪 —— 不在本计划文件中。*

*模板:`.claude/docs/templates/test-plan.md`*
*生成者:`/qa-plan` —— 请勿编辑本行*
