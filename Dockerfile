FROM docker.io/nousresearch/hermes-agent:v2026.6.19@sha256:9f367c7756ef087661a361536a89f438d57a122b958dc23d82d456b1433e6e9e

# Pre-bake fal-client so lazy_deps.py's _is_satisfied("fal-client==0.13.1")
# returns True at runtime, skipping the lazy-install (which would fail
# on readOnlyRootFilesystem: true in K8s).
# Using uv (already in the image from astral-sh/uv) instead of pip bootstrap.
# Match the exact version pinned in tools/lazy_deps.py and pyproject.toml.
RUN uv pip install --no-cache-dir 'fal-client==0.13.1' 'firecrawl-py==4.17.0'
