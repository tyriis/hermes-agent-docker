FROM docker.io/nousresearch/hermes-agent:v2026.8.18@sha256:22e37bb4ed1b0f50cb6bd991dca7ecacd6c9f29df9b4a20fc989d32bc763ccf6

# Pre-bake fal-client so lazy_deps.py's _is_satisfied("fal-client==0.13.1")
# returns True at runtime, skipping the lazy-install (which would fail
# on readOnlyRootFilesystem: true in K8s).
# Using uv (already in the image from astral-sh/uv) instead of pip bootstrap.
# Match the exact version pinned in tools/lazy_deps.py and pyproject.toml.
RUN uv pip install --no-cache-dir 'fal-client==0.13.1' 'firecrawl-py==4.17.0'
