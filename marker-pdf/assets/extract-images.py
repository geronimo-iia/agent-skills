#!/usr/bin/env python3
"""Extract images from PDF."""

import sys
from pathlib import Path
import base64

from marker.converters.pdf import PdfConverter
from marker.models import create_model_dict
from marker.output import text_from_rendered


def main():
    if len(sys.argv) < 2:
        print("Usage: extract-images.py <pdf_file> [output_directory]")
        sys.exit(1)
    
    pdf_file = sys.argv[1]
    output_dir = Path(sys.argv[2]) if len(sys.argv) > 2 else Path("./images")
    output_dir.mkdir(parents=True, exist_ok=True)
    
    print(f"Extracting images from {pdf_file}...")
    
    # Convert
    converter = PdfConverter(artifact_dict=create_model_dict())
    rendered = converter(pdf_file)
    text, metadata, images = text_from_rendered(rendered)
    
    if not images:
        print("No images found in document")
        return
    
    # Save images
    print(f"\nExtracting {len(images)} images...")
    for img_name, img_data in images.items():
        img_bytes = base64.b64decode(img_data)
        img_path = output_dir / img_name
        img_path.write_bytes(img_bytes)
        print(f"  ✓ {img_name} ({len(img_bytes)} bytes)")
    
    # Save markdown with image references
    markdown_file = output_dir.parent / Path(pdf_file).with_suffix(".md").name
    markdown_file.write_text(text)
    
    print(f"\n✓ Extracted {len(images)} images to {output_dir}")
    print(f"✓ Saved markdown to {markdown_file}")


if __name__ == "__main__":
    main()
