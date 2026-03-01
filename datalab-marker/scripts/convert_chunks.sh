#!/bin/bash
set -e

PDF_PATH="$1"
OUTPUT_DIR="$2"
CHUNK_SIZE="${3:-5}"

if [ -z "$PDF_PATH" ] || [ -z "$OUTPUT_DIR" ]; then
    echo "Usage: $0 <pdf_path> <output_dir> [chunk_size]"
    exit 1
fi

PDF_NAME=$(basename "$PDF_PATH" .pdf)

# Get total pages
TOTAL_PAGES=$(python3 -c "
import pypdf
with open('$PDF_PATH', 'rb') as f:
    reader = pypdf.PdfReader(f)
    print(len(reader.pages))
")

echo "Total pages: $TOTAL_PAGES"
echo "Processing in chunks of $CHUNK_SIZE pages..."

for ((start=0; start<TOTAL_PAGES; start+=CHUNK_SIZE)); do
    end=$((start + CHUNK_SIZE - 1))
    if [ $end -ge $TOTAL_PAGES ]; then
        end=$((TOTAL_PAGES - 1))
    fi
    
    chunk_name="${PDF_NAME}_pages_${start}-${end}"
    echo "Processing $chunk_name..."
    
    marker_single "$PDF_PATH" --output_dir "$OUTPUT_DIR" --page_range "$start-$end"
    
    # Rename output to include page range
    if [ -d "$OUTPUT_DIR/$PDF_NAME" ]; then
        mv "$OUTPUT_DIR/$PDF_NAME" "$OUTPUT_DIR/$chunk_name"
    fi
done

echo "Conversion complete! Each chunk saved separately for analysis."