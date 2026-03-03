#!/usr/bin/env bash
# Wrapper for marker_single that handles SKILL_PATH automatically

set -e

# SKILL_PATH should be provided by the agent or environment
if [ -z "${SKILL_PATH}" ]; then
    echo "Error: SKILL_PATH not set"
    echo "This script should be called by an agent that sets SKILL_PATH"
    exit 1
fi

# Source config if exists
if [ -f "${SKILL_PATH}/.config" ]; then
    source "${SKILL_PATH}/.config"
fi

MARKER_BIN="${SKILL_PATH}/.venv/bin/marker_single"

if [ ! -f "$MARKER_BIN" ]; then
    echo "Error: marker-pdf not installed at $SKILL_PATH"
    echo "Run the skill installation first"
    exit 1
fi

exec "$MARKER_BIN" "$@"
