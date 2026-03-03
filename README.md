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

### marker-pdf
Document conversion skill using Marker. Converts PDFs, images, PPTX, DOCX, XLSX, HTML, and EPUB files to markdown, JSON, chunks, and HTML with high accuracy.

**Capabilities:**
- Text extraction with OCR
- Table and equation formatting
- Image extraction and linking
- Batch processing with chunking
- LLM-enhanced accuracy mode

### asdf
Version manager for multiple runtimes. Manages Python, Node.js, Go, and other language versions per project using .tool-versions files.

**Capabilities:**
- Install and switch runtime versions
- Per-project version management
- Global and local version configuration
- Plugin ecosystem for many languages

## Skill Development

Skills follow the [agent-foundation skills specification](../agent-foundation/skills/authoring-guide.md):
- `SKILL.md` with machine-readable YAML frontmatter
- `lifecycle.yaml` for install/update/uninstall
- `scripts/` for helper scripts (optional)
- `assets/` for Python/code examples (optional)
- `references/` for detailed documentation (optional)
- Use `SKILL_PATH` variable provided by agent

For complete authoring guidelines, see [../agent-foundation/skills/authoring-guide.md](../agent-foundation/skills/authoring-guide.md).

## Organization

- Each skill in its own directory
- Named descriptively (e.g., `marker-pdf`, `asdf`)
- Self-contained with lifecycle.yaml
- Compatible with agent skill discovery systems
- Minimal structure - only include necessary files