#!/bin/bash
set -euo pipefail

if ! command -v chezmoi &> /dev/null; then
    echo "chezmoi is not installed. Install it first (e.g., yay -S chezmoi)"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

chezmoi init --source "$REPO_DIR"
chezmoi diff
echo
read -p "Apply these changes? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    chezmoi apply
    echo "Done! Dotfiles applied."
else
    echo "Aborted. Run 'chezmoi apply' when ready."
fi
