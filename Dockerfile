FROM docker.io/nousresearch/hermes-agent:v2026.8.31@sha256:64923faeae267792bf9bf87fe3b4c4869e35004e360c7df01730ad801b74d524

# Pre-bake fal-client so lazy_deps.py's _is_satisfied("fal-client==0.13.1")
# returns True at runtime, skipping the lazy-install (which would fail
# on readOnlyRootFilesystem: true in K8s).
# Using uv (already in the image from astral-sh/uv) instead of pip bootstrap.
# Match the exact version pinned in tools/lazy_deps.py and pyproject.toml.
RUN uv pip install --no-cache-dir 'fal-client==0.13.1' 'firecrawl-py==4.17.0'
