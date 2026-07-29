---
name: "session-save"
description: "Save current work state to production/session-state/active.md. Run before ending a session, switching tasks, or after any significant milestone. Replaces the Claude-side pre-compact hook automation."
---

# Session Save

Codex has no pre-compact hook, so session state is saved **manually** with this
skill. The file is the memory, not the conversation —
`production/session-state/active.md` persists across sessions and crashes.

## When to Run

- Before ending a work session
- Before switching to an unrelated task
- After each significant milestone: design section approved, architecture
  decision made, implementation milestone reached, test results obtained

## Workflow

### 1. Gather Current State

Collect from the conversation:

- **Current task**: what is being worked on, and which step we are on
- **Progress checklist**: what is done vs. pending
- **Key decisions**: decisions made this session and their rationale
- **Files in flight**: files created/modified this session and their purpose
- **Open questions**: blockers or questions awaiting user input
- **Active sprint task**: current story/epic IDs if a sprint is active

### 2. Show Draft and Ask Approval

Present the proposed `active.md` content to the user:
"May I write this session state to `production/session-state/active.md`?"

### 3. Write the State File

Format:

```markdown
# Active Session State

**Saved**: [date time]
**Task**: [current task and step]
**Sprint/Story**: [IDs or "none"]

## Progress
- [x] [completed item]
- [ ] [pending item]

## Key Decisions
- [decision] — [rationale]

## Files In Flight
- `[path]` — [purpose / status]

## Open Questions
- [question or "none"]

## Resume Instructions
Read this file, then read the files listed above. Continue from the first
unchecked progress item.
```

### 4. Confirm

Report: "Session state saved. Run `$session-restore` in your next session to
continue where you left off."
