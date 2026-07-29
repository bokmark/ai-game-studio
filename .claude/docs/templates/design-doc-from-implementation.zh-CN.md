> 中文翻译 | [English](design-doc-from-implementation.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# [System Name] — 设计文档(Design Document)

---
**状态**:逆向文档化(Reverse-Documented)
**来源**:`[path to implementation code]`
**日期**:[YYYY-MM-DD]
**验证人**:[User name or "pending review"]
**实现状态**:[Fully implemented | Partially implemented | Needs extension]
---

> **⚠️ 逆向文档说明(Reverse-Documentation Notice)**
>
> 本设计文档是在实现已经存在**之后**创建的。它基于代码分析与用户咨询,记录了当前行为并澄清了设计意图。在实现不完整、或逆向工程期间设计意图不明之处,部分章节可能不完整。

---

## 1. 概览(Overview)

**目的(Purpose)**:[这个系统解决什么问题?]

**范围(Scope)**:[这个系统包含什么、不包含什么?]

**当前实现(Current Implementation)**:[简要描述代码中已存在的内容]

**设计意图(Design Intent)**(已澄清):
- [Intent 1——该功能为何存在]
- [Intent 2——它营造了怎样的玩家体验]
- [Intent 3——它如何融入整体游戏支柱]

---

## 2. 详细设计(Detailed Design)

### 2.1 核心机制(Core Mechanics)

[按实现的实际情况描述机制,组织清晰]

**[Mechanic 1 Name]**:
- **描述(Description)**:[它做什么]
- **实现(Implementation)**:[代码中如何工作]
- **设计理由(Design Rationale)**:[为何存在——来自用户澄清]
- **玩家侧体验(Player-Facing)**:[玩家如何体验到它]

**[Mechanic 2 Name]**:
- **描述(Description)**:[它做什么]
- **实现(Implementation)**:[如何工作]
- **设计理由(Design Rationale)**:[为何存在]
- **玩家侧体验(Player-Facing)**:[玩家体验]

### 2.2 规则与公式(Rules and Formulas)

**代码中发现的公式(Formulas Discovered in Code)**:

| 公式 | 表达式 | 用途 | 已验证? |
|---------|-----------|---------|-----------|
| [Formula 1] | `[mathematical expression]` | [它计算什么] | ✅ / ⚠️ 需调优 |
| [Formula 2] | `[expression]` | [用途] | ✅ / ⚠️ 需调优 |

**澄清说明(Clarifications)**:
- [Formula X]:原为 [value/approach],用户澄清其意图为 [corrected intent]
- [Formula Y]:实现为 [X],但应为 [Y]——已标记待更新

### 2.3 状态与数据(State and Data)

**数据结构(Data Structures)**(来自代码):
- [Data structure 1]:`[fields/properties]`
- [Data structure 2]:`[fields/properties]`

**状态机(State Machines)**(如适用):
```
[State diagram or list of states and transitions]
```

**持久化(Persistence)**:
- 已保存:[什么会写入玩家存档]
- 不保存:[什么仅限会话内或即时重算]

### 2.4 集成点(Integration Points)

**依赖项(Dependencies)**(本系统依赖的系统):
- [System 1]:[它提供什么]
- [System 2]:[它提供什么]

**被依赖方(Dependents)**(依赖本系统的系统):
- [System 3]:[它如何使用本系统]
- [System 4]:[它如何使用本系统]

**API 表面(API Surface)**(公开接口):
- [Method/Function 1]:[用途]
- [Method/Function 2]:[用途]

---

## 3. 边界情况(Edge Cases)

**代码中已处理(Handled in Code)**:
- ✅ [Edge case 1]:[如何处理]
- ✅ [Edge case 2]:[如何处理]

**尚未处理(Not Yet Handled)**(分析中发现):
- ⚠️ [Edge case 3]:[会发生什么?需要实现]
- ⚠️ [Edge case 4]:[会发生什么?需要实现]

**不明确(Unclear)**(需用户澄清):
- ❓ [Edge case 5]:[应该发生什么?待决策]

---

## 4. 依赖(Dependencies)

**技术依赖(Technical Dependencies)**:
- [Dependency 1]:[为何需要]
- [Dependency 2]:[为何需要]

**设计依赖(Design Dependencies)**(其他设计文档):
- [System X Design]:[如何交互]
- [System Y Design]:[如何交互]

**内容依赖(Content Dependencies)**:
- [Asset type]:[需要什么]
- [Data files]:[所需的配置/平衡数据]

---

## 5. 平衡与调优(Balance and Tuning)

**当前数值(Current Values)**(以实现为准):

| 参数 | 当前值 | 理由 | 需调优? |
|-----------|--------------|-----------|---------------|
| [Param 1] | [value] | [为何取此值] | ✅ / ⚠️ / ❌ |
| [Param 2] | [value] | [为何取此值] | ✅ / ⚠️ / ❌ |

**已识别的平衡隐患(Balance Concerns Identified)**:
- ⚠️ [Concern 1]:[问题所在,建议修复方案]
- ⚠️ [Concern 2]:[问题所在,建议修复方案]

**建议的平衡检查(Recommended Balance Pass)**:
- 对 [specific aspect] 运行 `/balance-check`
- 针对 [specific scenario] 进行试玩测试

---

## 6. 验收标准(Acceptance Criteria)

**已有内容(What Exists)**(已实现):
- ✅ [Criterion 1]
- ✅ [Criterion 2]
- ⚠️ [Criterion 3]——部分实现

**缺失内容(What's Missing)**(尚未实现):
- ❌ [Criterion 4]——已标记为后续工作
- ❌ [Criterion 5]——已标记为后续工作

**完成定义(Definition of Done)**(系统何时算「完成」?):
- [ ] [Requirement 1]
- [ ] [Requirement 2]
- [ ] [Requirement 3]

---

## 7. 待决问题与后续工作(Open Questions and Follow-Up Work)

### 需用户决策的问题(Questions Needing User Decision)
1. **[Question 1]**:[需要决策什么?]
   - 选项 A:[Approach A]
   - 选项 B:[Approach B]

2. **[Question 2]**:[需要决策什么?]

### 已标记的后续工作(Flagged Follow-Up Work)
- [ ] **更新 [Formula X]**:从指数改为线性(根据用户澄清)
- [ ] **实现 [Edge Case Y]**:处理当前代码未覆盖的场景
- [ ] **创建 ADR**:记录为何选择 [architectural decision]
- [ ] **平衡检查**:对进度曲线运行 `/balance-check`
- [ ] **扩充设计文档**:当 [related feature] 实现后,更新本文档

---

## 8. 版本历史(Version History)

| 日期 | 作者 | 变更 |
|------|--------|---------|
| [Date] | Claude (reverse-doc) | 基于 `[source path]` 的初始逆向文档 |
| [Date] | [User] | 澄清设计意图,修正了 [X] |

---

**后续步骤(Next Steps)**:
1. [基于已识别缺口的第一优先级任务]
2. [Priority 2 task]
3. [Priority 3 task]

**相关技能(Related Skills)**:
- `/balance-check`——校验公式与进度曲线
- `/architecture-decision`——记录技术决策
- `/code-review`——确保代码与澄清后的设计一致

---

*本文档由 `/reverse-document design [path]` 生成*
