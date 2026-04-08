# Fish shell

## What's configured

- **Vi key bindings** (`fish_vi_key_bindings`)
- **Abbreviations**: `j` (jump), `x` (exit), `cdu` (cd-gitroot), `o` (xdg-open), `pnpmci`, `ghrc` (gh repo clone), `dui` (lazydocker), `nv` (neovide), `lg` (lazygit)
- **Direnv** integration (hooked into shell)
- **fzf** integration (fuzzy finder)
- **History merge** across sessions
- **PATH**: adds `~/.local/share/pnpm`, `~/.cargo/bin`, `~/.humanlog/bin`, `~/.local/bin`
- **nvm** default version: v22

## Prompt

[Tide](https://github.com/ilancosman/tide) v6, installed via fisher. Replaces starship.

## Fisher plugins

Managed in `dot_config/fish/fish_plugins`. Chezmoi triggers `fisher update` whenever this file changes.

| Plugin | Purpose |
| --- | --- |
| `jorgebucaran/fisher` | Plugin manager |
| `ilancosman/tide@v6` | Prompt |
| `jhillyerd/plugin-git` | Git aliases |
| `oh-my-fish/plugin-node-binpath` | Node bin path |
| `oh-my-fish/plugin-jump` | Directory bookmarks |
| `mollifier/fish-cd-gitroot` | cd to git root |
| `nickeb96/puffer-fish` | `!!` and `!$` expansion |
| `jorgebucaran/nvm.fish` | Node version manager |
| `catppuccin/fish` | Catppuccin color theme |

## Per-profile differences

**Desktop (work / personal):**
- Greeting runs `fastfetch --logo none`
- Kitty no-padding wrappers for: vi, vim, nvim, nano, emacs, helix, lazygit

**Server:**
- Blank greeting (no fastfetch)
- No kitty padding wrappers

## Custom functions

| Function | Description |
| --- | --- |
| `claude.fish` | Launches Claude Code under bash (required for compatibility) |
| `fish_user_key_bindings.fish` | Ctrl-F accept char, Ctrl-L forward word, Ctrl-D delete char (triple Ctrl-D to exit) |
| `ghrcd.fish` | `gh repo clone` into an `org/repo` directory structure |
| `print-path.fish` | Prints each PATH entry on its own line |

## Modifying fish config

Edit in the chezmoi source directory, then apply:

```bash
# Edit the template
$EDITOR ~/dotfiles/dot_config/fish/config.fish.tmpl
chezmoi apply

# Or edit the live file and pull it back
$EDITOR ~/.config/fish/config.fish
chezmoi re-add ~/.config/fish/config.fish
```

Note: `config.fish` is a template — if you `re-add` it, you'll lose template logic. Prefer editing the source.

## Adding a fisher plugin

1. Add the plugin to `dot_config/fish/fish_plugins`
2. Run `chezmoi apply` — this triggers `fisher update` automatically
