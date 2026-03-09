# TODO

## Neovim AI plugins (prompt editing in nvim)

`claudecode.nvim` embeds the Claude Code CLI in a terminal split — prompts are typed in the CLI, not a real nvim buffer.

Alternatives with native nvim buffer for prompt crafting:

| Plugin | Language | Stars (early 2026) | Notes |
|---|---|---|---|
| `avante.nvim` | Lua + Rust | ~17,400 | Most popular; Cursor-like; requires build step |
| `codecompanion.nvim` | Pure Lua | ~6,200 | Stable, configurable, no build step |
| `gp.nvim` | Pure Lua | fewer | Simpler |

## humanlog

[humanlog](https://github.com/humanlogio/humanlog) is a CLI tool that prettifies structured logs (JSON/logfmt) from stdin. Also acts as a local observability platform — stores parsed logs in a local DB, supports querying, and ingests OpenTelemetry/OTLP traces (default: `http://localhost:4317`).

Install:
```sh
curl -sSL "https://humanlog.io/install.sh" | bash
```

Installs to `~/.humanlog/bin/humanlog` (already on PATH in config.fish).
