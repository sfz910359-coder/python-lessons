#!/bin/bash
# Deploy a new lesson to GitHub Pages
# Usage: ./deploy.sh lesson-0003-loops.html

set -e
TOKEN="${GITHUB_TOKEN:-}"
REPO="sfz910359-coder/python-lessons"

if [ -z "$TOKEN" ]; then
  echo "Error: GITHUB_TOKEN not set"
  exit 1
fi

FILE="$1"
if [ ! -f "$FILE" ]; then
  echo "Usage: ./deploy.sh <lesson-file.html>"
  exit 1
fi

cp "$FILE" /tmp/python-lessons/
cd /tmp/python-lessons

git add "$FILE"
git commit -m "Add $(basename $FILE)" 2>/dev/null || echo "No changes"
git push https://sfz910359-coder:${TOKEN}@github.com/${REPO}.git main

echo "✅ Deployed: https://sfz910359-coder.github.io/python-lessons/$(basename $FILE)"
