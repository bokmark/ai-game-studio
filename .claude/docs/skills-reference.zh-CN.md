> 中文翻译 | [English](skills-reference.md)
> 同步基线:commit `41d7e09`(2026-07-29);如有出入以英文版为准。

# 可用技能(斜杠命令)

73 个斜杠命令,按阶段组织。在 Claude Code 中输入 `/` 即可使用其中任意一个。

## 上手指引与导航

| 命令 | 用途 |
|---------|---------|
| `/start` | 首次上手指引——询问你当前所处位置,然后引导你进入正确的工作流 |
| `/help` | 上下文感知的「下一步该做什么?」——读取当前阶段并给出必需的下一步 |
| `/project-stage-detect` | 完整项目审计——检测阶段、识别存在性缺口、推荐下一步 |
| `/setup-engine` | 配置引擎与版本,检测知识缺口,生成版本感知的参考文档 |
| `/adopt` | 既有项目(brownfield)格式审计——检查既有 GDD/ADR/故事的内部结构,产出迁移计划 |

## 游戏设计

| 命令 | 用途 |
|---------|---------|
| `/brainstorm` | 使用专业工作室方法(MDA、SDT、Bartle、动词优先)的引导式创意构思 |
| `/map-systems` | 把游戏概念分解为系统,映射依赖,排定设计顺序优先级 |
| `/design-system` | 引导式逐节撰写单个游戏系统的 GDD |
| `/quick-design` | 小变更的轻量级设计规格——调参、微调、小增补 |
| `/review-all-gdds` | 跨所有设计文档的跨 GDD 一致性与游戏设计整体性评审 |
| `/propagate-design-change` | GDD 修订时,找出受影响的 ADR 并产出影响报告 |

## 美术与资产

| 命令 | 用途 |
|---------|---------|
| `/art-bible` | 引导式逐节撰写美术圣经(Art Bible)——在资产生产开始前建立视觉识别规格 |
| `/asset-spec` | 从 GDD、关卡文档或角色档案生成逐资产视觉规格与 AI 生成提示词 |
| `/asset-audit` | 审计资产的命名约定、文件大小预算与管线合规性 |

## UX 与界面设计

| 命令 | 用途 |
|---------|---------|
| `/ux-design` | 引导式逐节撰写 UX 规格(屏幕/流程、HUD 或模式库) |
| `/ux-review` | 校验 UX 规格的 GDD 对齐、无障碍与模式合规 |

## 架构

| 命令 | 用途 |
|---------|---------|
| `/create-architecture` | 引导式撰写主架构文档 |
| `/architecture-decision` | 创建架构决策记录(ADR) |
| `/architecture-review` | 验证所有 ADR 的完整性、依赖排序与 GDD 覆盖 |
| `/create-control-manifest` | 从 Accepted 状态的 ADR 生成扁平的程序员规则清单 |

## 故事与 Sprint

| 命令 | 用途 |
|---------|---------|
| `/create-epics` | 把 GDD + ADR 转化为 Epic——每个架构模块一个 |
| `/create-stories` | 把单个 Epic 拆成可实现的故事文件 |
| `/dev-story` | 读取故事并实现它——路由到正确的程序员代理 |
| `/sprint-plan` | 生成或更新 Sprint 计划;初始化 sprint-status.yaml |
| `/sprint-status` | 30 行 Sprint 快速快照(读取 sprint-status.yaml) |
| `/story-readiness` | 领取前验证故事是否可实现(READY/NEEDS WORK/BLOCKED) |
| `/story-done` | 实现后的 8 阶段完成评审;更新故事文件并给出下一个故事 |
| `/estimate` | 结构化工作量估算,含复杂度、依赖与风险分解 |

## 评审与分析

| 命令 | 用途 |
|---------|---------|
| `/design-review` | 评审游戏设计文档的完整性与一致性 |
| `/code-review` | 对文件或变更集做架构级代码评审 |
| `/balance-check` | 分析游戏平衡数据、公式与配置——标记异常值 |
| `/content-audit` | 审计 GDD 规定的内容数量与已实现内容的对照 |
| `/scope-check` | 对照原计划分析功能或 Sprint 范围,标记范围蔓延 |
| `/perf-profile` | 带瓶颈识别的结构化性能分析 |
| `/tech-debt` | 扫描、跟踪、排定优先级并报告技术债 |
| `/gate-check` | 验证在开发阶段之间推进的就绪度(PASS/CONCERNS/FAIL) |
| `/consistency-check` | 对照实体注册表扫描所有 GDD,检测跨文档不一致(相互矛盾的数值、名称、规则) |
| `/security-audit` | 审计游戏安全漏洞:存档篡改、作弊途径、网络漏洞利用、数据暴露和输入校验缺口 |

## QA 与测试

| 命令 | 用途 |
|---------|---------|
| `/qa-plan` | 为 Sprint 或功能生成 QA 测试计划 |
| `/smoke-check` | 移交 QA 前运行关键路径冒烟测试门 |
| `/soak-test` | 为长时间试玩会话生成浸泡测试协议 |
| `/regression-suite` | 把测试覆盖映射到 GDD 关键路径,识别缺少回归测试的已修复 bug |
| `/test-setup` | 为项目引擎搭建测试框架和 CI/CD 管线 |
| `/test-helpers` | 为测试套件生成引擎特定的测试辅助库 |
| `/test-evidence-review` | 对测试文件与手动证据文档做质量评审 |
| `/test-flakiness` | 从 CI 运行日志检测非确定性(不稳定)测试 |
| `/skill-test` | 校验技能文件的结构合规性与行为正确性 |
| `/skill-improve` | 用测试-修复-重测循环改进技能——诊断、提议修复、重写、验证 |

## 生产管理

| 命令 | 用途 |
|---------|---------|
| `/milestone-review` | 评审里程碑进度并生成状态报告 |
| `/retrospective` | 运行结构化的 Sprint 或里程碑复盘 |
| `/bug-report` | 创建结构化的 bug 报告 |
| `/bug-triage` | 读取所有未关闭 bug,重新评估优先级与严重度,分配负责人和标签 |
| `/reverse-document` | 从既有实现生成设计或架构文档 |
| `/playtest-report` | 生成结构化的试玩测试报告,或分析既有试玩笔记 |

## 发布

| 命令 | 用途 |
|---------|---------|
| `/release-checklist` | 为当前构建生成并验证发布前检查清单 |
| `/launch-checklist` | 跨所有部门的完整上线就绪验证 |
| `/changelog` | 从 Git 提交和 Sprint 数据自动生成更新日志 |
| `/patch-notes` | 从 Git 历史和内部数据生成面向玩家的补丁说明 |
| `/hotfix` | 带审计追踪的紧急修复工作流,绕过正常 Sprint 流程 |
| `/day-one-patch` | 为黄金母版之后、公开上线之时或之前发现的已知问题,准备聚焦的首日补丁 |

## 创意与内容

| 命令 | 用途 |
|---------|---------|
| `/prototype` | 概念原型——头脑风暴后立即构建一次性版本,验证核心想法(第 1 阶段) |
| `/vertical-slice` | 预制作验证——投入制作阶段前的生产质量端到端构建(第 4 阶段) |
| `/onboard` | 为新贡献者或代理生成上下文相关的上手文档 |
| `/localize` | 本地化工作流:字符串提取、校验、翻译就绪 |

## 团队编排

协调多个代理完成同一个功能领域:

| 命令 | 协调的代理 |
|---------|-------------|
| `/team-combat` | game-designer + gameplay-programmer + ai-programmer + technical-artist + sound-designer + qa-tester |
| `/team-narrative` | narrative-director + writer + world-builder + level-designer |
| `/team-ui` | ux-designer + ui-programmer + art-director + accessibility-specialist |
| `/team-release` | release-manager + qa-lead + devops-engineer + producer |
| `/team-polish` | performance-analyst + technical-artist + sound-designer + qa-tester |
| `/team-audio` | audio-director + sound-designer + technical-artist + gameplay-programmer |
| `/team-level` | level-designer + narrative-director + world-builder + art-director + systems-designer + qa-tester |
| `/team-live-ops` | live-ops-designer + economy-designer + community-manager + analytics-engineer |
| `/team-qa` | qa-lead + qa-tester + gameplay-programmer + producer |
