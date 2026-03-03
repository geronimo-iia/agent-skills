#!/usr/bin/env python3
"""Batch process multiple PDF files."""

import sys
from pathlib import Path

from marker.converters.pdf import PdfConverter
from marker.models import create_model_dict
from marker.output import text_from_rendered


def main():
    if len(sys.argv) < 2:
        print("Usage: batch-process.py <pdf_directory> [output_directory]")
        sys.exit(1)
    
    pdf_dir = Path(sys.argv[1])
    output_dir = Path(sys.argv[2]) if len(sys.argv) > 2 else pdf_dir / "output"
    output_dir.mkdir(parents=True, exist_ok=True)
    
    # Create converter once (reuse for multiple files)
    print("Loading models...")
    converter = PdfConverter(artifact_dict=create_model_dict())
    
    # Process all PDFs
    pdf_files = list(pdf_dir.glob("*.pdf"))
    print(f"\nFound {len(pdf_files)} PDF files\n")
    
    success_count = 0
    for i, pdf_file in enumerate(pdf_files, 1):
        try:
            print(f"[{i}/{len(pdf_files)}] Processing {pdf_file.name}...")
            rendered = converter(str(pdf_file))
            text, metadata, images = text_from_rendered(rendered)
            
            # Save output
            output_file = output_dir / pdf_file.with_suffix(".md").name
            output_file.write_text(text)
            
            print(f"  ✓ Saved to {output_file.name} ({metadata.get('pages')} pages)")
            success_count += 1
        except Exception as e:
            print(f"  ✗ Failed: {e}")
    
    print(f"\nCompleted: {success_count}/{len(pdf_files)} successful")


if __name__ == "__main__":
    main()
