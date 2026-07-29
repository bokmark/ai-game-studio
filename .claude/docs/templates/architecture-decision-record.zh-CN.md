> 中文翻译 | [English](architecture-decision-record.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# ADR-[NNNN]: [Title]

## 状态

[Proposed | Accepted | Deprecated | Superseded by ADR-XXXX]

## 日期

[YYYY-MM-DD — when this ADR was written]

## 最后验证

[YYYY-MM-DD — when this ADR was last confirmed accurate against the current
engine version and design. Update this date when you re-read and confirm it
is still correct, even if nothing changed.]

## 决策者

[Who was involved in this decision]

## 摘要

[2 sentences: what problem this ADR solves, and what was decided. Written for
tiered context loading — a skill scanning 20 ADRs uses this to decide whether
to read the full decision. Be specific: name the system, the problem, and the
chosen approach.]

## 引擎兼容性

| 字段 | 值 |
|-------|-------|
| **引擎** | [e.g. Godot 4.6 / Unity 6 / Unreal Engine 5.4] |
| **领域** | [Physics / Rendering / UI / Audio / Navigation / Animation / Networking / Core / Input / Scripting] |
| **知识风险** | [LOW — in training data / MEDIUM — near cutoff, verify / HIGH — post-cutoff, must verify] |
| **参考的资料** | [e.g. `docs/engine-reference/godot/modules/physics.md`, `breaking-changes.md`] |
| **使用的截止后 API** | [Specific APIs from post-cutoff engine versions this decision depends on, or "None"] |
| **所需验证** | [Concrete behaviours to test against the target engine version before shipping, or "None"] |

> **注意**:若知识风险为 MEDIUM 或 HIGH,项目升级引擎版本时必须重新验证
> 本 ADR。将其标记为「Superseded」并撰写新的 ADR。

## ADR 依赖

| 字段 | 值 |
|-------|-------|
| **依赖于** | [ADR-NNNN (must be Accepted before this can be implemented), or "None"] |
| **解锁** | [ADR-NNNN (this ADR unlocks that decision), or "None"] |
| **阻塞** | [Epic/Story name — cannot start until this ADR is Accepted, or "None"] |
| **顺序说明** | [Any sequencing constraint that isn't captured above] |

## 背景

### 问题陈述

[What problem are we solving? Why must this decision be made now? What is the
cost of not deciding?]

### 现状

[How does the system work today? What is wrong with the current approach?]

### 约束

- [Technical constraints -- engine limitations, platform requirements]
- [Timeline constraints -- deadline pressures, dependencies]
- [Resource constraints -- team size, expertise available]
- [Compatibility requirements -- must work with existing systems]

### 需求

- [Functional requirement 1]
- [Functional requirement 2]
- [Performance requirement -- specific, measurable]
- [Scalability requirement]

## 决策

[The specific technical decision, described in enough detail for someone to
implement it without further clarification.]

### 架构

```
[ASCII diagram showing the system architecture this decision creates.
Show components, data flow direction, and key interfaces.]
```

### 关键接口

```
[Pseudocode or language-specific interface definitions that this decision
creates. These become the contracts that implementers must respect.]
```

### 实现指引

[Specific guidance for the programmer implementing this decision.]

## 已考虑的替代方案

### 替代方案 1:[Name]

- **描述**:[How this approach would work]
- **优点**:[What is good about this approach]
- **缺点**:[What is bad about this approach]
- **预估工作量**:[Relative effort compared to chosen approach]
- **否决理由**:[Why this was not chosen]

### 替代方案 2:[Name]

[Same structure as above]

## 影响

### 正面

- [Good outcomes of this decision]

### 负面

- [Trade-offs and costs we are accepting]

### 中性

- [Changes that are neither good nor bad, just different]

## 风险

| 风险 | 概率 | 影响 | 缓解措施 |
|------|------------|--------|-----------|

## 性能影响

| 指标 | 变更前 | 预期变更后 | 预算 |
|--------|--------|---------------|--------|
| CPU(帧时间)| [X]ms | [Y]ms | [Z]ms |
| 内存 | [X]MB | [Y]MB | [Z]MB |
| 加载时间 | [X]s | [Y]s | [Z]s |
| 网络(如适用)| [X]KB/s | [Y]KB/s | [Z]KB/s |

## 迁移计划

[If this changes existing systems, the step-by-step plan to migrate.]

1. [Step 1 -- what changes, what breaks, how to verify]
2. [Step 2]
3. [Step 3]

**回滚计划**:[How to revert if this decision proves wrong]

## 验证标准

[How we will know this decision was correct after implementation.]

- [ ] [Measurable criterion 1]
- [ ] [Measurable criterion 2]
- [ ] [Performance criterion]

## 满足的 GDD 需求

<!-- 本节为必填。每个 ADR 都必须追溯到至少一条 GDD
     需求,或明确声明它是没有 GDD 依赖的基础性决策。
     可追溯性由 /architecture-review 审计。 -->

| GDD 文档 | 系统 | 需求 | 本 ADR 如何满足 |
|-------------|--------|-------------|--------------------------|
| [e.g. `design/gdd/combat.md`] | [e.g. Combat] | [e.g. "Hitbox detection must resolve within 1 frame"] | [e.g. "Jolt physics collision queries run synchronously in _physics_process"] |

> 若这是没有直接 GDD 依赖的基础性决策,写:
> "Foundational — no GDD requirement. Enables: [list what GDD systems this
> decision unlocks or constrains]"

## 相关

- [Link to related ADRs — note if supersedes, contradicts, or depends on]
- [Link to relevant code files once implemented]
