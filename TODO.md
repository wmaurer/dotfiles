# TODO

## humanlog

[humanlog](https://github.com/humanlogio/humanlog) is a CLI tool that prettifies structured logs (JSON/logfmt) from stdin. Also acts as a local observability platform — stores parsed logs in a local DB, supports querying, and ingests OpenTelemetry/OTLP traces (default: `http://localhost:4317`).

Install:
```sh
curl -sSL "https://humanlog.io/install.sh" | bash
```

Installs to `~/.humanlog/bin/humanlog` (already on PATH in config.fish).
