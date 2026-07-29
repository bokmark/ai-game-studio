> 中文翻译 | [English](AGENTS.md)
> 同步基线:commit `0de6c40`(2026-07-29);如有出入以英文版为准。

# Game Studio —— Codex 代理指令

独立游戏开发,由 49 个协同的自定义代理管理。
每个代理负责一个特定领域,以此保证关注点分离与质量。

> **双平台项目**:本仓库同时支持 Codex 和 Claude Code。
> Codex 读取本文件、`.codex/` 和 `.agents/skills/`。`.claude/` 目录树
> 是 Claude Code 的镜像——除非明确要求,不要在 Codex 会话中修改它。
> 共享内容(文档、模板、注册表)位于 `.claude/docs/`,两个平台都只读引用。

## 技术栈

- **引擎**:[待定:Godot 4 / Unity / Unreal Engine 5]
- **语言**:[待定:GDScript / C# / C++ / 蓝图]
- **版本控制**:Git,主干开发(trunk-based development)
- **构建系统**:[选定引擎后填写]
- **资产管线**:[选定引擎后填写]

> **注意**:Godot、Unity 和 Unreal 都有引擎专家代理,
> 并配有专属的子专家。请使用与你引擎匹配的那一组。

## 仓库结构

```text
/
├── AGENTS.md / CLAUDE.md      # Codex / Claude 入口文件
├── .codex/                    # Codex:agents/*.toml、hooks.json、config.toml
├── .agents/skills/            # Codex 技能(以 $skill-name 形式调用)
├── .claude/                   # Claude Code 镜像(agents、skills、hooks、rules、docs)
├── src/                       # 游戏源代码(core、gameplay、ai、networking、ui、tools)
├── assets/                    # 游戏资产(art、audio、vfx、shaders、data)
├── design/                    # GDD、叙事、关卡、数值 + registry/entities.yaml
├── docs/                      # 技术文档、ADR、engine-reference/ API 快照
├── tests/                     # 测试套件(单元、集成、性能、试玩)
├── tools/                     # 构建与流水线工具
├── prototypes/                # 一次性原型(与 src/ 隔离)
└── production/                # Sprint、里程碑、发布、session-state/
```

## 工作室层级

```text
Tier 1 — 总监(gpt-5.5,high effort)
  creative-director    technical-director    producer

Tier 2 — 部门主管(gpt-5.6-terra,medium effort)
  game-designer        lead-programmer       art-director
  audio-director       narrative-director    qa-lead
  release-manager      localization-lead

Tier 3 — 专家(gpt-5.6-terra;快速查询用 gpt-5.6-luna)
  gameplay-programmer  engine-programmer     ai-programmer
  network-programmer   tools-programmer      ui-programmer
  systems-designer     level-designer        economy-designer
  technical-artist     sound-designer        writer
  world-builder        ux-designer           prototyper
  performance-analyst  devops-engineer       analytics-engineer
  security-engineer    qa-tester             accessibility-specialist
  live-ops-designer    community-manager     + 引擎专家
```

## 协同规则

1. **垂直委派** ——总监委派给主管,主管委派给专家。
2. **横向协商** ——同级代理可互相咨询,但不做有约束力的跨领域决定。
3. **冲突解决** ——升级至共同的上一级:设计冲突找 `creative-director`,
   技术冲突找 `technical-director`。
4. **变更传播** ——跨部门变更由 `producer` 协调。
5. **领域边界** ——没有明确委派,代理绝不修改自己领域之外的文件。

完整细节:`.claude/docs/coordination-rules.md`(共享参考)。

## 协作协议

**用户驱动的协作,而非自治执行。**
每个任务遵循:**提问 -> 选项 -> 决策 -> 草稿 -> 批准**

- 代理在写文件前必须询问「我可以写入 [filepath] 吗?」
- 代理在请求批准前必须展示草稿或摘要
- 多文件变更需要对整个变更集明确批准
- 没有用户指令不做提交

> **第一次会话?** 如果项目还没有配置引擎、也没有游戏概念,
> 运行 `$start` 开始引导式上手流程。

## 编码标准(摘要)

- 公开 API 要有文档注释;每个系统都要有 ADR,存放于 `docs/architecture/`
- 玩法数值数据驱动(外部配置),绝不硬编码
- 依赖注入优于单例;公开方法可单元测试
- 约定式提交(`feat:`/`fix:`/`chore:`/`docs:`/`test:`/`refactor:`),
  并引用 story/task ID
- 验证驱动开发:玩法系统先写测试;UI 变更要附截图
- GDD 必须具备 8 个章节(Overview、Player Fantasy、Detailed Rules、
  Formulas、Edge Cases、Dependencies、Tuning Knobs、Acceptance Criteria)

完整标准 + 测试证据规则:`.claude/docs/coding-standards.md`

## 上下文与会话状态

**记忆在文件里,不在对话里。** 将
`production/session-state/active.md` 作为动态检查点维护(当前任务、
进度、关键决策、进行中的文件、悬而未决的问题)。每个里程碑后更新。

- 保存状态:结束会话或切换任务前运行 `$session-save`
- 恢复状态:会话开始时运行 `$session-restore`(或直接读 `active.md`)
- 多章节文档增量编写:先搭骨架,一次写一个获批章节

## 文档地图(按需阅读)

| 路径 | 何时阅读 |
|------|-----------|
| `.claude/docs/technical-preferences.md` | 引擎/平台/命名/性能配置——由 `$setup-engine` 写入,做引擎相关工作前先查 |
| `.claude/docs/coordination-rules.md` | 完整的委派、并行与层级规则 |
| `.claude/docs/coding-standards.md` | 完整的编码/测试/CI 标准 |
| `.claude/docs/templates/` | 41 个文档模板(GDD、ADR、Sprint、UX、QA) |
| `.claude/docs/workflow-catalog.yaml` | 7 阶段流水线定义(由 `$help` 读取) |
| `docs/engine-reference/` | 锁定版本的引擎 API 快照——**使用引擎 API 前务必查阅** |
| `design/registry/entities.yaml` | 跨 GDD 的实体/物品/公式/常量注册表 |
| `docs/architecture/tr-registry.yaml` | GDD 技术需求的永久 TR-ID |
| `docs/WORKFLOW-GUIDE.md` | 端到端工作流走查 |

## 技能与代理

- 技能位于 `.agents/skills/<name>/SKILL.md`,以 `$name` 形式调用
  (如 `$brainstorm`、`$design-system`、`$create-stories`、`$dev-story`)
- 自定义代理位于 `.codex/agents/*.toml`;通过子代理派生(subagent
  spawning)并传入代理的 `name` 来委派。独立代理并行派生;进入有依赖的
  阶段前收齐所有结果;遇到 BLOCKED 的代理立即上报。
- Codex 不支持按技能固定模型层级。对于高风险的多文档综合类技能
  (`$review-all-gdds`、`$architecture-review`、`$gate-check`),
  建议在 `gpt-5.5` + 高推理强度的会话中运行。
- 按文件类型路由引擎专家:见 `.claude/docs/technical-preferences.md`
  中的表格(由 `$setup-engine` 填写)。
