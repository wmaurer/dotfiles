# dotfiles

Chezmoi-managed dotfiles for Manjaro Linux. Chezmoi copies files to their destinations (no symlinks). Templates (`.tmpl` files) are processed with Go template syntax at apply time.

## Quickstart

```bash
# 1. Install chezmoi
yay -S chezmoi

# 2. Clone this repo
git clone <repo-url> ~/dotfiles

# 3. Run the setup script
~/dotfiles/scripts/setup-chezmoi.sh
```

The setup script runs `chezmoi init`, shows a diff of what will change, and asks for confirmation before applying. It will prompt for machine profile and display settings on first run.

Manual alternative:

```bash
chezmoi init --source ~/dotfiles
chezmoi diff    # review changes
chezmoi apply   # apply changes
```

## Per-machine profiles

On first init, chezmoi prompts for a **profile** (`work`, `personal`, or `server`) and display settings. These are stored in `~/.config/chezmoi/chezmoi.yaml` and used to customize templates.

| Variable       | Example   | Used for                                      |
| -------------- | --------- | --------------------------------------------- |
| `profile`      | `work`    | Controls which tools/services are installed    |
| `font_size`    | `12`      | Font size in configs that need it              |
| `scale_factor` | `1.0`     | Display scaling in configs that need it        |

Profile differences:

- **work / personal** — Full desktop setup: fastfetch greeting, kitty no-padding wrappers, AgentsView service
- **server** — Minimal: blank greeting, no kitty wrappers, no AgentsView

## Managed tools

- **[Fish shell](docs/fish.md)** — vi bindings, abbreviations, direnv, fzf, Tide prompt via fisher
- **[AgentsView](docs/agentsview.md)** — systemd user service for AI agent session analytics (desktop only)

## Common operations

```bash
# See what chezmoi would change
chezmoi diff

# Apply all changes
chezmoi apply

# Pull a live config change back into the source
chezmoi re-add ~/.config/fish/config.fish

# Merge live changes interactively
chezmoi merge ~/.config/fish/config.fish
```

## Adding a new tool

1. Add config files under the appropriate `dot_config/` subdirectory (use chezmoi naming conventions: `dot_` prefix for dotfiles, `.tmpl` suffix for templates)
2. Commit to the repo
3. Run `chezmoi apply`
