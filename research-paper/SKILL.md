---
name: research-paper
description: >-
  Process an academic paper (PDF or URL) into the agent-knowledge repository.
  Extracts text, produces a structured analysis, and integrates findings into the
  appropriate topic. Use when asked to read, analyse, or integrate a research paper
  into the knowledge base. Do NOT use for general web pages or blog posts.
title: "Research Paper Processing"
summary: "Ingest academic papers into agent-knowledge: extract, analyse, study, synthesise"
read_when:
  - Processing a research paper from a URL
  - Analysing a PDF research paper
  - Adding a new paper to agent-knowledge
  - Producing a structured analysis of academic work
  - Integrating research findings into an existing topic
status: active
last_updated: "2026-07-16"
metadata:
  version: "0.1.0"
---

# Research Paper Processing

Processes an academic paper into the knowledge repository following the standard
`sources → extract → analysis → studies → synthesis` pipeline.

> For document format and frontmatter standards, follow the authoring guide in
> `agent-foundation/docs/authoring-guide.md` ([github.com/geronimo-iia/agent-foundation](https://github.com/geronimo-iia/agent-foundation)).

## Knowledge base location

The knowledge base path depends on the workspace context:
- If a workspace rule or directive specifies a knowledge base path, use that
- If the user provides a path explicitly, use that
- Otherwise, ask the user before proceeding

Each topic is a subdirectory within the knowledge base root.

## Step 1 — Identify the paper and topic

Ask the user (or infer from context):
- The paper source: URL or local PDF path
- The target topic directory within the knowledge base
- Create the topic directory if it does not exist

## Step 2 — Acquire the source

### URL

Download the PDF to `<topic>/sources/<slug>.pdf` using `curl -L`:

```bash
curl -L "<url>" -o "<topic>/sources/<slug>.pdf"
```

If the file already exists, skip the download.

### Local PDF

Copy or symlink the PDF to `<topic>/sources/<filename>.pdf` if not already there.

## Step 3 — Extract text

Use the `marker-pdf` skill if available, otherwise use `pdftotext`:

```bash
# preferred
marker_single "<topic>/sources/<filename>.pdf" --output_dir "<topic>/extract/"

# fallback
pdftotext "<topic>/sources/<filename>.pdf" "<topic>/extract/<slug>.txt"
```

The extracted file goes to `<topic>/extract/<slug>.txt` (or the marker-pdf output directory).

## Step 4 — Produce a structured analysis

Read the extracted text and write a comprehensive analysis to
`<topic>/analysis/analysis-<slug>-comprehensive.md`.

The analysis must cover:

1. **Publication details** — title, authors, year, venue, DOI
2. **Core thesis** — main research question and central claim in 2–3 sentences
3. **Key contributions** — bullet list of concrete contributions
4. **Mathematical foundations** — equations, proofs, formal definitions (if present)
5. **Algorithms** — pseudocode or step-by-step descriptions of all algorithms
6. **Architecture / system design** — diagrams described in prose, component relationships
7. **Experimental results** — datasets, metrics, key findings
8. **Limitations and open problems** — what the paper acknowledges as unsolved
9. **Relation to existing knowledge** — how this paper connects to other documents already
   in `<topic>/analysis/` and `<topic>/synthesis/`
10. **Glossary** — definitions of domain-specific terms introduced

Use the frontmatter format:

```yaml
---
title: "Analysis: <Paper Title>"
summary: "<one-line summary>"
read_when:
  - <when to read this analysis>
status: active
last_updated: "<today>"
source: "<filename>.pdf"
---
```

## Step 5 — Update the topic README / analysis index

If `<topic>/analysis/README.md` exists, add an entry for the new paper.
If it does not exist, create it with a minimal index.

## Step 6 — Assess synthesis impact

Read the existing synthesis documents in `<topic>/synthesis/` and determine:

- Does this paper introduce new concepts not yet in the synthesis?
- Does it contradict or refine existing synthesis claims?

If yes, either:
- Update the relevant synthesis document directly (for small additions)
- Create a new study in `<topic>/studies/` documenting the integration work needed

Report your assessment to the user.

## Output summary

After completing all steps, report:

```
✓ Source saved:   <topic>/sources/<filename>.pdf
✓ Text extracted: <topic>/extract/<slug>.txt
✓ Analysis:       <topic>/analysis/analysis-<slug>-comprehensive.md
✓ Index updated:  <topic>/analysis/README.md
~ Synthesis:      <assessment of impact on existing synthesis>
```
