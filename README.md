# Agent Skills

Collection of skills for agent systems. Each skill provides specific capabilities that agents can discover, load, and execute.

## Skills

### [agentctl](agentctl/SKILL.md)
CLI for agent hub validation and index generation. Validates skill and doc hub directories and generates `index.json`.

**Capabilities:**
- Validate skills hub (`name`, `description`, flat hierarchy)
- Validate docs hub (`title`, `summary`, `status`, `last_updated`, `read_when`)
- Generate `index.json` with git commit hashes
- CI integration with exit code 0/1

### [python-scaffold](python-scaffold/SKILL.md)
Scaffold a new Python project with standard structure, tooling, and configuration.

### [python-quality](python-quality/SKILL.md)
Run Python code quality checks — linting, formatting, and type checking.

### [semantic-commit](semantic-commit/SKILL.md)
Create semantic commits following sp_theory standards with interactive prompts.

### [marker-pdf](marker-pdf/SKILL.md)
Document conversion skill using Marker. Converts PDFs, images, PPTX, DOCX, XLSX, HTML, and EPUB files to markdown, JSON, chunks, and HTML with high accuracy.

**Capabilities:**
- Text extraction with OCR
- Table and equation formatting
- Image extraction and linking
- Batch processing with chunking
- LLM-enhanced accuracy mode

### [github-pages-setup](github-pages-setup/SKILL.md)
Set up GitHub Pages with MkDocs Material for documentation sites with automatic deployment.

**Capabilities:**
- Create MkDocs configuration with Material theme
- Set up GitHub Actions workflow for automatic deployment
- Configure GitHub Pages settings
- Support for Mermaid diagrams and search

### [asdf](asdf/SKILL.md)
Version manager for multiple runtimes. Manages Python, Node.js, Go, and other language versions per project using .tool-versions files.

**Capabilities:**
- Install and switch runtime versions
- Per-project version management
- Global and local version configuration
- Plugin ecosystem for many languages

### [jq](jq/SKILL.md)
JSON processor for command line. Query, filter, transform, and format JSON data.

**Capabilities:**
- Parse and pretty-print JSON
- Extract fields and filter arrays
- Transform JSON structures
- Pipe-friendly command-line interface

**Dependencies:** Requires asdf skill

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

## License

[MIT](LICENSE.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).