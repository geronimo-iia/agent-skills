# Marker API Reference

## Command Line Interface

### marker_single
Convert a single document.

**Basic usage:**
```bash
marker_single /path/to/file.pdf
```

**Key options:**
- `--page_range "0,5-10,20"`: Process specific pages
- `--output_format [markdown|json|html|chunks]`: Output format
- `--output_dir PATH`: Output directory
- `--use_llm`: Use LLM for higher accuracy
- `--force_ocr`: Force OCR on entire document
- `--strip_existing_ocr`: Remove existing OCR and re-OCR
- `--disable_image_extraction`: Skip image extraction
- `--converter_cls`: Specify converter class

### marker
Convert multiple documents from a folder.

**Usage:**
```bash
marker /path/to/input/folder
```

**Options:**
- `--workers N`: Number of parallel workers
- All options from `marker_single`

### marker_chunk_convert
Multi-GPU conversion for large batches.

**Usage:**
```bash
NUM_DEVICES=4 NUM_WORKERS=15 marker_chunk_convert ../pdf_in ../md_out
```

## Python API

### PdfConverter
Main converter class for PDF processing.

```python
from marker.converters.pdf import PdfConverter
from marker.models import create_model_dict

converter = PdfConverter(artifact_dict=create_model_dict())
rendered = converter("document.pdf")
```

### TableConverter
Extract tables only.

```python
from marker.converters.table import TableConverter

converter = TableConverter(artifact_dict=create_model_dict())
rendered = converter("document.pdf")
```

### OCRConverter
OCR-only processing.

```python
from marker.converters.ocr import OCRConverter

converter = OCRConverter(artifact_dict=create_model_dict())
rendered = converter("document.pdf")
```

## Output Formats

### Markdown
- Image links with saved images
- Formatted tables
- LaTeX equations (fenced with `$$`)
- Code blocks with triple backticks

### JSON
Tree structure with blocks:
- `id`: Unique block identifier
- `block_type`: Type of content block
- `html`: HTML representation
- `polygon`: Bounding box coordinates
- `children`: Nested blocks

### HTML
- Images via `<img>` tags
- Equations in `<math>` tags
- Code in `<pre>` tags

### Chunks
Flattened list format for RAG applications.

## LLM Services

Configure with `--llm_service`:
- `marker.services.gemini.GoogleGeminiService` (default)
- `marker.services.vertex.GoogleVertexService`
- `marker.services.ollama.OllamaService`
- `marker.services.claude.ClaudeService`
- `marker.services.openai.OpenAIService`
- `marker.services.azure_openai.AzureOpenAIService`

## Performance Tips

- Use `--workers` to control parallelism
- Set `TORCH_DEVICE=cuda` for GPU acceleration
- Reduce workers if running out of memory
- Use `--use_llm` for highest accuracy on complex documents