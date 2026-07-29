---
name: "session-restore"
description: "Recover work state from production/session-state/active.md at the start of a session or after a disruption. Replaces the Claude-side post-compact hook automation."
---

# Session Restore

Codex has no post-compact hook, so state recovery is **manual** with this
skill. (The SessionStart hook already previews `active.md` when it exists —
this skill performs the full recovery.)

## Workflow

### 1. Locate State

Read `production/session-state/active.md`.

If missing:
- Check `production/session-logs/session-log.md` for the most recent archived
  state (the Stop hook appends one at each session end)
- If neither exists: "No saved session state found. Run
  `$project-stage-detect` for a full project analysis instead." Stop.

### 2. Read Referenced Files

Read the files listed under **Files In Flight** in the state file. These
contain the actual decisions — the conversation history is secondary.

### 3. Summarize and Confirm

Present to the user:

```
=== Session State Recovered ===
Task: [current task and step from state file]
Progress: [N] done / [M] pending
Last saved: [timestamp]

Next action: [first unchecked progress item]

Continue from here?
```

Wait for user confirmation before resuming work. If the user wants something
else, discard the resume plan and follow their lead.

### 4. Resume

Continue from the confirmed next action. Update `active.md` (via
`$session-save`) after the next milestone.
