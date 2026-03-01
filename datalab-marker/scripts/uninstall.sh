#!/bin/bash
set -e

echo "Uninstalling marker..."

# Remove virtual environment
if [ -d ".venv" ]; then
    echo "Removing virtual environment..."
    rm -rf .venv
fi

# Remove cached models
CACHE_DIR="$HOME/Library/Caches/datalab"
if [ -d "$CACHE_DIR" ]; then
    echo "Removing cached models from $CACHE_DIR..."
    rm -rf "$CACHE_DIR"
fi

# Remove HuggingFace cache for marker models
HF_CACHE="$HOME/.cache/huggingface"
if [ -d "$HF_CACHE" ]; then
    echo "Cleaning HuggingFace cache..."
    find "$HF_CACHE" -name "*surya*" -type d -exec rm -rf {} + 2>/dev/null || true
    find "$HF_CACHE" -name "*marker*" -type d -exec rm -rf {} + 2>/dev/null || true
fi

echo "Marker uninstalled successfully!"