FROM docker.io/nousresearch/hermes-agent:v2026.8.16@sha256:f8f548d87d16634d1ad9e3777280f3f577ba2358703f04e18e74007ffd3621bf

# Pre-bake fal-client so lazy_deps.py's _is_satisfied("fal-client==0.13.1")
# returns True at runtime, skipping the lazy-install (which would fail
# on readOnlyRootFilesystem: true in K8s).
# Using uv (already in the image from astral-sh/uv) instead of pip bootstrap.
# Match the exact version pinned in tools/lazy_deps.py and pyproject.toml.
RUN uv pip install --no-cache-dir 'fal-client==0.13.1' 'firecrawl-py==4.17.0'
