#!/bin/bash
# scripts/install-hooks.sh
# Purpose: Configure Git to use hooks from .githooks/ directory
# Usage: bash scripts/install-hooks.sh
# Run this once after cloning the repository

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}🔧 Installing Git hooks...${NC}"
echo ""

# Verify we are in a Git repository
if ! git rev-parse --git-dir &>/dev/null; then
    echo -e "${RED}❌ Not a Git repository${NC}"
    echo "   Run this script from the project root directory"
    exit 1
fi

# Configure Git to use .githooks/ as the hooks directory
# This is the modern approach (Git 2.9+) - no copying needed
git config core.hooksPath .githooks

echo -e "${GREEN}✅ Git hooks path set to .githooks/${NC}"

# Verify hooks are executable
HOOKS=(".githooks/pre-commit" ".githooks/commit-msg" ".githooks/pre-push")

for hook in "${HOOKS[@]}"; do
    if [[ -f "${hook}" ]]; then
        chmod +x "${hook}"
        echo -e "${GREEN}✅ ${hook} — executable${NC}"
    else
        echo -e "${RED}❌ ${hook} — not found${NC}"
    fi
done

echo ""
echo -e "${GREEN}✅ Git hooks installed successfully${NC}"
echo ""
echo "Hooks active:"
echo "  pre-commit  — ShellCheck, yamllint, secret detection, file size"
echo "  commit-msg  — Conventional Commits format enforcement"
echo "  pre-push    — Block direct push to main/master"
echo ""
echo "To verify: git config core.hooksPath"
