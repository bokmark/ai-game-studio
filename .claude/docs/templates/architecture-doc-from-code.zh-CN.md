> 中文翻译 | [English](architecture-doc-from-code.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# ADR:[Decision Name]

---
**状态**:Reverse-Documented
**来源**:`[path to implementation code]`
**日期**:[YYYY-MM-DD]
**决策者**:[User name or "inferred from code"]
**实现状态**:[Deployed | Partial | Planned]
---

> **⚠️ 反向文档化声明**
>
> 本架构决策记录(ADR)是在实现**已经存在**之后创建的。它记录当前的
> 实现方式,并基于代码分析与用户确认澄清了理由。部分背景可能是事后
> 重建的,而非同期记录。

---

## 背景

**问题陈述**:[What problem did this implementation solve?]

**背景信息**(从代码推断):
- [Context 1 — why this problem needed solving]
- [Context 2 — constraints at the time]
- [Context 3 — alternatives that were likely considered]

**系统范围**:[What parts of the codebase does this affect?]

**利益相关方**:
- [Role 1]:[Their concern or requirement]
- [Role 2]:[Their concern or requirement]

---

## 决策

**采取的方式**(按实现):

[Describe the architectural approach found in the code]

**关键实现细节**:
- [Detail 1]:[How it works]
- [Detail 2]:[Pattern or structure used]
- [Detail 3]:[Notable design choice]

**澄清后的理由**(来自用户):
- [Reason 1 — why this approach was chosen]
- [Reason 2 — what problem it solves]
- [Reason 3 — what benefit it provides]

**代码位置**:
- `[file/path 1]`:[What's there]
- `[file/path 2]`:[What's there]

---

## 已考虑的替代方案

*(这些可能是推断的,或与用户确认过)*

### 替代方案 1:[Approach Name]

**描述**:[What this alternative would have been]

**优点**:
- ✅ [Advantage 1]
- ✅ [Advantage 2]

**缺点**:
- ❌ [Disadvantage 1]
- ❌ [Disadvantage 2]

**未选择的原因**:[Reason — from user clarification or inference]

### 替代方案 2:[Approach Name]

**描述**:[What this alternative would have been]

**优点**:
- ✅ [Advantage 1]
- ✅ [Advantage 2]

**缺点**:
- ❌ [Disadvantage 1]
- ❌ [Disadvantage 2]

**未选择的原因**:[Reason]

### 替代方案 3:[Status Quo / No Change]

**描述**:[What "doing nothing" would mean]

**不可接受的原因**:[Why the problem needed solving]

---

## 影响

### 正面影响(已实现的收益)

✅ **[Benefit 1]**:[How the implementation provides this]

✅ **[Benefit 2]**:[Impact]

✅ **[Benefit 3]**:[Impact]

### 负面影响(已接受的取舍)

⚠️ **[Trade-off 1]**:[What was sacrificed or made harder]

⚠️ **[Trade-off 2]**:[Limitation or cost]

⚠️ **[Trade-off 3]**:[Complexity or maintenance burden]

### 中性影响(观察)

ℹ️ **[Observation 1]**:[Emergent property or side effect]

ℹ️ **[Observation 2]**:[Unexpected outcome]

---

## 实现备注

**使用的模式**:
- [Pattern 1]:[Where and why]
- [Pattern 2]:[Where and why]

**引入的依赖**:
- [Dependency 1]:[Why needed]
- [Dependency 2]:[Why needed]

**性能特征**:
- 时间复杂度:[O(n), etc.]
- 空间复杂度:[Memory usage]
- 瓶颈:[Known performance concerns]

**线程安全**:
- [Thread safety approach — single-threaded, mutex-protected, lock-free, etc.]

**测试策略**:
- [How this is tested — unit tests, integration tests, etc.]
- 覆盖率:[Estimated or measured]

---

## 验证

**我们如何知道它可行**:
- ✅ [Evidence 1 — e.g., "6 months in production without issues"]
- ✅ [Evidence 2 — e.g., "handles 10k entities at 60 FPS"]
- ⚠️ [Evidence 3 — e.g., "works but needs monitoring"]

**已知问题**(分析期间发现):
- ⚠️ [Issue 1]:[Problem and potential fix]
- ⚠️ [Issue 2]:[Problem and potential fix]

**风险**:
- [Risk 1]:[Potential problem if X happens]
- [Risk 2]:[Scalability concern]

---

## 待定问题

**反向文档化期间未解决的**:
1. **[Question 1]**:[What's unclear about the decision or implementation?]
   - 需要谁澄清:[Who]
   - 未解决的影响:[Consequence]

2. **[Question 2]**:[What needs to be decided for future work?]

---

## 后续工作

**立即**:
- [ ] [Task 1 — e.g., "Add missing unit tests"]
- [ ] [Task 2 — e.g., "Document edge case handling"]

**短期**:
- [ ] [Task 3 — e.g., "Refactor X for clarity"]
- [ ] [Task 4 — e.g., "Add performance monitoring"]

**长期**:
- [ ] [Task 5 — e.g., "Revisit decision when Y is available"]

---

## 相关决策

**依赖于**(本 ADR 基于的 ADR):
- [ADR-XXX]:[Related decision]

**影响**(受本 ADR 影响的 ADR):
- [ADR-YYY]:[How this impacts it]

**取代**:
- [ADR-ZZZ]:[Old decision this replaces, if any]

**被取代**:
- [None yet | ADR-WWW if this decision is later replaced]

---

## 参考资料

**代码位置**:
- `[path/file 1]`:[Primary implementation]
- `[path/file 2]`:[Related code]

**外部资源**:
- [Article/Book]:[Relevant pattern or technique reference]
- [Documentation]:[Engine or library docs consulted]

**设计文档**:
- [GDD Section]:[If this implements a design]

---

## 版本历史

| 日期 | 作者 | 变更 |
|------|--------|---------|
| [Date] | Claude(reverse-doc)| 从 `[source path]` 初始反向文档化 |
| [Date] | [User] | 澄清了 [X] 的理由 |

---

## 状态图例

- **Proposed**:讨论中,未实现
- **Accepted**:已决策,实现进行中
- **Deprecated**:不再推荐,但可能仍存在于代码中
- **Superseded**:已被另一决策取代
- **Reverse-Documented**:实现之后创建(本文档)

---

**当前状态**:**Reverse-Documented**

---

*本 ADR 由 `/reverse-document architecture [path]` 生成*

---

## 附录:代码片段

**关键实现模式**:

```[language]
[Code snippet showing the core pattern or decision]
```

**理由**:[Why this code structure embodies the decision]

**替代方式**(未选择):

```[language]
[Code snippet showing what the alternative would look like]
```

**为何不选**:[Why the implemented approach was preferred]
