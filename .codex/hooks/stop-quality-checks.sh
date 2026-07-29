#!/bin/bash
# Codex Stop hook: end-of-turn quality checks
#
# Codex PostToolUse fires for shell commands only, so the Claude-side
# per-write validations (validate-assets.sh, validate-skill-change.sh)
# cannot run on file edits. This hook runs their checks at Stop time
# against files modified in the last 60 minutes:
#   - assets/: naming convention + JSON validity (from validate-assets.sh)
#   - .agents/skills/: advises $skill-test after skill changes
#     (from validate-skill-change.sh, pointed at the Codex skill tree)
#
# Advisory only — always exit 0.

WARNINGS=""

# --- Assets: files modified in the last 60 minutes ---
if [ -d "assets" ]; then
    RECENT_ASSETS=$(find assets -type f -mmin -60 2>/dev/null)
    if [ -n "$RECENT_ASSETS" ]; then
        PYTHON_CMD=""
        for cmd in python python3 py; do
            if command -v "$cmd" >/dev/null 2>&1; then
                PYTHON_CMD="$cmd"
                break
            fi
        done

        while IFS= read -r file; do
            filename=$(basename "$file")
            if echo "$filename" | grep -qE '[A-Z[:space:]-]'; then
                WARNINGS="$WARNINGS\n  NAMING: $file must be lowercase with underscores (got: $filename)"
            fi
            if echo "$file" | grep -qE '(^|/)assets/data/.*\.json$'; then
                if [ -n "$PYTHON_CMD" ] && ! "$PYTHON_CMD" -m json.tool "$file" > /dev/null 2>&1; then
                    WARNINGS="$WARNINGS\n  FORMAT: $file is not valid JSON — fix before committing"
                fi
            fi
        done <<< "$RECENT_ASSETS"
    fi
fi

# --- Skills: .agents/skills/ files modified in the last 60 minutes ---
RECENT_SKILLS=$(find .agents/skills -type f -mmin -60 -name "SKILL.md" 2>/dev/null)
if [ -n "$RECENT_SKILLS" ]; then
    while IFS= read -r file; do
        skill_name=$(echo "$file" | grep -oE '\.agents/skills/[^/]+' | sed 's|\.agents/skills/||')
        if [ -n "$skill_name" ]; then
            WARNINGS="$WARNINGS\n  SKILL: $skill_name modified — run \$skill-test static $skill_name to validate"
        fi
    done <<< "$RECENT_SKILLS"
fi

if [ -n "$WARNINGS" ]; then
    echo -e "=== Stop-time Quality Checks (advisory) ===$WARNINGS\n===========================================" >&2
fi

exit 0
