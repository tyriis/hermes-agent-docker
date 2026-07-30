FROM docker.io/nousresearch/hermes-agent:v2026.7.20@sha256:f7b35053268f532f98955195c909f15a230470fbcbdacaa9fdecb95707dad04a

# Pre-bake fal-client so lazy_deps.py's _is_satisfied("fal-client==0.13.1")
# returns True at runtime, skipping the lazy-install (which would fail
# on readOnlyRootFilesystem: true in K8s).
# Using uv (already in the image from astral-sh/uv) instead of pip bootstrap.
# Match the exact version pinned in tools/lazy_deps.py and pyproject.toml.
RUN uv pip install --no-cache-dir 'fal-client==0.13.1' 'firecrawl-py==4.17.0'
