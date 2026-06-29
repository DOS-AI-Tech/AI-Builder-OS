#!/usr/bin/env bash
# upgrade.sh — Update AI Coding Operating System framework files without cloning the repo.
#
# Run from your project root with one command:
#
#   curl -fsSL https://raw.githubusercontent.com/DOS-AI-Tech/AI-Coding-OS/main/installer/upgrade.sh | bash
#
# Or download first, inspect, then run:
#
#   curl -O https://raw.githubusercontent.com/DOS-AI-Tech/AI-Coding-OS/main/installer/upgrade.sh
#   bash upgrade.sh
#
# What this does:
#   1. Downloads the latest framework tarball from GitHub
#   2. Extracts to a temp directory
#   3. Runs update.sh — refreshes the global free framework
#   4. Removes the temp directory
#
# What is never touched: .ai/memory/, process files, .claude/settings.json

set -e

REPO="DOS-AI-Tech/AI-Coding-OS"
BRANCH="main"
TARBALL_URL="https://github.com/$REPO/archive/refs/heads/$BRANCH.tar.gz"
TMP_DIR="$(mktemp -d)"

cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

echo ""
echo "Downloading AI Coding Operating System ($BRANCH)..."
curl -fsSL "$TARBALL_URL" | tar xz -C "$TMP_DIR" --strip-components=1

bash "$TMP_DIR/installer/update.sh"
