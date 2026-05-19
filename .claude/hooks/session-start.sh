#!/bin/bash
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Install sqlfluff for SQL linting
pip install --quiet sqlfluff 2>&1 | tail -5
