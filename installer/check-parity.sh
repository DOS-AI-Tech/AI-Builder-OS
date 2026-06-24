#!/usr/bin/env bash
# check-parity.sh — Validate five-environment rule parity.
#
# Extracts and normalizes section headings from all five tool-rule files,
# then reports which rule categories exist in one file but not others.
#
# Usage (from repo root):
#   bash installer/check-parity.sh

set -e

CLAUDE="ai-builder-os/tool-rules/CLAUDE.md"
AGENTS="ai-builder-os/tool-rules/AGENTS.md"
COPILOT="ai-builder-os/tool-rules/copilot-instructions.md"
CURSOR="ai-builder-os/tool-rules/cursor/workflow-governance.mdc"
QODER="ai-builder-os/tool-rules/qoder/workflow-governance.md"

for f in "$CLAUDE" "$AGENTS" "$COPILOT" "$CURSOR" "$QODER"; do
    [[ -f "$f" ]] || { echo "ERROR: $f not found"; exit 1; }
done

# Normalize a heading: lowercase, remove suffixes, collapse whitespace
normalize() {
    echo "$1" \
    | tr '[:upper:]' '[:lower:]' \
    | sed 's/ — required.*//; s/ — mandatory.*//; s/ tasks$//; s/ task$//; s/[^a-z0-9 ]//g' \
    | sed 's/  */ /g; s/^ //; s/ $//'
}

extract_normalized() {
    local file="$1"
    while IFS= read -r line; do
        heading="${line#\#\# }"
        normalize "$heading"
    done < <(grep "^## " "$file") | sort -u
}

norm_claude=$(extract_normalized "$CLAUDE")
norm_agents=$(extract_normalized "$AGENTS")
norm_copilot=$(extract_normalized "$COPILOT")
norm_cursor=$(extract_normalized "$CURSOR")
norm_qoder=$(extract_normalized "$QODER")

all=$(printf "%s\n%s\n%s\n%s\n%s\n" "$norm_claude" "$norm_agents" "$norm_copilot" "$norm_cursor" "$norm_qoder" \
      | sort -u | grep -v '^$')

errors=0

echo "Checking five-environment parity (normalized headings)..."
echo ""

while IFS= read -r norm; do
    in_claude=$(echo  "$norm_claude"  | grep -Fx "$norm" || true)
    in_agents=$(echo  "$norm_agents"  | grep -Fx "$norm" || true)
    in_copilot=$(echo "$norm_copilot" | grep -Fx "$norm" || true)
    in_cursor=$(echo  "$norm_cursor"  | grep -Fx "$norm" || true)
    in_qoder=$(echo   "$norm_qoder"   | grep -Fx "$norm" || true)

    missing=""
    [[ -z "$in_claude"  ]] && missing="$missing CLAUDE.md"
    [[ -z "$in_agents"  ]] && missing="$missing AGENTS.md"
    [[ -z "$in_copilot" ]] && missing="$missing copilot-instructions.md"
    [[ -z "$in_cursor"  ]] && missing="$missing workflow-governance.mdc"
    [[ -z "$in_qoder"   ]] && missing="$missing workflow-governance.md"

    if [[ -n "$missing" ]]; then
        echo "  MISSING '$norm' in:$missing"
        errors=$((errors + 1))
    fi
done <<< "$all"

echo ""
if [[ $errors -eq 0 ]]; then
    echo "✓ All rule categories present in all five files."
else
    echo "✗ $errors parity issue(s). Add the missing sections before committing."
    exit 1
fi
