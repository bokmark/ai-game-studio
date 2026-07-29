# 翻译术语表(Translation Glossary)

本术语表统一全仓中文翻译的用词口径。所有 `.zh-CN.md` 文件遵循以下约定。

## 翻译总则

1. **标识符不译**:技能名(`$start`、`/brainstorm`)、代理名(`game-designer`)、文件名、路径、命令、代码块、frontmatter 键名、门 ID(`CD-CONCEPT`)、TR-ID 等保持英文原文。
2. **术语首次出现**:采用「中文(English)」格式标注,后文可直接使用中文。
3. **中英文之间加空格**:如「使用 Git 提交」(盘古之白)。
4. **标点**:中文句子使用全角标点;代码、路径、命令内部保持原样。
5. **结构对齐**:标题层级、表格、列表与英文版逐节对应,便于 diff 同步。
6. **权威版本**:英文版为准,中文版为阅读辅助。

## 框架机制

| English | 中文 | 备注 |
|---------|------|------|
| skill | 技能(skill) | 技能名本身不译 |
| subagent | 子代理 | |
| agent | 代理 | 泛指时用「代理」,特指某代理用英文名 |
| custom agent | 自定义代理 | Codex 侧 `.codex/agents/*.toml` |
| hook | 钩子(hook) | 钩子脚本名不译 |
| rule (path-scoped) | (路径作用域)规则 | |
| frontmatter | frontmatter | 保留英文 |
| slash command | 斜杠命令 | |
| argument-hint | argument-hint | frontmatter 键名,不译 |
| dual-platform | 双平台 | |
| sandbox | 沙箱 | |
| approval policy | 审批策略 | |
| session state | 会话状态 | |
| context compaction | 上下文压缩 | |
| status line | 状态栏 | |

## 游戏开发流程

| English | 中文 | 备注 |
|---------|------|------|
| Game Design Document (GDD) | 游戏设计文档(GDD) | 后文直接用 GDD |
| Architecture Decision Record (ADR) | 架构决策记录(ADR) | 后文直接用 ADR |
| Technical Requirement (TR-ID) | 技术需求(TR-ID) | |
| sprint | Sprint | 保留英文 |
| milestone | 里程碑 | |
| epic | 史诗(Epic) | 后文可用 Epic |
| story / dev story | 故事 / 开发故事 | |
| vertical slice | 垂直切片 | |
| prototype | 原型 | |
| playtest | 试玩测试 | |
| smoke test | 冒烟测试 | |
| soak test | 浸泡测试 | |
| regression test | 回归测试 | |
| hotfix | 热修复 | |
| day-one patch | 首日补丁 | |
| patch notes | 补丁说明 | |
| changelog | 更新日志 | |
| release | 发布 | |
| live-ops | 在线运营(live-ops) | |
| brownfield | 既有项目(brownfield) | |
| greenfield | 全新项目(greenfield) | |
| onboarding | 上手指引 | |
| retrospective | 复盘 | |
| gate check / phase gate | 阶段门检查 / 阶段门 | |
| director gate | 总监门 | |
| scope creep | 范围蔓延 | |
| tech debt | 技术债 | |
| art bible | 美术圣经(Art Bible) | |
| entity registry | 实体注册表 | |
| traceability index | 可追溯性索引 | |
| control manifest | 控制清单 | |
| review mode (full/lean/solo) | 评审模式(完整/精简/独立) | 模式值保留英文 |
| trunk-based development | 主干开发 | |
| Conventional Commits | 约定式提交 | |
| verification-driven development | 验证驱动开发 | |

## 角色(代理)译名

正文提及角色时用「中文译名(`agent-name`)」,标题或表格中可直接用英文代理名。

| English | 中文 |
|---------|------|
| Creative Director | 创意总监 |
| Technical Director | 技术总监 |
| Producer | 制作人 |
| Game Designer | 游戏设计师 |
| Lead Programmer | 首席程序员 |
| Art Director | 美术总监 |
| Audio Director | 音频总监 |
| Narrative Director | 叙事总监 |
| QA Lead | QA 主管 |
| Release Manager | 发布经理 |
| Localization Lead | 本地化主管 |
| Gameplay Programmer | 玩法程序员 |
| Engine Programmer | 引擎程序员 |
| AI Programmer | AI 程序员 |
| Network Programmer | 网络程序员 |
| Tools Programmer | 工具程序员 |
| UI Programmer | UI 程序员 |
| Systems Designer | 系统设计师 |
| Level Designer | 关卡设计师 |
| Economy Designer | 经济设计师 |
| Technical Artist | 技术美术 |
| Sound Designer | 音效设计师 |
| Writer | 编剧 |
| World Builder | 世界观构建师 |
| UX Designer | UX 设计师 |
| Prototyper | 原型师 |
| Performance Analyst | 性能分析师 |
| DevOps Engineer | DevOps 工程师 |
| Analytics Engineer | 数据分析工程师 |
| Security Engineer | 安全工程师 |
| QA Tester | QA 测试员 |
| Accessibility Specialist | 无障碍专家 |
| Live-ops Designer | 在线运营设计师 |
| Community Manager | 社区经理 |

## 游戏设计理论

| English | 中文 |
|---------|------|
| MDA Framework (Mechanics, Dynamics, Aesthetics) | MDA 框架(机制、动态、美学) |
| Self-Determination Theory | 自我决定理论 |
| Flow State | 心流状态 |
| Bartle Player Types | Bartle 玩家类型 |
| game feel | 游戏手感 |
| player fantasy | 玩家幻想 |
| core loop | 核心循环 |
| difficulty curve | 难度曲线 |
| player journey | 玩家旅程 |
