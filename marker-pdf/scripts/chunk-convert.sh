#!/usr/bin/env bash
# Convert large PDF in chunks to avoid memory issues

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
PYTHON_BIN="${SKILL_PATH}/.venv/bin/python"

if [ $# -lt 1 ]; then
    echo "Usage: $0 <pdf_file> [chunk_size] [output_dir]"
    echo "  pdf_file    - PDF file to convert"
    echo "  chunk_size  - Pages per chunk (default: 20)"
    echo "  output_dir  - Output directory (default: ./output)"
    exit 1
fi

PDF_FILE="$1"
CHUNK_SIZE="${2:-20}"
OUTPUT_DIR="${3:-./output}"

if [ ! -f "$PDF_FILE" ]; then
    echo "Error: File not found: $PDF_FILE"
    exit 1
fi

if [ ! -f "$MARKER_BIN" ]; then
    echo "Error: marker-pdf not installed at $SKILL_PATH"
    exit 1
fi

# Get total pages
echo "Counting pages in $PDF_FILE..."
TOTAL_PAGES=$("$PYTHON_BIN" -c "import pypdf; print(len(pypdf.PdfReader('$PDF_FILE').pages))")
echo "Total pages: $TOTAL_PAGES"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Process in chunks
echo "Processing in chunks of $CHUNK_SIZE pages..."
for ((start=0; start<TOTAL_PAGES; start+=CHUNK_SIZE)); do
    end=$((start + CHUNK_SIZE - 1))
    if [ $end -ge $TOTAL_PAGES ]; then
        end=$((TOTAL_PAGES - 1))
    fi
    
    echo "Converting pages $start-$end..."
    "$MARKER_BIN" "$PDF_FILE" --output_dir "$OUTPUT_DIR" --page_range "$start-$end"
done

echo "Conversion complete! Output in $OUTPUT_DIR"
