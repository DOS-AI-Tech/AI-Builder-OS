#!/usr/bin/env bash
# Install a purchased skill pack globally. The free framework is mandatory.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="${AICOS_HOME:-$HOME/.ai-coding-os}"
CONF="$SCRIPT_DIR/agents.conf"
name="${1:-}"
pack="${2:-}"
[[ -n "$name" ]] || { echo "Usage: install-skill.sh <skill-name> [pack-dir]"; exit 1; }
[[ -n "$pack" ]] || pack="$(cd "$SCRIPT_DIR/.." && pwd)/skill-packs/$name"
[[ -f "$pack/SKILL.md" ]] || { echo "ERROR: $pack/SKILL.md not found."; exit 1; }
[[ -f "$ROOT/install-state.conf" ]] || { echo "ERROR: free AI Coding OS framework is required. Install it first."; exit 1; }

eligible=()
while IFS='|' read -r id rel version; do
  [[ -f "$HOME/$rel/ai-coding-os/SKILL.md" ]] && eligible+=("$id|$rel")
done < "$ROOT/install-state.conf"
[[ ${#eligible[@]} -gt 0 ]] || { echo "ERROR: no Agent has the free framework. Paid skill installation stopped."; exit 1; }

for item in "${eligible[@]}"; do
  IFS='|' read -r id rel <<< "$item"
  label="$(awk -F'|' -v wanted="$id" '$1==wanted {print $2}' "$CONF")"
  read -r -p "  Install '$name' for $label? [Y/n] " answer
  [[ -n "$answer" && ! "$answer" =~ ^[Yy]$ ]] && continue
  mkdir -p "$HOME/$rel/$name"
  rm -rf "$HOME/$rel/$name"
  cp -R "$pack" "$HOME/$rel/$name"
  echo "  ✓ $label"
done
echo "Done. Paid skill '$name' installed; the free framework was not modified."
