# Chezmoi Initial Setup — Fish + AgentsView

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Set up chezmoi-managed dotfiles with fish shell and agentsview as the first two managed tools.

**Architecture:** Repo root is the chezmoi source directory. Per-machine variables are prompted via `.chezmoi.yaml.tmpl`. Non-deployable files (docs, scripts) are excluded via `.chezmoiignore`. AgentsView service is auto-enabled via a chezmoi run script.

**Tech Stack:** Chezmoi v2.70+, Fish shell, systemd user services

---

### Task 1: Clean worktree — remove old files

Remove the leftover `.prettierrc` from the old repo structure. The `next` branch should start completely clean.

**Files:**
- Delete: `.prettierrc`

**Step 1: Remove the file**

```bash
cd ~/projects/wmaurer/dotfiles/.worktrees/dotfiles.next
git rm .prettierrc
```

**Step 2: Commit**

```bash
git commit -m "chore: remove leftover .prettierrc from old structure"
```

---

### Task 2: Chezmoi init template

Create the per-machine config template that prompts for profile, font_size, and scale_factor on first `chezmoi init`.

**Files:**
- Create: `.chezmoi.yaml.tmpl`

**Step 1: Create the template**

```yaml
{{- $profile := promptStringOnce . "profile" "Machine profile (work/personal/server)" -}}
{{- $fontSize := promptIntOnce . "font_size" "Font size (e.g. 12)" -}}
{{- $scaleFactor := promptStringOnce . "scale_factor" "Display scale factor (e.g. 1.0)" -}}

data:
  profile: {{ $profile | quote }}
  font_size: {{ $fontSize }}
  scale_factor: {{ $scaleFactor | quote }}
```

**Step 2: Verify template syntax**

```bash
cd ~/projects/wmaurer/dotfiles/.worktrees/dotfiles.next
chezmoi execute-template < .chezmoi.yaml.tmpl
```

Should prompt for values and output valid YAML.

**Step 3: Commit**

```bash
git add .chezmoi.yaml.tmpl
git commit -m "feat: add chezmoi init template for per-machine config"
```

---

### Task 3: Chezmoi ignore file

Create `.chezmoiignore` to exclude non-deployable files from being copied to `$HOME`, and to skip agentsview on server profile.

**Files:**
- Create: `.chezmoiignore`

**Step 1: Create the ignore file**

```
README.md
docs/**
scripts/**
LICENSE

{{ if eq .profile "server" }}
dot_config/systemd/user/agentsview.service
run_onchange_after_enable-agentsview.sh
{{ end }}
```

**Step 2: Commit**

```bash
git add .chezmoiignore
git commit -m "feat: add .chezmoiignore for docs exclusion and server profile gating"
```

---

### Task 4: AgentsView systemd service

Add the systemd user service file for agentsview.

**Files:**
- Create: `dot_config/systemd/user/agentsview.service`

**Step 1: Create the service file**

```ini
[Unit]
Description=AgentsView - AI agent session analytics dashboard
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
ExecStart=/usr/bin/agentsview
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
```

**Step 2: Commit**

```bash
git add dot_config/systemd/user/agentsview.service
git commit -m "feat: add agentsview systemd user service"
```

---

### Task 5: AgentsView auto-enable script

Create the chezmoi run script that enables and starts the agentsview service after `chezmoi apply`.

**Files:**
- Create: `run_onchange_after_enable-agentsview.sh`

**Step 1: Create the run script**

```bash
#!/bin/bash
# chezmoi:template: false
systemctl --user daemon-reload
systemctl --user enable --now agentsview.service
```

Must be executable (`chmod +x`).

**Step 2: Commit**

```bash
chmod +x run_onchange_after_enable-agentsview.sh
git add run_onchange_after_enable-agentsview.sh
git commit -m "feat: add run script to auto-enable agentsview service"
```

---

### Task 6: Fish shell config — templated

Port `config.fish` to a chezmoi template with per-profile gating.

**Files:**
- Create: `dot_config/fish/config.fish.tmpl`

**Step 1: Create the templated config**

The config is based on the existing `fish/config.fish` with these template sections:
- Desktop-only block (fastfetch greeting, kitty padding wrappers) gated with `{{ if ne .profile "server" }}`
- Everything else is shared across all profiles

```fish
if status is-interactive

{{ if ne .profile "server" }}
    function fish_greeting
        fastfetch --logo none
    end
{{ else }}
    set -g fish_greeting
{{ end }}

    # Vi key bindings
    fish_vi_key_bindings

    # Abbreviations
    abbr -a j jump
    abbr -a x exit
    abbr -a cdu cd-gitroot
    abbr -a o xdg-open
    abbr -a pnpmci "pnpm install --frozen-lockfile"
    abbr -a ghrc "gh repo clone"
    abbr -a dui lazydocker
    abbr -a nv "neovide &; disown"
    abbr -a lg lazygit

    # Direnv
    direnv hook fish | source

    # Disable directory underlining
    set fish_color_valid_path

    set --universal nvm_default_version v22

    # PATH
    set -x PNPM_HOME "~/.local/share/pnpm"
    set -x PATH $PNPM_HOME $PATH ~/.cargo/bin ~/.humanlog/bin ~/.local/bin

    # Merge history across sessions
    if not set --query fish_private_mode
        history merge
    end

    fzf --fish | source
    starship init fish | source

end

{{ if ne .profile "server" }}
# Apps that should run with no padding in kitty
set -g NO_PADDING_APPS vi vim nvim nano emacs helix lazygit

function run_with_no_padding
    set cmd $argv[1]
    kitty @ set-spacing padding=0
    command $cmd $argv[2..-1]
    kitty @ set-spacing padding=default
end

for app in $NO_PADDING_APPS
    function $app --inherit-variable app
        run_with_no_padding $app $argv
    end
end
{{ end }}
```

**Step 2: Verify template renders**

```bash
cd ~/projects/wmaurer/dotfiles/.worktrees/dotfiles.next
chezmoi execute-template < dot_config/fish/config.fish.tmpl
```

Should render valid fish config without template syntax.

**Step 3: Commit**

```bash
git add dot_config/fish/config.fish.tmpl
git commit -m "feat: add templated fish config with profile gating"
```

---

### Task 7: Fish functions — static files

Port the custom fish functions. These are static (no templating needed).

**Files:**
- Create: `dot_config/fish/functions/claude.fish`
- Create: `dot_config/fish/functions/fish_user_key_bindings.fish`
- Create: `dot_config/fish/functions/ghrcd.fish`
- Create: `dot_config/fish/functions/print-path.fish`

Skip `fisher.fish` and `fish_prompt.fish` — fisher is a plugin manager (installed at runtime) and the prompt function is managed by the hydro/starship plugin.

**Step 1: Copy each function file**

Copy content exactly from existing `fish/functions/` for: `claude.fish`, `fish_user_key_bindings.fish`, `ghrcd.fish`, `print-path.fish`.

**Step 2: Commit**

```bash
git add dot_config/fish/functions/
git commit -m "feat: add fish custom functions"
```

---

### Task 8: Fish completions and plugins list

Port the completions and `fish_plugins` file.

**Files:**
- Create: `dot_config/fish/fish_plugins`
- Create: `dot_config/fish/completions/` (copy all 8 completion files)

Skip `fisher.fish` completion — fisher manages its own completions at runtime.

**Step 1: Create fish_plugins**

```
jorgebucaran/fisher
jhillyerd/plugin-git
oh-my-fish/plugin-node-binpath
oh-my-fish/plugin-jump
mollifier/fish-cd-gitroot
nickeb96/puffer-fish
jorgebucaran/nvm.fish
catppuccin/fish
```

**Step 2: Copy completion files**

Copy from existing: `cd-gitroot.fish`, `git-extras.fish`, `jump.fish`, `nvm.fish`, `nx.fish`, `op.fish`, `pnpm.fish`. Skip `fisher.fish`.

**Step 3: Commit**

```bash
git add dot_config/fish/fish_plugins dot_config/fish/completions/
git commit -m "feat: add fish plugins list and completions"
```

---

### Task 9: Fisher install run script

Create a chezmoi run script that installs fisher (if not present) and then runs `fisher update` to install all plugins from the `fish_plugins` file.

**Files:**
- Create: `run_onchange_after_install-fisher-plugins.sh.tmpl`

**Step 1: Create the run script**

This script uses `fish -c` to run fish commands from a bash script. It checks if fisher is installed, installs it if missing, then runs `fisher update` to sync plugins from `fish_plugins`. The `onchange` in the filename means it only re-runs when the script content changes — and since we embed the `fish_plugins` hash in it, it also re-runs when plugins change.

```bash
#!/bin/bash
# chezmoi:template: true
# fish_plugins hash: {{ include "dot_config/fish/fish_plugins" | sha256sum }}

set -euo pipefail

echo "Ensuring fisher and plugins are installed..."

# Install fisher if not present
if ! fish -c 'type -q fisher' 2>/dev/null; then
    echo "Installing fisher..."
    fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
fi

# Install/update all plugins from fish_plugins
echo "Updating fisher plugins..."
fish -c 'fisher update'

echo "Fisher plugins up to date."
```

The `{{ include ... | sha256sum }}` comment is a chezmoi trick: when `fish_plugins` changes, the hash changes, the script content changes, and chezmoi re-runs it.

**Step 2: Commit**

```bash
chmod +x run_onchange_after_install-fisher-plugins.sh.tmpl
git add run_onchange_after_install-fisher-plugins.sh.tmpl
git commit -m "feat: add run script to auto-install fisher and plugins"
```

---

### Task 10: Bootstrap script

Create the setup script for new machines.

**Files:**
- Create: `scripts/setup-chezmoi.sh`

**Step 1: Create the script**

```bash
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
```

**Step 2: Commit**

```bash
chmod +x scripts/setup-chezmoi.sh
git add scripts/setup-chezmoi.sh
git commit -m "feat: add bootstrap script for new machine setup"
```

---

### Task 11: README and tool docs

Write the main README and per-tool documentation.

**Files:**
- Create: `README.md`
- Create: `docs/agentsview.md`
- Create: `docs/fish.md`

**Step 1: Write README.md**

Cover: what this repo is, quickstart (init + apply), profiles (work/personal/server), managed tools list, how to add a new tool, how to pull back live changes (`chezmoi re-add`).

**Step 2: Write docs/agentsview.md**

Cover: what AgentsView is, what's managed (service + auto-enable), useful systemctl/journalctl commands, skipped on server.

**Step 3: Write docs/fish.md**

Cover: what's configured (vi bindings, PATH, abbreviations, functions), per-profile differences, how to modify and pull back changes, fisher plugins list.

**Step 4: Commit**

```bash
git add README.md docs/agentsview.md docs/fish.md
git commit -m "docs: add README, agentsview and fish documentation"
```

---

### Task 12: Verify full chezmoi apply

End-to-end verification that everything works.

**Step 1: Dry-run with chezmoi diff**

```bash
chezmoi --source ~/projects/wmaurer/dotfiles/.worktrees/dotfiles.next diff
```

Should show the files that would be deployed — no errors, no unexpected paths.

**Step 2: Apply**

```bash
chezmoi --source ~/projects/wmaurer/dotfiles/.worktrees/dotfiles.next apply -v
```

Verify:
- `~/.config/fish/config.fish` exists and is rendered (no `{{` template syntax)
- `~/.config/fish/functions/` has the 4 custom functions
- `~/.config/fish/completions/` has the completion files
- `~/.config/systemd/user/agentsview.service` exists
- `systemctl --user status agentsview` shows active
