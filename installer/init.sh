#!/usr/bin/env bash
# Lightweight per-project initialization. Global skills are not copied here.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="$(cd "$SCRIPT_DIR/.." && pwd)/ai-builder-os"
TARGET="${1:-$(pwd)}"; TARGET="$(cd "$TARGET" && pwd)"
[[ -f "${AIBOS_HOME:-$HOME/.ai-builder-os}/VERSION" ]] || { echo "ERROR: install the free global framework first."; exit 1; }
mkdir -p "$TARGET/.ai/memory/frozen" "$TARGET/.ai/memory/slow" "$TARGET/.ai/memory/active/work-items" "$TARGET/.ai/memory/task-log" "$TARGET/domain" "$TARGET/project_docs"
copy_new() { [[ -e "$2" ]] || cp "$1" "$2"; }
copy_new "$SOURCE/memory/frozen/architecture.yaml" "$TARGET/.ai/memory/frozen/architecture.yaml"
copy_new "$SOURCE/memory/frozen/deployment.yaml" "$TARGET/.ai/memory/frozen/deployment.yaml"
copy_new "$SOURCE/memory/slow/file-index.yaml" "$TARGET/.ai/memory/slow/file-index.yaml"
copy_new "$SOURCE/memory/active/current-state.yaml" "$TARGET/.ai/memory/active/current-state.yaml"
copy_new "$SOURCE/memory/active/work-items/TEMPLATE.md" "$TARGET/.ai/memory/active/work-items/TEMPLATE.md"
copy_new "$SOURCE/memory/task-log/TEMPLATE.md" "$TARGET/.ai/memory/task-log/TEMPLATE.md"
copy_new "$SOURCE/domain/README.md" "$TARGET/domain/README.md"
copy_new "$SOURCE/DASHBOARD.md" "$TARGET/DASHBOARD.md"

while IFS='|' read -r id rel version; do
  case "$id" in
    claude-code) copy_new "$SOURCE/tool-rules/CLAUDE.md" "$TARGET/CLAUDE.md" ;;
    codex) copy_new "$SOURCE/tool-rules/AGENTS.md" "$TARGET/AGENTS.md" ;;
    github-copilot) mkdir -p "$TARGET/.github"; copy_new "$SOURCE/tool-rules/copilot-instructions.md" "$TARGET/.github/copilot-instructions.md" ;;
    cursor) mkdir -p "$TARGET/.cursor/rules"; copy_new "$SOURCE/tool-rules/cursor/workflow-governance.mdc" "$TARGET/.cursor/rules/workflow-governance.mdc" ;;
    qoder) mkdir -p "$TARGET/.qoder/rules"; copy_new "$SOURCE/tool-rules/qoder/workflow-governance.md" "$TARGET/.qoder/rules/workflow-governance.md" ;;
  esac
done < "${AIBOS_HOME:-$HOME/.ai-builder-os}/install-state.conf"
echo "✓ Project initialized at $TARGET (global skills were not copied)."
