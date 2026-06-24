#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
PACK="$TMP/paid-pack"
mkdir -p "$PACK"
cat > "$PACK/SKILL.md" <<'EOF'
---
name: test-paid-skill
description: Temporary fixture used only by the installer test.
tier: advanced
requires: [ai-builder-os]
---
# Test Paid Skill
EOF

if HOME="$TMP/no-framework" AIBOS_HOME="$TMP/no-framework/.ai-builder-os" bash "$SCRIPT_DIR/install-skill.sh" test-paid-skill "$PACK" >/dev/null 2>&1; then
  echo "FAIL: paid skill installed without framework"; exit 1
fi
mkdir -p "$TMP/home"
printf 'y\nn\nn\nn\nn\n' | HOME="$TMP/home" AIBOS_HOME="$TMP/home/.ai-builder-os" bash "$SCRIPT_DIR/install.sh" >/dev/null
for name in ai-builder-os requirements-analyst architect project-manager test-engineer deployment-engineer; do
  test -f "$TMP/home/.claude/skills/$name/SKILL.md"
done
printf 'y\n' | HOME="$TMP/home" AIBOS_HOME="$TMP/home/.ai-builder-os" bash "$SCRIPT_DIR/install-skill.sh" test-paid-skill "$PACK" >/dev/null
test -f "$TMP/home/.claude/skills/test-paid-skill/SKILL.md"
mkdir -p "$TMP/project"
HOME="$TMP/home" AIBOS_HOME="$TMP/home/.ai-builder-os" bash "$SCRIPT_DIR/init.sh" "$TMP/project" >/dev/null
test -f "$TMP/project/.ai/memory/frozen/architecture.yaml"
test -f "$TMP/project/domain/README.md"
test ! -d "$TMP/project/.ai/skills"
echo "✓ installation tests passed"
