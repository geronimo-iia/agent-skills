#!/usr/bin/env bash
# Batch convert multiple PDF files with progress tracking

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

if [ $# -lt 1 ]; then
    echo "Usage: $0 <input_dir> [output_dir] [format]"
    echo "  input_dir  - Directory containing PDF files"
    echo "  output_dir - Output directory (default: ./output)"
    echo "  format     - Output format: markdown, json, html, chunks (default: markdown)"
    exit 1
fi

INPUT_DIR="$1"
OUTPUT_DIR="${2:-./output}"
FORMAT="${3:-markdown}"

if [ ! -d "$INPUT_DIR" ]; then
    echo "Error: Directory not found: $INPUT_DIR"
    exit 1
fi

if [ ! -f "$MARKER_BIN" ]; then
    echo "Error: marker-pdf not installed at $SKILL_PATH"
    exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Find all PDF files
PDF_FILES=("$INPUT_DIR"/*.pdf)
TOTAL=${#PDF_FILES[@]}

if [ $TOTAL -eq 0 ]; then
    echo "No PDF files found in $INPUT_DIR"
    exit 1
fi

echo "Found $TOTAL PDF files to convert"
echo "Output format: $FORMAT"
echo ""

# Process each file
COUNT=0
for pdf in "${PDF_FILES[@]}"; do
    COUNT=$((COUNT + 1))
    echo "[$COUNT/$TOTAL] Converting: $(basename "$pdf")"
    
    if "$MARKER_BIN" "$pdf" --output_dir "$OUTPUT_DIR" --output_format "$FORMAT"; then
        echo "  ✓ Success"
    else
        echo "  ✗ Failed"
    fi
    echo ""
done

echo "Batch conversion complete! Output in $OUTPUT_DIR"
