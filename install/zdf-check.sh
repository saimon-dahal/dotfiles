
# ═══════════════════════════════════════════
# zdf-check.sh

#!/usr/bin/env bash
set -e

echo "→ Running system checks..."

if [[ ! -f /etc/arch-release ]]; then
    echo "⚠ Not an Arch-based system"
    read -p "Continue? (y/N): " -r
    [[ ! $REPLY =~ ^[Yy]$ ]] && exit 1
fi

if ! command -v git &> /dev/null; then
    echo "✗ git not found"
    exit 1
fi

echo "✓ System checks passed"
echo

