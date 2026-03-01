---
title: "Agent Skills"
summary: "Collection of skills for agent systems - tools, utilities, and capabilities that agents can use to perform tasks."
read_when:
  - Developing new skills for agents
  - Looking for existing skill implementations
  - Understanding skill architecture and patterns
status: draft
last_updated: "2025-01-16"
---

# Agent Skills

Collection of skills for agent systems. Each skill provides specific capabilities that agents can discover, load, and execute.

## Skills

### datalab-marker
Document conversion skill using Marker from Datalab. Converts PDFs, images, PPTX, DOCX, XLSX, HTML, and EPUB files to markdown, JSON, chunks, and HTML with high accuracy.

**Capabilities:**
- Text extraction with OCR
- Table and equation formatting
- Image extraction and linking
- Batch processing with chunking
- LLM-enhanced accuracy mode

## Skill Development

Skills follow the [agent-foundation skills specification](../agent-foundation/skills/authoring-guide.md):
- `SKILL.md` with machine-readable YAML frontmatter
- `scripts/` for executable tools
- `references/` for detailed documentation
- Proper dependency management and gating

For complete authoring guidelines, see [../agent-foundation/skills/authoring-guide.md](../agent-foundation/skills/authoring-guide.md).

## Organization

- Each skill in its own directory
- Named with source/vendor prefix when applicable
- Self-contained with installation/uninstallation scripts
- Compatible with agent skill discovery systems