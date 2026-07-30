# hermes-docker

Extends the upstream [`hermes-agent`](https://github.com/NousResearch/hermes-agent) image to pre-bake Python dependencies that `lazy_deps.py` would otherwise install at runtime.

## Why

My Kubernetes cluster enforces `readOnlyRootFilesystem: true`. The agent's lazy-install mechanism tries to `pip install` into the container filesystem at startup and fails.

This image pre-installs those deps via `uv pip install` at build time, so `_is_satisfied()` returns `True` at runtime and the lazy step is skipped.

## Packages pre-installed

- `fal-client==0.13.1`
- `firecrawl-py==4.17.0`

(Taken from `tools/lazy_deps.py` and `pyproject.toml` in the upstream repo.)

## Usage

```bash
docker build -t hermes-agent-prebaked:latest .
```

Then use `hermes-agent-prebaked` in your Kubernetes deployment or `docker run` instead of the upstream image.

## Updating

When a new upstream release ships, update the `FROM` digest and sync the pinned versions from the upstream repo's `pyproject.toml` / `tools/lazy_deps.py`.
