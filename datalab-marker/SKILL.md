---
name: datalab-marker
description: >
  Convert documents (PDF, image, PPTX, DOCX, XLSX, HTML, EPUB) to markdown, JSON, chunks, 
  and HTML with high accuracy. Extracts text, tables, equations, images, and preserves 
  formatting. Use when the user needs to convert documents, extract content from PDFs, 
  process academic papers, or transform documents for analysis.
tags:
  - pdf
  - document
  - conversion
  - markdown
  - ocr
triggers:
  - pdf
  - document
  - convert
  - markdown
  - extract
  - text
  - table
  - equation
  - image
  - pptx
  - docx
  - xlsx
  - html
  - epub
  - ocr
requires:
  python:
    - marker-pdf
allowed-tools: Bash(marker*:*) Read Write
license: GPL-3.0-or-later
metadata:
  author: VikParuchuri
  version: "1.10.2"
  homepage: https://github.com/VikParuchuri/marker
---

# Marker Document Conversion

## When to use this skill

Use when the user needs to convert documents to markdown or other formats, extract content from PDFs, process academic papers, or transform documents for analysis. Marker supports PDF, image, PPTX, DOCX, XLSX, HTML, and EPUB files.

## Convert a single document

```bash
marker_single /path/to/document.pdf
```

Or use the skill scripts:
```bash
# Install marker
./scripts/install.sh

# Convert single file
marker_single document.pdf --output_dir ./output

# Convert in chunks (for large files)
./scripts/convert_chunks.sh document.pdf ./output 20
```

Output formats:
- `--output_format markdown` (default)
- `--output_format json` 
- `--output_format html`
- `--output_format chunks`

## Convert with high accuracy

```bash
marker_single document.pdf --use_llm --force_ocr
```

- `--use_llm`: Uses LLM to improve accuracy for tables, math, forms
- `--force_ocr`: Re-OCR entire document for better text quality

## Convert multiple documents

```bash
marker /path/to/input/folder
```

- `--workers N`: Number of parallel conversion workers
- `--output_dir /path/to/output`: Specify output directory

## Extract specific content

Tables only:
```bash
marker_single document.pdf --converter_cls marker.converters.table.TableConverter --output_format json
```

OCR only:
```bash
marker_single document.pdf --converter_cls marker.converters.ocr.OCRConverter
```

## Python usage

```python
from marker.converters.pdf import PdfConverter
from marker.models import create_model_dict
from marker.output import text_from_rendered

converter = PdfConverter(artifact_dict=create_model_dict())
rendered = converter("document.pdf")
text, metadata, images = text_from_rendered(rendered)
```

## Edge cases

- Scanned PDFs: Use `--force_ocr` for better text extraction
- Complex layouts: Use `--use_llm` for improved accuracy
- Large documents: Reduce `--workers` if running out of memory
- Encrypted PDFs: Marker handles password-protected files automatically

## Scripts

- `./scripts/install.sh` - Install marker with dependencies
- `./scripts/convert_chunks.sh` - Convert large PDFs in chunks
- `./scripts/uninstall.sh` - Remove marker and cached models

For complete API reference, see [references/api.md](references/api.md).