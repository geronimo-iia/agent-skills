---
title: Performance Tips
summary: Optimization strategies and performance tuning for marker-pdf
read_when: Need to optimize conversion speed, memory usage, or disk space
status: active
last_updated: 2025-01-16
---

# Performance Tips

## First run

- Downloads ~4GB of models (Surya OCR, layout detection, table recognition)
- Models cached in `${SKILL_PATH}/huggingface-cache` (configured in `.config`)
- Subsequent runs are much faster (no downloads)

## Memory usage

- **Minimum**: 4GB RAM for small documents
- **Recommended**: 8GB+ RAM for typical documents
- **Large documents** (100+ pages): 16GB+ RAM or use chunking
- **Each worker**: ~2-4GB RAM

## Processing speed

- **CPU**: ~1-2 pages/second (depends on complexity)
- **GPU**: ~3-5 pages/second (CUDA-enabled)
- **First page**: Slower due to model loading

## Optimization strategies

### Large documents
- Use `chunk-convert.sh` script
- Use `--page_range` for manual chunking
- Example: `$SKILL_PATH/scripts/chunk-convert.sh document.pdf 20 ./output`

### Multiple files
- Use `--workers` flag (default: CPU count)
- Example: `$SKILL_PATH/.venv/bin/marker ./pdfs --workers 4`

### Memory constrained
- Reduce workers: `--workers 1`
- Use chunking for large documents
- Process smaller page ranges

### Speed priority
- Use GPU if available
- Skip `--use_llm` and `--force_ocr`
- Example: `$SKILL_PATH/.venv/bin/marker_single document.pdf`

### Accuracy priority
- Use `--use_llm --force_ocr` (slower but better quality)
- Example: `$SKILL_PATH/.venv/bin/marker_single document.pdf --use_llm --force_ocr`

## Disk space

- **Models**: ~4GB
- **Output**: Varies by document
  - Markdown: Smallest
  - JSON with images: Largest
- **Temp files**: Cleaned automatically

## GPU configuration

### Enable GPU
Edit `${SKILL_PATH}/.config`:
```bash
export CUDA_VISIBLE_DEVICES="0"  # Use GPU 0
```

### Multiple GPUs
```bash
export CUDA_VISIBLE_DEVICES="0,1"  # Use GPU 0 and 1
```

### Force CPU
```bash
export CUDA_VISIBLE_DEVICES=""  # Empty = CPU only
```

## Cache management

### Default locations
- **Marker data**: `${SKILL_PATH}/cache`
- **PyTorch**: `${SKILL_PATH}/torch-cache`
- **HuggingFace models**: `${SKILL_PATH}/huggingface-cache`

### Use external drive
Edit `${SKILL_PATH}/.config`:
```bash
export HF_HOME=/Volumes/External/huggingface
export MARKER_CACHE_DIR=/Volumes/External/marker
export TORCH_HOME=/Volumes/External/torch
```

### Clear cache
```bash
rm -rf ${SKILL_PATH}/cache
rm -rf ${SKILL_PATH}/torch-cache
rm -rf ${SKILL_PATH}/huggingface-cache
```
