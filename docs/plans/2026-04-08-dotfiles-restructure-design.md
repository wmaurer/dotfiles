# Dotfiles Restructure Design

**Date:** 2026-04-08
**Status:** Approved

## Goal

Restructure the dotfiles repository using chezmoi for per-machine configuration management. Start with agentsview and fish shell, then incrementally add more tools.

## Decisions

### Deployment: Chezmoi (copy + template)

- Files are **copied** to target locations, not symlinked
- `.tmpl` files are rendered with per-machine variables before deployment
- Trade-off: requires `chezmoi re-add` to pull back live edits, but enables templating and per-machine variation

### Per-machine data model

Prompted once on `chezmoi init`, stored in `~/.config/chezmoi/chezmoi.yaml`:

```yaml
data:
  profile: work              # work | personal | server
  font_size: 12              # varies by display
  scale_factor: 1.0          # HiDPI scaling
```

- `profile` gates feature blocks (work-only, desktop-only)
- `font_size` and `scale_factor` are reserved for kitty/niri (future)

### Starting scope

Only two tools to get the structure right before scaling:

1. **Fish shell** — templated `config.fish`, static functions and completions
2. **AgentsView** — systemd user service file + auto-enable run script

## Repository structure

```
dotfiles/                              <- chezmoi source dir (repo root)
├── .chezmoi.yaml.tmpl                 <- per-machine prompts
├── .chezmoiignore                     <- excludes docs/scripts, gates server
├── README.md
├── docs/
│   ├── plans/                         <- design docs
│   ├── agentsview.md
│   └── fish.md
├── scripts/
│   └── setup-chezmoi.sh
├── dot_config/
│   ├── fish/
│   │   ├── config.fish.tmpl
│   │   ├── completions/
│   │   └── functions/
│   └── systemd/
│       └── user/
│           └── agentsview.service
└── run_onchange_after_enable-agentsview.sh
```

## Fish shell

- `config.fish.tmpl` — vi key bindings, PATH, abbreviations (shared); work-specific blocks gated with `{{ if eq .profile "work" }}`; GUI-related config (kitty padding, fastfetch) gated with `{{ if ne .profile "server" }}`
- `functions/` and `completions/` — carried over as static files from current config

## AgentsView

- `agentsview.service` — static systemd user service (same on all desktop machines)
- `run_onchange_after_enable-agentsview.sh` — runs `systemctl --user enable --now agentsview.service` after deploy; only re-runs when script content changes
- Skipped on server profile via `.chezmoiignore`

## Documentation

- **README.md** — overview, quickstart, profiles, how to add tools, how to pull back changes
- **docs/agentsview.md** — what it is, what's managed, useful commands
- **docs/fish.md** — what's configured, per-machine differences, how to modify

## Bootstrap

`scripts/setup-chezmoi.sh` — validates chezmoi is installed, runs `chezmoi init` + `chezmoi apply`. Does not install chezmoi itself (package managers differ across machines).
