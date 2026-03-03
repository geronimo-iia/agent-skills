---
title: Troubleshooting Guide
summary: Common issues and solutions for marker-pdf skill
read_when: Encountering errors or unexpected behavior with marker-pdf
status: active
last_updated: 2025-01-16
---

# Troubleshooting Guide

## Out of memory errors

**Symptoms**: Process killed, "Killed", or OOM errors

**Solutions**:
```bash
# Reduce workers to 1
$SKILL_PATH/.venv/bin/marker_single document.pdf --workers 1

# Use chunking for large documents
$SKILL_PATH/scripts/chunk-convert.sh document.pdf 10 ./output

# Process smaller page ranges
$SKILL_PATH/.venv/bin/marker_single document.pdf --page_range "0-9"
```

## Model download failures

**Symptoms**: "Failed to download", "Connection timeout", "403 Forbidden"

**Solutions**:
```bash
# Check network connectivity
ping huggingface.co

# Check disk space (need 4GB+)
df -h ~

# Clear partial downloads and retry
rm -rf ${SKILL_PATH}/huggingface-cache/*marker*
rm -rf ${SKILL_PATH}/huggingface-cache/*surya*

# Set HuggingFace token if rate limited
export HF_TOKEN=your_token_here
```

## CUDA/GPU errors

**Symptoms**: "CUDA out of memory", "No CUDA devices", GPU not detected

**Solutions**:
```bash
# Force CPU mode
export CUDA_VISIBLE_DEVICES=""
$SKILL_PATH/.venv/bin/marker_single document.pdf

# Check CUDA availability
$SKILL_PATH/.venv/bin/python -c "import torch; print(torch.cuda.is_available())"

# Reduce batch size for GPU
$SKILL_PATH/.venv/bin/marker_single document.pdf --workers 1
```

## Permission errors

**Symptoms**: "Permission denied", "Cannot write to directory"

**Solutions**:
```bash
# Check file permissions
ls -la document.pdf

# Check output directory permissions
mkdir -p ./output
chmod 755 ./output

# Check cache directory permissions
ls -la ${SKILL_PATH}/huggingface-cache/
```

## Poor quality output

**Symptoms**: Missing text, garbled tables, incorrect formatting

**Solutions**:
```bash
# For scanned PDFs, force OCR
$SKILL_PATH/.venv/bin/marker_single document.pdf --force_ocr

# For complex layouts, use LLM
$SKILL_PATH/.venv/bin/marker_single document.pdf --use_llm

# Combine both for best quality
$SKILL_PATH/.venv/bin/marker_single document.pdf --use_llm --force_ocr
```

## Slow processing

**Symptoms**: Takes much longer than expected

**Solutions**:
```bash
# Check if models are downloaded (first run is slow)
ls -lh ${SKILL_PATH}/huggingface-cache/ | grep marker

# Increase workers for multiple files
$SKILL_PATH/.venv/bin/marker ./pdfs --workers 4

# Skip accuracy features for speed
$SKILL_PATH/.venv/bin/marker_single document.pdf  # no --use_llm or --force_ocr
```

## Script not found errors

**Symptoms**: "command not found: marker_single"

**Solutions**:
```bash
# Verify installation
ls -la ${SKILL_PATH}/.venv/bin/marker_single

# Reinstall if missing
cd ${SKILL_PATH}
uv pip install --python .venv/bin/python marker-pdf[full] pypdf
```
