#!/usr/bin/env python3
"""Extract metadata from PDF."""

import sys
from pathlib import Path
import json

from marker.converters.pdf import PdfConverter
from marker.models import create_model_dict
from marker.output import text_from_rendered


def main():
    if len(sys.argv) < 2:
        print("Usage: extract-metadata.py <pdf_file> [output_json]")
        sys.exit(1)
    
    pdf_file = sys.argv[1]
    output_json = sys.argv[2] if len(sys.argv) > 2 else Path(pdf_file).with_suffix(".json")
    
    print(f"Extracting metadata from {pdf_file}...")
    
    # Convert
    converter = PdfConverter(artifact_dict=create_model_dict())
    rendered = converter(pdf_file)
    text, metadata, images = text_from_rendered(rendered)
    
    # Add image count to metadata
    metadata["image_count"] = len(images)
    
    # Display metadata
    print("\nMetadata:")
    print(f"  Pages: {metadata.get('pages', 'unknown')}")
    print(f"  Language: {metadata.get('language', 'unknown')}")
    print(f"  Tables: {metadata.get('table_count', 0)}")
    print(f"  Equations: {metadata.get('equation_count', 0)}")
    print(f"  Images: {metadata.get('image_count', 0)}")
    
    # Save as JSON
    with open(output_json, "w") as f:
        json.dump(metadata, f, indent=2)
    
    print(f"\n✓ Saved metadata to {output_json}")


if __name__ == "__main__":
    main()
