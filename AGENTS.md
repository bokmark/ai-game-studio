# Game Studio — Codex Agent Instructions

Indie game development managed through 49 coordinated custom agents.
Each agent owns a specific domain, enforcing separation of concerns and quality.

> **Dual-platform project**: this repo supports both Codex and Claude Code.
> Codex reads this file, `.codex/`, and `.agents/skills/`. The `.claude/` tree
> is the Claude Code mirror — do not edit it from Codex sessions unless
> explicitly asked. Shared content (docs, templates, registries) lives in
> `.claude/docs/` and is read-only reference for both platforms.

## Technology Stack

- **Engine**: [CHOOSE: Godot 4 / Unity / Unreal Engine 5]
- **Language**: [CHOOSE: GDScript / C# / C++ / Blueprint]
- **Version Control**: Git with trunk-based development
- **Build System**: [SPECIFY after choosing engine]
- **Asset Pipeline**: [SPECIFY after choosing engine]

> **Note**: Engine-specialist agents exist for Godot, Unity, and Unreal with
> dedicated sub-specialists. Use the set matching your engine.

## Repository Layout

```text
/
├── AGENTS.md / CLAUDE.md      # Codex / Claude entry points
├── .codex/                    # Codex: agents/*.toml, hooks.json, config.toml
├── .agents/skills/            # Codex skills (invoke as $skill-name)
├── .claude/                   # Claude Code mirror (agents, skills, hooks, rules, docs)
├── src/                       # Game source code (core, gameplay, ai, networking, ui, tools)
├── assets/                    # Game assets (art, audio, vfx, shaders, data)
├── design/                    # GDDs, narrative, levels, balance + registry/entities.yaml
├── docs/                      # Technical docs, ADRs, engine-reference/ API snapshots
├── tests/                     # Test suites (unit, integration, performance, playtest)
├── tools/                     # Build and pipeline tools
├── prototypes/                # Throwaway prototypes (isolated from src/)
└── production/                # Sprints, milestones, releases, session-state/
```

## Studio Hierarchy

```text
Tier 1 — Directors (gpt-5.5, high effort)
  creative-director    technical-director    producer

Tier 2 — Department Leads (gpt-5.6-terra, medium effort)
  game-designer        lead-programmer       art-director
  audio-director       narrative-director    qa-lead
  release-manager      localization-lead

Tier 3 — Specialists (gpt-5.6-terra; fast lookups use gpt-5.6-luna)
  gameplay-programmer  engine-programmer     ai-programmer
  network-programmer   tools-programmer      ui-programmer
  systems-designer     level-designer        economy-designer
  technical-artist     sound-designer        writer
  world-builder        ux-designer           prototyper
  performance-analyst  devops-engineer       analytics-engineer
  security-engineer    qa-tester             accessibility-specialist
  live-ops-designer    community-manager     + engine specialists
```

## Coordination Rules

1. **Vertical delegation** — directors delegate to leads, leads to specialists.
2. **Horizontal consultation** — same-tier agents consult but make no binding
   cross-domain decisions.
3. **Conflict resolution** — escalate to the shared parent; `creative-director`
   for design conflicts, `technical-director` for technical ones.
4. **Change propagation** — cross-department changes coordinated by `producer`.
5. **Domain boundaries** — agents never modify files outside their domain
   without explicit delegation.

Full detail: `.claude/docs/coordination-rules.md` (shared reference).

## Collaboration Protocol

**User-driven collaboration, not autonomous execution.**
Every task follows: **Question -> Options -> Decision -> Draft -> Approval**

- Agents MUST ask "May I write this to [filepath]?" before writing files
- Agents MUST show drafts or summaries before requesting approval
- Multi-file changes require explicit approval for the full changeset
- No commits without user instruction

> **First session?** If the project has no engine configured and no game
> concept, run `$start` to begin the guided onboarding flow.

## Coding Standards (Summary)

- Doc comments on public APIs; every system gets an ADR in `docs/architecture/`
- Gameplay values data-driven (external config), never hardcoded
- Dependency injection over singletons; public methods unit-testable
- Conventional Commits (`feat:`/`fix:`/`chore:`/`docs:`/`test:`/`refactor:`)
  referencing story/task IDs
- Verification-driven development: tests first for gameplay systems;
  screenshots for UI changes
- GDDs require 8 sections (Overview, Player Fantasy, Detailed Rules, Formulas,
  Edge Cases, Dependencies, Tuning Knobs, Acceptance Criteria)

Full standards + test evidence rules: `.claude/docs/coding-standards.md`

## Context & Session State

**The file is the memory, not the conversation.** Maintain
`production/session-state/active.md` as a living checkpoint (current task,
progress, key decisions, files in flight, open questions). Update it after
every milestone.

- Save state: run `$session-save` before ending a session or switching tasks
- Recover state: run `$session-restore` (or read `active.md`) at session start
- Write multi-section documents incrementally: skeleton first, one approved
  section at a time

## Document Map (read on demand)

| Path | Read when |
|------|-----------|
| `.claude/docs/technical-preferences.md` | Engine/platform/naming/performance config — written by `$setup-engine`, check before engine work |
| `.claude/docs/coordination-rules.md` | Full delegation, parallelism, and tier rules |
| `.claude/docs/coding-standards.md` | Full coding/testing/CI standards |
| `.claude/docs/templates/` | 41 document templates (GDD, ADR, sprint, UX, QA) |
| `.claude/docs/workflow-catalog.yaml` | 7-phase pipeline definition (read by `$help`) |
| `docs/engine-reference/` | Version-pinned engine API snapshots — **always check before using engine APIs** |
| `design/registry/entities.yaml` | Cross-GDD entity/item/formula/constant registry |
| `docs/architecture/tr-registry.yaml` | Permanent TR-IDs for GDD technical requirements |
| `docs/WORKFLOW-GUIDE.md` | End-to-end workflow walkthrough |

## Skills and Agents

- Skills live in `.agents/skills/<name>/SKILL.md`, invoked as `$name`
  (e.g., `$brainstorm`, `$design-system`, `$create-stories`, `$dev-story`)
- Custom agents live in `.codex/agents/*.toml`; delegate via subagent spawning
  with the agent's `name`. Spawn independent agents in parallel; collect all
  results before dependent phases; surface BLOCKED agents immediately.
- Skill model tiers are not pinnable per-skill in Codex. For high-stakes
  synthesis skills (`$review-all-gdds`, `$architecture-review`, `$gate-check`),
  prefer running the session on `gpt-5.5` with high reasoning effort.
- Engine specialist routing by file type: see the table in
  `.claude/docs/technical-preferences.md` (populated by `$setup-engine`).
