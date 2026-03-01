#!/bin/bash
set -e

VENV_DIR=".venv"

echo "Creating virtual environment..."
uv venv $VENV_DIR

echo "Installing marker-pdf..."
uv pip install marker-pdf[full] pypdf

echo "Marker installation complete!"
echo "Activate with: source $VENV_DIR/bin/activate"
echo "Test with: marker_single --help"