# GTR-demo

Parent repo for running [GTR](GTR/) (Gated Token Recurrence for Efficient Dense Prediction) via repo-root shell scripts. Application code lives in Git submodules; this repo holds orchestration and config only.

## Layout

| Path | What |
|------|------|
| `GTR/` | Upstream GTR model, training and inference code (submodule, read-only) |
| `demo-wrapper-only/` | Stack orchestration pattern: `install.sh` → `run-{PORT}.sh` → `log-status.sh` (submodule, read-only) |

## Quick Start

1. `git submodule update --init --recursive`
2. Add `.env` if needed (see `demo-wrapper-only/README.md`)
3. `./install.sh` → `./run-3000.sh` → `./log-status.sh`

## Docs

- Model, configs, weights: [GTR/README.md](GTR/README.md)
- Ops pattern: [demo-wrapper-only/README.md](demo-wrapper-only/README.md)
- Agent instructions: [AGENTS.md](AGENTS.md)
