> 中文翻译 | [English](architecture-traceability.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# 架构可追溯性索引

<!-- 活文档——每次评审运行后由 /architecture-review 更新。
     除非纠错,请勿手动编辑。 -->

## 文档状态

- **最后更新**:[YYYY-MM-DD]
- **引擎**:[e.g. Godot 4.6]
- **已索引 GDD 数**:[N]
- **已索引 ADR 数**:[M]
- **最近评审**:[link to docs/architecture/architecture-review-[date].md]

## 覆盖摘要

| 状态 | 数量 | 百分比 |
|--------|-------|-----------|
| ✅ 已覆盖 | [X] | [%] |
| ⚠️ 部分覆盖 | [Y] | [%] |
| ❌ 缺口 | [Z] | [%] |
| **合计** | **[N]** | |

---

## 可追溯性矩阵

<!-- 从 GDD 提取的每条技术需求一行。
     「技术需求」指任何暗示具体架构决策的 GDD 陈述:
     数据结构、性能约束、所需引擎能力、跨系统通信、状态持久化。 -->

| 需求 ID | GDD | 系统 | 需求摘要 | ADR(s) | 状态 | 备注 |
|--------|-----|--------|---------------------|--------|--------|-------|
| TR-[gdd]-001 | [filename] | [system name] | [one-line summary] | [ADR-NNNN] | ✅ | |
| TR-[gdd]-002 | [filename] | [system name] | [one-line summary] | — | ❌ GAP | 需要 `/architecture-decision [title]` |

---

## 已知缺口

没有 ADR 覆盖的需求,按层级排序(Foundation 优先):

### 基础层(Foundation Layer)缺口(阻塞——必须在编码前解决)
- [ ] TR-[id]: [requirement] — GDD: [file] — 建议 ADR:"[title]"

### 核心层(Core Layer)缺口(必须在相关系统构建前解决)
- [ ] TR-[id]: [requirement] — GDD: [file] — 建议 ADR:"[title]"

### 功能层(Feature Layer)缺口(应在功能 Sprint 前解决)
- [ ] TR-[id]: [requirement] — GDD: [file] — 建议 ADR:"[title]"

### 表现层(Presentation Layer)缺口(可推迟到实现阶段)
- [ ] TR-[id]: [requirement] — GDD: [file] — 建议 ADR:"[title]"

---

## 跨 ADR 冲突

<!-- 做出相互矛盾声明的 ADR 对。必须解决。 -->

| 冲突 ID | ADR A | ADR B | 类型 | 状态 |
|-------------|-------|-------|------|--------|
| CONFLICT-001 | ADR-NNNN | ADR-MMMM | 数据所有权 | 🔴 未解决 |

---

## ADR → GDD 覆盖(反向索引)

<!-- 每个 ADR 分别满足哪些 GDD 需求? -->

| ADR | 标题 | 满足的 GDD 需求 | 引擎风险 |
|-----|-------|---------------------------|-------------|
| ADR-0001 | [title] | TR-combat-001, TR-combat-002 | HIGH |

---

## 已被取代的需求

<!-- ADR 撰写时存在于 GDD 中、但 GDD 此后已变更的需求。
     对应 ADR 可能需要更新。 -->

| 需求 ID | GDD | 变更 | 受影响 ADR | 状态 |
|--------|-----|--------|-------------|--------|
| TR-[id] | [file] | [what changed] | ADR-NNNN | 🔴 ADR 需要更新 |

---

## 如何使用本文档

**撰写新 ADR 时**:将其加入「ADR → GDD 覆盖」表,并在矩阵中把它满足的
需求标记为 ✅。

**批准 GDD 变更时**:在矩阵中扫描来自该 GDD 的需求,检查变更是否使任何
现有 ADR 失效。若失效,加入「已被取代的需求」。

**运行 `/architecture-review` 时**:该技能会用当前状态自动更新本文档。

**阶段门检查**:Pre-Production 门要求本文档存在,且基础层缺口为零。
