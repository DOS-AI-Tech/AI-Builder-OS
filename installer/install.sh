#!/usr/bin/env bash
# Zero-dependency global installer for AI Coding Operating System.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCE="$REPO_DIR/ai-coding-os"
CONF="$SCRIPT_DIR/agents.conf"
ROOT="${AICOS_HOME:-$HOME/.ai-coding-os}"
VERSION="$(cat "$SOURCE/VERSION")"

[[ -f "$CONF" && -d "$SOURCE" ]] || { echo "ERROR: incomplete AI Coding OS package."; exit 1; }
echo "AI Coding OS $VERSION — global installation"
echo "Select the Agents that should receive the free framework and basic skills."

selected=()
exec 3<&0
while IFS='|' read -r id label unix_path windows_path; do
  [[ -z "$id" || "$id" == \#* ]] && continue
  read -r -p "  $label? [Y/n] " answer <&3
  if [[ -z "$answer" || "$answer" =~ ^[Yy]$ ]]; then selected+=("$id|$label|$unix_path"); fi
done < "$CONF"
[[ ${#selected[@]} -gt 0 ]] || { echo "No Agent selected. Aborted."; exit 1; }

rm -rf "$ROOT/framework.new"
mkdir -p "$ROOT/framework.new" "$ROOT/skills"
cp -R "$SOURCE/." "$ROOT/framework.new/"
rm -rf "$ROOT/framework"
mv "$ROOT/framework.new" "$ROOT/framework"

core="$ROOT/skills/ai-coding-os"
rm -rf "$core"
cp -R "$SOURCE/skills/ai-coding-os" "$core"
mkdir -p "$core/references" "$core/assets" "$core/scripts"
cp -R "$SOURCE/workflows" "$core/references/workflows"
cp -R "$SOURCE/templates" "$core/references/templates"
cp -R "$SOURCE/memory" "$core/assets/memory"
cp -R "$SOURCE/domain" "$core/assets/domain"
cp "$SOURCE/DASHBOARD.md" "$core/assets/DASHBOARD.md"
cp "$SCRIPT_DIR/init.sh" "$core/scripts/init-project.sh"
cp "$SCRIPT_DIR/init.ps1" "$core/scripts/init-project.ps1"

basic=(requirements-analyst architect project-manager test-engineer deployment-engineer)
for name in "${basic[@]}"; do
  rm -rf "$ROOT/skills/$name"
  cp -R "$SOURCE/skills/$name" "$ROOT/skills/$name"
done

: > "$ROOT/install-state.conf"
for item in "${selected[@]}"; do
  IFS='|' read -r id label rel <<< "$item"
  dest="$HOME/$rel"
  mkdir -p "$dest"
  for name in ai-coding-os "${basic[@]}"; do
    rm -rf "$dest/$name"
    cp -R "$ROOT/skills/$name" "$dest/$name"
  done
  echo "$id|$rel|$VERSION" >> "$ROOT/install-state.conf"
  echo "  ✓ $label"
done
printf '%s\n' "$VERSION" > "$ROOT/VERSION"
echo "Done. Run '$SCRIPT_DIR/init.sh /path/to/project' once per project."
