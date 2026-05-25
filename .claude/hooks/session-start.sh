#!/bin/bash
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Install sqlfluff for SQL linting
pip install --quiet sqlfluff 2>&1 | tail -5

# Install caveman Claude Code plugin
curl -fsSL https://raw.githubusercontent.com/JuliusBrussee/caveman/main/install.sh | bash

# Install Playwright for webapp-testing skill (browser binary requires network access to download)
pip install --quiet playwright 2>&1 | tail -3

# Install awesome-claude-skills (web dev + data analysis)
SKILLS_DIR="$HOME/.claude/skills"
SKILLS_REPO="/tmp/awesome-claude-skills"
if [ ! -d "$SKILLS_REPO" ]; then
  git clone --depth=1 https://github.com/ComposioHQ/awesome-claude-skills "$SKILLS_REPO" --quiet
fi
mkdir -p "$SKILLS_DIR"
cp -r "$SKILLS_REPO/webapp-testing" "$SKILLS_DIR/"
cp -r "$SKILLS_REPO/artifacts-builder" "$SKILLS_DIR/"
cp -r "$SKILLS_REPO/developer-growth-analysis" "$SKILLS_DIR/"
