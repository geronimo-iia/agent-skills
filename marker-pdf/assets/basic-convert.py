#!/usr/bin/env python3
"""Basic PDF to markdown conversion."""

import sys
from pathlib import Path

from marker.converters.pdf import PdfConverter
from marker.models import create_model_dict
from marker.output import text_from_rendered


def main():
    if len(sys.argv) < 2:
        print("Usage: basic-convert.py <pdf_file> [output_file]")
        sys.exit(1)
    
    pdf_file = sys.argv[1]
    output_file = sys.argv[2] if len(sys.argv) > 2 else Path(pdf_file).with_suffix(".md")
    
    print(f"Converting {pdf_file}...")
    
    # Convert
    converter = PdfConverter(artifact_dict=create_model_dict())
    rendered = converter(pdf_file)
    text, metadata, images = text_from_rendered(rendered)
    
    # Save
    Path(output_file).write_text(text)
    
    print(f"✓ Converted successfully")
    print(f"  Output: {output_file}")
    print(f"  Pages: {metadata.get('pages', 'unknown')}")
    print(f"  Images: {len(images)}")


if __name__ == "__main__":
    main()
