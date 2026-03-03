---
title: Marker Converters
summary: Complete reference for all converter types in marker-pdf
read_when: Need to use specialized converters for tables, OCR, or equations
status: active
last_updated: 2025-01-16
---

# Marker Converters

Complete reference for all converter types in marker-pdf.

## Converter Types

### PdfConverter (Default)

Full-featured PDF converter with OCR, layout detection, and table recognition.

```python
from marker.converters.pdf import PdfConverter
from marker.models import create_model_dict

converter = PdfConverter(artifact_dict=create_model_dict())
rendered = converter("document.pdf")
```

**Features**:
- Text extraction from native PDFs
- OCR for scanned pages
- Table detection and extraction
- Equation recognition
- Image extraction
- Layout preservation

**Best for**: General PDF conversion, mixed content documents

### TableConverter

Specialized converter for extracting tables from PDFs.

```python
from marker.converters.table import TableConverter
from marker.models import create_model_dict

converter = TableConverter(artifact_dict=create_model_dict())
rendered = converter("document.pdf")
```

**Features**:
- Focused table detection
- Structured table output
- Cell-level extraction
- Merged cell handling

**Best for**: Documents with many tables, data extraction

**Output format**: JSON with table structures

```json
{
  "tables": [
    {
      "page": 1,
      "bbox": [x1, y1, x2, y2],
      "cells": [
        {"row": 0, "col": 0, "text": "Header 1"},
        {"row": 0, "col": 1, "text": "Header 2"}
      ]
    }
  ]
}
```

### OCRConverter

Pure OCR converter without layout analysis.

```python
from marker.converters.ocr import OCRConverter
from marker.models import create_model_dict

converter = OCRConverter(artifact_dict=create_model_dict())
rendered = converter("document.pdf")
```

**Features**:
- Raw OCR text extraction
- No layout preservation
- Fast processing
- Simple output

**Best for**: Scanned documents, text-only extraction, speed priority

**Output**: Plain text in reading order

### EquationConverter

Specialized converter for mathematical equations.

```python
from marker.converters.equation import EquationConverter
from marker.models import create_model_dict

converter = EquationConverter(artifact_dict=create_model_dict())
rendered = converter("document.pdf")
```

**Features**:
- LaTeX equation extraction
- Inline and display equations
- Symbol recognition
- Math notation preservation

**Best for**: Academic papers, mathematical documents

**Output format**: LaTeX equations

```latex
$$
E = mc^2
$$

Inline equation: $x^2 + y^2 = z^2$
```

## Converter Comparison

| Converter | Speed | Accuracy | Layout | Tables | Equations | Images |
|-----------|-------|----------|--------|--------|-----------|--------|
| PdfConverter | Medium | High | ✓ | ✓ | ✓ | ✓ |
| TableConverter | Fast | High | ✗ | ✓ | ✗ | ✗ |
| OCRConverter | Fast | Medium | ✗ | ✗ | ✗ | ✗ |
| EquationConverter | Medium | High | ✗ | ✗ | ✓ | ✗ |

## Using Converters via CLI

### PdfConverter (default)

```bash
marker_single document.pdf
```

### TableConverter

```bash
marker_single document.pdf \
  --converter_cls marker.converters.table.TableConverter \
  --output_format json
```

### OCRConverter

```bash
marker_single document.pdf \
  --converter_cls marker.converters.ocr.OCRConverter
```

### EquationConverter

```bash
marker_single document.pdf \
  --converter_cls marker.converters.equation.EquationConverter
```

## Custom Converters

Create custom converters by extending BaseConverter:

```python
from marker.converters.base import BaseConverter
from marker.models import create_model_dict

class CustomConverter(BaseConverter):
    def __init__(self, artifact_dict, **kwargs):
        super().__init__(artifact_dict, **kwargs)
        # Custom initialization
    
    def convert_page(self, page):
        # Custom page conversion logic
        return processed_page
    
    def post_process(self, pages):
        # Custom post-processing
        return final_output

# Usage
converter = CustomConverter(artifact_dict=create_model_dict())
rendered = converter("document.pdf")
```

## Converter Configuration

### Common Options

All converters support these configuration options:

```python
config = {
    "page_range": (0, 10),      # Process pages 0-10
    "languages": ["en", "es"],  # Expected languages
    "workers": 4,               # Parallel workers
    "output_format": "markdown" # Output format
}

converter = PdfConverter(
    artifact_dict=create_model_dict(),
    config=config
)
```

### Converter-Specific Options

#### PdfConverter

```python
config = {
    "use_llm": True,           # Use LLM for accuracy
    "force_ocr": False,        # Force OCR on all pages
    "extract_images": True,    # Extract embedded images
    "preserve_layout": True    # Maintain document layout
}
```

#### TableConverter

```python
config = {
    "min_table_confidence": 0.8,  # Minimum confidence threshold
    "merge_cells": True,           # Handle merged cells
    "extract_headers": True        # Identify table headers
}
```

#### OCRConverter

```python
config = {
    "ocr_confidence": 0.7,     # Minimum OCR confidence
    "denoise": True,           # Apply denoising
    "deskew": True            # Correct page skew
}
```

## Chaining Converters

Process documents with multiple converters:

```python
from marker.converters.pdf import PdfConverter
from marker.converters.table import TableConverter
from marker.models import create_model_dict

models = create_model_dict()

# Extract general content
pdf_converter = PdfConverter(artifact_dict=models)
text, metadata, images = text_from_rendered(pdf_converter("doc.pdf"))

# Extract tables separately
table_converter = TableConverter(artifact_dict=models)
tables = text_from_rendered(table_converter("doc.pdf"), output_format="json")

# Combine results
combined = {
    "text": text,
    "tables": tables,
    "metadata": metadata
}
```

## See Also

- [api.md](api.md) - Full API reference
- [output-formats.md](output-formats.md) - Output format specifications
