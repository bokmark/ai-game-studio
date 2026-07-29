> 中文翻译 | [English](concept-doc-from-prototype.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# [Prototype Name] — 概念文档(Concept Document)

---
**状态**:从原型逆向整理(Reverse-Documented from Prototype)
**原型路径**:`prototypes/[name]/`
**日期**:[YYYY-MM-DD]
**创建者**:[User name]
**结果**:[Success | Partial Success | Failed | Needs More Testing]
---

> **⚠️ 逆向文档说明(Reverse-Documentation Notice)**
>
> 本概念文档是在原型构建完成**之后**创建的。它捕捉了通过原型工作发现的核心机制、经验与设计洞察。本文档是对实验性工作的正式化整理,而非预先规划的设计。

---

## 1. 原型概览(Prototype Overview)

**原始假设(Original Hypothesis)**:
[这个原型在验证什么问题或想法?]

**方法(Approach)**:
[原型是如何构建的?快速粗糙?聚焦单一机制?]

**耗时(Duration)**:
- 投入时间:[X hours/days]
- 复杂度:[Throwaway | Could be production-ready | Needs full rewrite]

**结果(Outcome)**(细化):
- ✅ **已验证(Validated)**:[哪些行之有效,应继续推进]
- ⚠️ **需要改进(Needs Work)**:[哪些展现了潜力,但需要打磨]
- ❌ **已证伪(Invalidated)**:[哪些行不通,应当放弃]

---

## 2. 核心机制(Core Mechanic)

**原型实现了什么(What the Prototype Does)**:
[描述被原型化的机制或系统]

**手感如何(How It Feels)**(用户反馈):
- [感受 1——例如:「令人满意」「笨拙」「过于复杂」]
- [感受 2——例如:「直观」「令人困惑」「需要教程」]
- [感受 3——例如:「有趣」「无聊」「有潜力」]

**玩家幻想(Player Fantasy)**:
[这个机制营造了什么样的幻想或体验?]

**核心循环(Core Loop)**(如适用):
```
[Action 1] → [Result 1] → [Action 2] → [Result 2] → [Repeat or Conclude]
```

**涌现行为(Emergent Behaviors)**(意料之外但有趣):
- [Behavior 1]:[玩家做出了哪些计划外的行为]
- [Behavior 2]:[意料之外的策略或交互]

---

## 3. 行之有效的部分(What Worked)

### 机制成功点(Mechanic Successes)

✅ **[Success 1]**:[什么做得好]
- **原因(Why)**:[是什么让它成功]
- **是否保留到正式版(Keep for Production)**:[是否应保留?]

✅ **[Success 2]**:[什么做得好]
- **原因(Why)**:[是什么让它成功]
- **是否保留到正式版(Keep for Production)**:[是否应保留?]

### 技术成功点(Technical Successes)

✅ **[Technical win 1]**:[哪种技术方案奏效了]
- **经验(Lesson)**:[我们学到了什么]
- **可复用性(Reusable)**:[这段代码/这种方法能否用于正式版?]

✅ **[Technical win 2]**:[什么奏效了]
- **经验(Lesson)**:[我们学到了什么]

---

## 4. 未能奏效的部分(What Didn't Work)

### 机制失败点(Mechanic Failures)

❌ **[Failure 1]**:[什么行不通]
- **原因(Why)**:[根本原因]
- **能否修复(Could It Be Fixed)**:[是可挽救的,还是根本性缺陷?]

❌ **[Failure 2]**:[什么行不通]
- **原因(Why)**:[根本原因]
- **能否修复(Could It Be Fixed)**:[Yes/No + 如何修复]

### 技术失败点(Technical Failures)

❌ **[Technical issue 1]**:[什么引发了问题]
- **经验(Lesson)**:[正式版中应避免什么]

❌ **[Technical issue 2]**:[什么引发了问题]
- **经验(Lesson)**:[应避免什么]

---

## 5. 需要打磨的部分(What Needs Refinement)

⚠️ **[Element 1]**:[什么展现了潜力,但需要改进]
- **问题(Issue)**:[目前的问题出在哪里]
- **改进路径(Path Forward)**:[如何改进]
- **工作量(Effort)**:[Small | Medium | Large refactor]

⚠️ **[Element 2]**:[什么需要打磨]
- **问题(Issue)**:[当前问题]
- **改进路径(Path Forward)**:[改进方法]
- **工作量(Effort)**:[估算]

---

## 6. 关键经验(Key Learnings)

### 设计洞察(Design Insights)

💡 **[Insight 1]**:[我们在游戏设计上学到了什么]
- **启示(Implication)**:[这对后续工作有何影响]

💡 **[Insight 2]**:[设计经验]
- **启示(Implication)**:[对 GDD 或其他系统的影响]

### 技术洞察(Technical Insights)

💡 **[Insight 3]**:[技术经验]
- **启示(Implication)**:[架构或实现层面的指导]

💡 **[Insight 4]**:[技术经验]
- **启示(Implication)**:[对未来的技术决策的影响]

### 玩家心理洞察(Player Psychology Insights)

💡 **[Insight 5]**:[我们在玩家行为上学到了什么]
- **启示(Implication)**:[这对设计理念有何影响]

---

## 7. 投产就绪度评估(Production Readiness Assessment)

**是否应做成完整功能?(Should This Become a Full Feature?)**:[Yes | No | Needs More Testing | Pivot to Different Approach]

**若「是」——投产要求(Production Requirements)**:
- [ ] [Requirement 1——例如:「为性能重写」]
- [ ] [Requirement 2——例如:「补齐正式 UI」]
- [ ] [Requirement 3——例如:「再设计 10 种变体」]
- [ ] [Requirement 4——例如:「与进度系统整合」]

**预估投产工作量(Estimated Production Effort)**:[Small | Medium | Large]
- 原型可复用度:代码可保留 [X%]
- 从零重写工作量:[达到投产标准所需的 X 小时/天]

**若「否」——原因(Why Not?)**:
- [Reason 1——例如:「好玩,但不符合游戏支柱」]
- [Reason 2——例如:「对目标受众而言过于复杂」]
- [Reason 3——例如:「在规模化后技术上不可行」]

**若「转向(Pivot)」——建议方向(Suggested Direction)**:
- [Alternative approach 1]
- [Alternative approach 2]

---

## 8. 设计支柱契合度(Design Pillars Alignment)

**与游戏支柱的关系**(若已定义游戏支柱):

| 支柱 | 契合度 | 说明 |
|--------|-----------|-------|
| [Pillar 1] | ✅ 强 / ⚠️ 弱 / ❌ 冲突 | [解释] |
| [Pillar 2] | ✅ 强 / ⚠️ 弱 / ❌ 冲突 | [解释] |
| [Pillar 3] | ✅ 强 / ⚠️ 弱 / ❌ 冲突 | [解释] |

**整体支柱契合度(Overall Pillar Fit)**:[它属于这个游戏吗?]

---

## 9. 后续步骤(Next Steps)

### 立即行动(若推进)(Immediate (If Moving Forward))
1. **[Task 1]**:[例如:「为此系统撰写完整设计文档」]
2. **[Task 2]**:[例如:「为技术方案撰写 ADR」]
3. **[Task 3]**:[例如:「加入 Sprint X 的待办列表」]

### 投产前(若需继续打磨)(Before Production (If Needs More Work))
1. **[Task 1]**:[例如:「构建第二个原型,验证 X 变体」]
2. **[Task 2]**:[例如:「组织 5 人以上试玩测试」]
3. **[Task 3]**:[例如:「验证 Y 的技术可行性」]

### 若放弃(If Abandoning)
1. **[Task 1]**:[例如:「将原型与本文档一并归档」]
2. **[Task 2]**:[例如:「提取可复用的代码与经验」]
3. **[Task 3]**:[例如:「若此次改变了思路,更新游戏支柱」]

---

## 10. 技术备注(Technical Notes)

**原型实现(Prototype Implementation)**:
- 语言/引擎:[使用了什么]
- 架构:[结构如何组织]
- 走的捷径:[哪些是临时或一次性的写法]

**可复用代码(Reusable Code)**(如有):
- `[file/path 1]`:[功能与可复用性]
- `[file/path 2]`:[功能与可复用性]

**技术债(Technical Debt)**(若转入投产):
- [Debt 1]:[什么需要重写]
- [Debt 2]:[什么需要正式实现]

---

## 11. 试玩测试反馈(Playtest Feedback)

*(若原型经过试玩测试)*

**测试者(Testers)**:[N people, [internal/external]]

**正面反馈(Positive Feedback)**:
- 「[Quote 1]」——[Tester name/role]
- 「[Quote 2]」——[Tester name/role]

**负面反馈(Negative Feedback)**:
- 「[Quote 1]」——[Tester name/role]
- 「[Quote 2]」——[Tester name/role]

**建议(Suggestions)**:
- 「[Suggestion 1]」——[Tester name]
- 「[Suggestion 2]」——[Tester name]

**共性主题(Themes)**:
- [Theme 1]:[多名测试者一致认同的点]
- [Theme 2]:[普遍反馈]

---

## 12. 相关工作(Related Work)

**灵感来源(Inspired By)**(受其影响的游戏/机制):
- [Game 1]:[哪种机制或感受]
- [Game 2]:[借鉴或改造了什么]

**差异点(Differs From)**(独特或不同之处):
- [Difference 1]
- [Difference 2]

**可整合的系统(Integrates With)**(既有游戏系统):
- [System 1]:[将如何衔接]
- [System 2]:[将如何衔接]

---

## 13. 待决问题(Open Questions)

**设计问题(Design Questions)**:
1. **[Question 1]**:[设计上还有哪些未定项?]
2. **[Question 2]**:[什么需要通过试玩或迭代来回答?]

**技术问题(Technical Questions)**:
3. **[Question 3]**:[还有哪些技术未知数?]
4. **[Question 4]**:[什么需要做可行性验证?]

---

## 14. 附录:原型资产(Appendix: Prototype Assets)

**代码(Code)**:
- 位置:`prototypes/[name]/src/`
- 状态:[Archival | Partial reuse | Full reuse]

**美术/音频(Art/Audio)**(如有):
- 位置:`prototypes/[name]/assets/`
- 状态:[Placeholder | Production-ready | Needs replacement]

**文档(Documentation)**:
- README:[Exists | Missing]
- 构建说明:[Exists | Missing]

---

## 版本历史(Version History)

| 日期 | 作者 | 变更 |
|------|--------|---------|
| [Date] | Claude (reverse-doc) | 基于原型分析的初始概念文档 |
| [Date] | [User] | 澄清了结果,补充试玩反馈 |

---

**最终建议(Final Recommendation)**:[GO | NO-GO | PIVOT]

**理由(Rationale)**:[用 1-2 句话总结原因]

---

*本概念文档由 `/reverse-document concept prototypes/[name]` 生成*
