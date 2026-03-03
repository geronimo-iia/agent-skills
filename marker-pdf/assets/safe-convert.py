#!/usr/bin/env python3
"""Convert PDF with comprehensive error handling."""

import sys
from pathlib import Path
import logging

from marker.converters.pdf import PdfConverter
from marker.models import create_model_dict
from marker.output import text_from_rendered

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


def convert_pdf_safe(pdf_path, output_path):
    """Convert PDF with comprehensive error handling."""
    try:
        # Initialize converter
        logger.info(f"Loading models...")
        converter = PdfConverter(artifact_dict=create_model_dict())
        
        # Convert document
        logger.info(f"Converting {pdf_path}...")
        rendered = converter(pdf_path)
        text, metadata, images = text_from_rendered(rendered)
        
        # Validate output
        if not text or len(text.strip()) == 0:
            raise ValueError("Conversion produced empty output")
        
        # Save result
        with open(output_path, "w", encoding="utf-8") as f:
            f.write(text)
        
        logger.info(f"Success: {len(text)} chars, {len(images)} images, {metadata.get('pages')} pages")
        return True, metadata
        
    except FileNotFoundError:
        logger.error(f"File not found: {pdf_path}")
        return False, None
    except PermissionError:
        logger.error(f"Permission denied: {pdf_path}")
        return False, None
    except MemoryError:
        logger.error("Out of memory - try chunking the document")
        return False, None
    except Exception as e:
        logger.error(f"Conversion failed: {type(e).__name__}: {e}")
        return False, None


def main():
    if len(sys.argv) < 2:
        print("Usage: safe-convert.py <pdf_file> [output_file]")
        sys.exit(1)
    
    pdf_path = sys.argv[1]
    output_path = sys.argv[2] if len(sys.argv) > 2 else Path(pdf_path).with_suffix(".md")
    
    success, metadata = convert_pdf_safe(pdf_path, output_path)
    
    if success:
        print(f"\n✓ Converted successfully")
        print(f"  Output: {output_path}")
        print(f"  Pages: {metadata.get('pages')}")
    else:
        print(f"\n✗ Conversion failed - check logs above")
        sys.exit(1)


if __name__ == "__main__":
    main()
