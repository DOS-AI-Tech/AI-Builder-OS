#!/usr/bin/env bash
# check-task-log.sh — Stop hook
#
# Runs automatically when a Claude Code session ends.
# Warns if files were modified but no task log was written today.
#
# Installation: registered in .claude/settings.json by init.sh.

TASK_LOG_DIR=".ai/memory/task-log"
TODAY=$(date +%Y-%m-%d)

# Only check inside a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    exit 0
fi

# Only warn if tracked files were modified
if git diff --quiet HEAD 2>/dev/null && git diff --quiet --cached 2>/dev/null; then
    exit 0
fi

# Check if today's task log exists (any file starting with today's date)
if ls "$TASK_LOG_DIR/$TODAY-"*.md 2>/dev/null | grep -q .; then
    exit 0
fi

echo ""
echo "WARNING: Task log missing for today ($TODAY)."
echo ""
echo "Before closing this session:"
echo "  1. Write $TASK_LOG_DIR/$TODAY-<slug>.md"
echo "     (use TEMPLATE.md as the format reference)"
echo "  2. Update .ai/memory/active/current-state.yaml"
echo "     (in_progress, recently_completed, known_issues, last_session)"
echo ""
echo "The next session depends on this record."
echo ""

exit 0  # warn only — blocking would fire on every response
