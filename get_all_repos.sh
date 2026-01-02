#!/usr/bin/env bash
set -euo pipefail

REPOS_FILE="${1:-Repos.txt}"
TARGET_DIR="${2:-.}"

if [ ! -f "$REPOS_FILE" ]; then
    echo "Repos file '$REPOS_FILE' not found" >&2
    exit 1
fi

mkdir -p "$TARGET_DIR"

while IFS= read -r raw || [ -n "$raw" ]; do
    # strip comments and CR, trim whitespace
    line="${raw%%#*}"
    line="$(printf '%s' "$line" | tr -d '\r' | xargs || true)"
    [ -z "$line" ] && continue

    token="$(printf '%s' "$line" | awk '{print $1}')"

    if [[ "$token" == git@* ]] || [[ "$token" == *://* ]]; then
        url="$token"
    elif [[ "$token" == */* ]]; then
        url="https://github.com/$token"
        [[ "$url" != *.git ]] && url="$url.git"
    else
        echo "Skipping invalid entry: $token" >&2
        continue
    fi

    repo_name="$(basename "${url%.git}")"
    dest="$TARGET_DIR/$repo_name"

    if [ -e "$dest" ]; then
        echo "Exists, skipping: $dest"
        continue
    fi

    echo "Cloning $url -> $dest"
    if ! git clone "$url" "$dest"; then
        echo "Failed to clone: $url" >&2
    fi
done < "$REPOS_FILE"