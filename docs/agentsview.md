# AgentsView

AgentsView is a local web dashboard for AI agent session analytics — tracks sessions from Claude Code, Codex, Copilot CLI, and similar tools.

**URL:** http://127.0.0.1:8080

## What chezmoi manages

- **Systemd user service** (`~/.config/systemd/user/agentsview.service`) — runs `/usr/bin/agentsview` as a user service
- **Auto-enable run script** — reloads systemd and enables the service on `chezmoi apply`

The service starts automatically on login (`WantedBy=default.target`) and restarts on failure with a 5-second delay.

Skipped entirely on the `server` profile (via `.chezmoiignore`).

## Useful commands

```bash
# Check status
systemctl --user status agentsview

# Restart the service
systemctl --user restart agentsview

# Stop the service
systemctl --user stop agentsview

# View logs
journalctl --user -u agentsview
```

## Updating AgentsView

Update the binary, then restart the service:

```bash
agentsview update
systemctl --user restart agentsview
```
