---
title: Marker API Reference
summary: Complete API reference for marker-pdf Python library
read_when: Need to use marker-pdf programmatically in Python
status: active
last_updated: 2025-01-16
---

# Marker API Reference

Complete API reference for marker-pdf Python library.

## Core Classes

### PdfConverter

Main converter class for PDF documents.

```python
from marker.converters.pdf import PdfConverter
from marker.models import create_model_dict

converter = PdfConverter(
    artifact_dict=create_model_dict(),
    processor_list=None,  # Optional: custom processors
    renderer=None,        # Optional: custom renderer
    config=None          # Optional: custom config
)
```

**Methods**:

- `__call__(pdf_path: str) -> RenderedDocument` - Convert PDF to rendered document
- `convert(pdf_path: str, **kwargs) -> RenderedDocument` - Alternative conversion method

**Parameters**:
- `artifact_dict` - Model artifacts (OCR, layout, table models)
- `processor_list` - List of custom processors
- `renderer` - Custom renderer for output
- `config` - Configuration dictionary

### create_model_dict()

Load all required models for conversion.

```python
from marker.models import create_model_dict

models = create_model_dict(
    device=None,      # Auto-detect GPU/CPU
    dtype=None,       # Auto-detect precision
    force_cpu=False   # Force CPU mode
)
```

**Returns**: Dictionary with model artifacts
- `ocr_model` - Surya OCR model
- `layout_model` - Layout detection model
- `table_model` - Table recognition model
- `equation_model` - Equation detection model

### text_from_rendered()

Extract text, metadata, and images from rendered document.

```python
from marker.output import text_from_rendered

text, metadata, images = text_from_rendered(
    rendered,
    output_format="markdown"  # or "json", "html", "chunks"
)
```

**Returns**:
- `text` (str) - Converted text in specified format
- `metadata` (dict) - Document metadata
- `images` (dict) - Extracted images (base64 encoded)

## Metadata Fields

```python
metadata = {
    "pages": 42,                    # Total pages
    "language": "en",               # Detected language
    "table_count": 5,               # Number of tables
    "equation_count": 12,           # Number of equations
    "image_count": 8,               # Number of images
    "processing_time": 45.2,        # Seconds
    "model_versions": {...}         # Model version info
}
```

## Configuration Options

### Converter Config

```python
config = {
    "use_llm": False,              # Use LLM for accuracy
    "force_ocr": False,            # Force OCR on all pages
    "page_range": None,            # Tuple (start, end) or None
    "workers": None,               # Number of workers (default: CPU count)
    "languages": ["en"],           # Expected languages
    "output_format": "markdown"    # Output format
}

converter = PdfConverter(artifact_dict=models, config=config)
```

### Model Config

```python
from marker.models import create_model_dict

models = create_model_dict(
    device="cuda",           # "cuda", "cpu", or None (auto)
    dtype="float16",         # "float16", "float32", or None (auto)
    force_cpu=False,         # Force CPU even if GPU available
    cache_dir=None          # Custom model cache directory
)
```

## Advanced Usage

### Custom Processors

```python
from marker.processors import BaseProcessor

class CustomProcessor(BaseProcessor):
    def process(self, page):
        # Custom processing logic
        return processed_page

converter = PdfConverter(
    artifact_dict=models,
    processor_list=[CustomProcessor()]
)
```

### Page Range Processing

```python
# Process specific pages
rendered = converter("document.pdf", page_range=(0, 19))  # Pages 0-19
rendered = converter("document.pdf", page_range=(20, 39)) # Pages 20-39
```

### Batch Processing with Progress

```python
from pathlib import Path
from tqdm import tqdm

converter = PdfConverter(artifact_dict=create_model_dict())
pdf_files = list(Path("./pdfs").glob("*.pdf"))

for pdf_file in tqdm(pdf_files, desc="Converting PDFs"):
    rendered = converter(str(pdf_file))
    text, metadata, images = text_from_rendered(rendered)
    # Process output...
```

## Error Handling

### Common Exceptions

```python
try:
    rendered = converter("document.pdf")
except FileNotFoundError:
    # PDF file not found
    pass
except PermissionError:
    # Cannot read PDF file
    pass
except MemoryError:
    # Out of memory - use chunking
    pass
except RuntimeError as e:
    # Model loading or conversion error
    pass
```

### Validation

```python
from marker.converters.pdf import PdfConverter
from marker.models import create_model_dict
from marker.output import text_from_rendered

def validate_conversion(pdf_path):
    """Validate PDF conversion output."""
    converter = PdfConverter(artifact_dict=create_model_dict())
    rendered = converter(pdf_path)
    text, metadata, images = text_from_rendered(rendered)
    
    # Validation checks
    assert len(text) > 0, "Empty output"
    assert metadata.get("pages", 0) > 0, "No pages detected"
    
    return True
```

## Performance Optimization

### Reuse Converter

```python
# Good: Create converter once
converter = PdfConverter(artifact_dict=create_model_dict())
for pdf in pdf_files:
    rendered = converter(pdf)
    # Process...

# Bad: Create converter for each file (slow)
for pdf in pdf_files:
    converter = PdfConverter(artifact_dict=create_model_dict())
    rendered = converter(pdf)
```

### GPU Acceleration

```python
import torch

# Check GPU availability
if torch.cuda.is_available():
    models = create_model_dict(device="cuda", dtype="float16")
else:
    models = create_model_dict(device="cpu")

converter = PdfConverter(artifact_dict=models)
```

### Memory Management

```python
import gc
import torch

# Clear GPU memory between large documents
rendered = converter("large.pdf")
text, metadata, images = text_from_rendered(rendered)

# Free memory
del rendered
gc.collect()
if torch.cuda.is_available():
    torch.cuda.empty_cache()
```

## See Also

- [converters.md](converters.md) - All converter types
- [output-formats.md](output-formats.md) - Output format specifications
