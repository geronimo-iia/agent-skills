---
title: Output Formats
summary: Complete specification for all marker-pdf output formats
read_when: Need to understand output format options and structure
status: active
last_updated: 2025-01-16
---

# Output Formats

Complete specification for all marker-pdf output formats.

## Supported Formats

- **markdown** - GitHub-flavored markdown (default)
- **json** - Structured JSON with metadata
- **html** - Semantic HTML5
- **chunks** - Text chunks for RAG/embedding

## Markdown Format

### Overview

GitHub-flavored markdown with preserved formatting, tables, equations, and images.

```bash
marker_single document.pdf --output_format markdown
```

### Structure

```markdown
# Document Title

## Section 1

Paragraph text with **bold** and *italic* formatting.

### Subsection 1.1

- Bullet point 1
- Bullet point 2

| Header 1 | Header 2 |
|----------|----------|
| Cell 1   | Cell 2   |

![Image description](image_0.png)

$$
E = mc^2
$$

Inline equation: $x^2 + y^2 = z^2$
```

### Features

- Headings (H1-H6)
- Bold, italic, underline
- Lists (ordered, unordered)
- Tables with alignment
- Code blocks
- Block quotes
- Links
- Images (embedded or referenced)
- LaTeX equations (inline and display)

### Image Handling

Images are extracted and referenced:

```markdown
![Figure 1: Chart](image_0.png)
```

Images saved separately in output directory.

## JSON Format

### Overview

Structured JSON with full document metadata and content.

```bash
marker_single document.pdf --output_format json
```

### Structure

```json
{
  "metadata": {
    "pages": 10,
    "language": "en",
    "title": "Document Title",
    "author": "Author Name",
    "created": "2024-01-01",
    "table_count": 3,
    "equation_count": 5,
    "image_count": 2
  },
  "content": [
    {
      "type": "heading",
      "level": 1,
      "text": "Document Title",
      "page": 1
    },
    {
      "type": "paragraph",
      "text": "Paragraph content...",
      "page": 1,
      "bbox": [x1, y1, x2, y2]
    },
    {
      "type": "table",
      "page": 2,
      "bbox": [x1, y1, x2, y2],
      "rows": [
        ["Header 1", "Header 2"],
        ["Cell 1", "Cell 2"]
      ]
    },
    {
      "type": "equation",
      "page": 3,
      "latex": "E = mc^2",
      "display": true
    },
    {
      "type": "image",
      "page": 4,
      "filename": "image_0.png",
      "bbox": [x1, y1, x2, y2],
      "caption": "Figure 1: Chart"
    }
  ],
  "images": {
    "image_0.png": "base64_encoded_data..."
  }
}
```

### Content Types

- `heading` - Document headings
- `paragraph` - Text paragraphs
- `list` - Ordered/unordered lists
- `table` - Tabular data
- `equation` - Mathematical equations
- `image` - Embedded images
- `code` - Code blocks

### Use Cases

- Structured data extraction
- Database import
- API integration
- Custom processing pipelines

## HTML Format

### Overview

Semantic HTML5 with CSS classes for styling.

```bash
marker_single document.pdf --output_format html
```

### Structure

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document Title</title>
    <style>
        /* Embedded CSS */
    </style>
</head>
<body>
    <article>
        <h1>Document Title</h1>
        
        <section>
            <h2>Section 1</h2>
            <p>Paragraph text with <strong>bold</strong> and <em>italic</em>.</p>
            
            <table>
                <thead>
                    <tr>
                        <th>Header 1</th>
                        <th>Header 2</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Cell 1</td>
                        <td>Cell 2</td>
                    </tr>
                </tbody>
            </table>
            
            <figure>
                <img src="image_0.png" alt="Figure 1: Chart">
                <figcaption>Figure 1: Chart</figcaption>
            </figure>
            
            <div class="equation">
                $$E = mc^2$$
            </div>
        </section>
    </article>
</body>
</html>
```

### CSS Classes

- `.heading-1` through `.heading-6` - Headings
- `.paragraph` - Paragraphs
- `.table` - Tables
- `.equation` - Equations (inline and display)
- `.image` - Images
- `.code-block` - Code blocks

### Use Cases

- Web publishing
- Documentation sites
- Email templates
- Print-ready output

## Chunks Format

### Overview

Text chunks optimized for RAG (Retrieval Augmented Generation) and embedding.

```bash
marker_single document.pdf --output_format chunks
```

### Structure

```json
{
  "chunks": [
    {
      "id": "chunk_0",
      "text": "Document Title\n\nSection 1\n\nParagraph text...",
      "page": 1,
      "char_count": 150,
      "metadata": {
        "section": "Introduction",
        "has_table": false,
        "has_equation": false
      }
    },
    {
      "id": "chunk_1",
      "text": "Section 2\n\nMore content...",
      "page": 2,
      "char_count": 200,
      "metadata": {
        "section": "Methods",
        "has_table": true,
        "has_equation": true
      }
    }
  ],
  "metadata": {
    "total_chunks": 15,
    "avg_chunk_size": 175,
    "pages": 10
  }
}
```

### Chunking Strategy

- **Semantic boundaries**: Chunks split at section/paragraph boundaries
- **Size target**: ~150-300 characters per chunk
- **Overlap**: Optional 10% overlap between chunks
- **Metadata**: Each chunk includes context metadata

### Configuration

```python
config = {
    "chunk_size": 200,        # Target chunk size
    "chunk_overlap": 20,      # Overlap between chunks
    "split_on": "paragraph"   # "paragraph", "section", or "sentence"
}
```

### Use Cases

- Vector database ingestion
- Semantic search
- RAG pipelines
- Document embedding

## Format Comparison

| Format | Size | Structure | Metadata | Images | Best For |
|--------|------|-----------|----------|--------|----------|
| Markdown | Small | Moderate | Limited | Referenced | Documentation, notes |
| JSON | Large | High | Complete | Embedded | APIs, databases |
| HTML | Medium | High | Moderate | Embedded | Web, publishing |
| Chunks | Medium | Low | Moderate | None | RAG, search |

## Converting Between Formats

### Python

```python
from marker.converters.pdf import PdfConverter
from marker.models import create_model_dict
from marker.output import text_from_rendered

converter = PdfConverter(artifact_dict=create_model_dict())
rendered = converter("document.pdf")

# Get different formats
markdown, _, _ = text_from_rendered(rendered, output_format="markdown")
json_data, _, _ = text_from_rendered(rendered, output_format="json")
html, _, _ = text_from_rendered(rendered, output_format="html")
chunks, _, _ = text_from_rendered(rendered, output_format="chunks")
```

### CLI

```bash
# Convert to all formats
for format in markdown json html chunks; do
    marker_single document.pdf --output_format $format --output_dir ./output_$format
done
```

## Custom Output Formats

Create custom output formats by extending the renderer:

```python
from marker.renderers.base import BaseRenderer

class CustomRenderer(BaseRenderer):
    def render(self, document):
        # Custom rendering logic
        return custom_output

converter = PdfConverter(
    artifact_dict=create_model_dict(),
    renderer=CustomRenderer()
)
```

## See Also

- [api.md](api.md) - Full API reference
- [converters.md](converters.md) - All converter types
