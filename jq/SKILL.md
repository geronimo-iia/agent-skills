---
name: jq
description: >
  Command-line JSON processor. Query, filter, transform, and format JSON data.
  Use when you need to parse JSON output, extract fields, or manipulate JSON structures.
compatibility: Requires asdf skill for installation
license: MIT
metadata:
  author: jq contributors
  version: "1.7"
  homepage: https://jqlang.github.io/jq/
  requires:
    - asdf
---

# jq - JSON Processor

## When to use this skill

Parse and manipulate JSON data from command line. Extract fields, filter arrays, transform structures, or format JSON output.

## Quick start

```bash
# Pretty print JSON
echo '{"name":"John","age":30}' | jq '.'

# Extract field
echo '{"name":"John","age":30}' | jq '.name'

# Filter array
echo '[{"name":"John"},{"name":"Jane"}]' | jq '.[0]'

# Transform
echo '{"name":"John"}' | jq '{user: .name}'
```

## Common commands

```bash
# Basic queries
jq '.'                          # Pretty print
jq '.field'                     # Extract field
jq '.field.nested'              # Nested field
jq '.[]'                        # Array elements

# Filtering
jq '.[] | select(.age > 25)'    # Filter array
jq 'map(select(.active))'       # Filter with map
jq '.[] | select(.name == "John")'  # Exact match

# Transformation
jq '{name: .user, id: .userId}' # Reshape object
jq 'map({name, age})'           # Extract fields from array
jq '.[] | {name, age}'          # Transform array elements

# Array operations
jq 'length'                     # Array/object length
jq 'keys'                       # Object keys
jq 'sort_by(.age)'              # Sort array
jq 'group_by(.type)'            # Group array

# Output formats
jq -r '.name'                   # Raw output (no quotes)
jq -c '.'                       # Compact output
jq -S '.'                       # Sort keys
```

## Common patterns

```bash
# Parse API response
curl -s https://api.example.com/users | jq '.data[].name'

# Extract from file
jq '.users[] | select(.active)' users.json

# Multiple filters
jq '.[] | select(.age > 25) | .name' data.json

# Combine fields
jq '.[] | "\(.name) is \(.age) years old"' data.json

# Count items
jq '[.[] | select(.status == "active")] | length' data.json
```

## Common issues

- **Parse error**: Input must be valid JSON
- **Null values**: Use `// "default"` for null handling
- **Array vs object**: Use `.[]` for arrays, `.field` for objects
- **Quotes in output**: Use `-r` flag for raw output without quotes
