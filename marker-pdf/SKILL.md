---
name: marker-pdf
description: >
  Convert documents (PDF, image, PPTX, DOCX, XLSX, HTML, EPUB) to markdown, JSON, chunks, 
  and HTML with high accuracy. Extracts text, tables, equations, images, and preserves 
  formatting. Use when the user needs to convert documents, extract content from PDFs, 
  process academic papers, or transform documents for analysis.
compatibility: Requires Python 3.11+, marker-pdf package, 4GB+ RAM for model downloads
license: GPL-3.0-or-later
metadata:
  author: VikParuchuri
  version: "1.10.2"
  homepage: https://github.com/VikParuchuri/marker
---

# Marker Document Conversion

## When to use this skill

Convert documents (PDF, image, PPTX, DOCX, XLSX, HTML, EPUB) to markdown, JSON, chunks, or HTML. Use for extracting content from PDFs, processing academic papers, or transforming documents for analysis.

## Quick start

### Helper scripts (recommended)

```bash
# Simple conversion
$SKILL_PATH/scripts/convert.sh document.pdf --output_dir ./output

# Large PDFs (auto-chunking)
$SKILL_PATH/scripts/chunk-convert.sh document.pdf 20 ./output

# Batch conversion
$SKILL_PATH/scripts/batch-convert.sh ./pdfs ./output markdown
```

### Python scripts

```bash
# Basic conversion
$SKILL_PATH/.venv/bin/python $SKILL_PATH/assets/basic-convert.py document.pdf output.md

# Batch processing
$SKILL_PATH/.venv/bin/python $SKILL_PATH/assets/batch-process.py ./pdfs ./output

# Extract images
$SKILL_PATH/.venv/bin/python $SKILL_PATH/assets/extract-images.py document.pdf ./images

# Extract metadata
$SKILL_PATH/.venv/bin/python $SKILL_PATH/assets/extract-metadata.py document.pdf metadata.json

# Safe conversion (with error handling)
$SKILL_PATH/.venv/bin/python $SKILL_PATH/assets/safe-convert.py document.pdf output.md
```

### Direct commands

```bash
# Single document
$SKILL_PATH/.venv/bin/marker_single document.pdf --output_dir ./output

# Multiple documents
$SKILL_PATH/.venv/bin/marker /path/to/folder --workers 4

# Output formats: markdown (default), json, html, chunks
$SKILL_PATH/.venv/bin/marker_single document.pdf --output_format json

# High accuracy (slower)
$SKILL_PATH/.venv/bin/marker_single document.pdf --use_llm --force_ocr

# Page ranges
$SKILL_PATH/.venv/bin/marker_single document.pdf --page_range "0-19"
```

## Configuration

Edit `${SKILL_PATH}/.config` to customize cache locations or GPU settings:

```bash
export MARKER_CACHE_DIR="${SKILL_PATH}/cache"
export TORCH_HOME="${SKILL_PATH}/torch-cache"
export HF_HOME="${SKILL_PATH}/huggingface-cache"
export CUDA_VISIBLE_DEVICES=""  # Empty = CPU, "0" = GPU 0, "0,1" = GPU 0+1
```

## Common issues

- **Out of memory**: Use `$SKILL_PATH/scripts/chunk-convert.sh` or add `--workers 1`
- **Slow first run**: Downloads ~4GB models (cached for subsequent runs)
- **Poor quality**: Add `--force_ocr` for scanned PDFs, `--use_llm` for complex layouts
- **GPU errors**: Set `CUDA_VISIBLE_DEVICES=""` in `.config` to force CPU mode

## References

- [API Reference](references/api.md) - Complete API documentation
- [Converters](references/converters.md) - Available converter types
- [Output Formats](references/output-formats.md) - Format specifications
- [Performance Tips](references/performance.md) - Optimization strategies
- [Troubleshooting](references/troubleshooting.md) - Common issues and solutions