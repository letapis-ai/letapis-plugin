# letapis

Search a codebase or a document corpus by meaning, trace who calls a symbol, recall what was
decided before.

Needs a running [letapis](https://github.com/letapis-ai/letapis-core) engine — the plugin talks
to it and ships nothing that searches on its own.

## Installing

```
/plugin marketplace add straga/letapis-plugin
/plugin install letapis@letapis
```

From a checkout, for development:

```
claude --plugin-dir /path/to/letapis-plugin
```

## What it adds

- **Tools** — `search`, `blast_radius`, `ena_get_context`, and the rest of the engine's surface
  on demand.
- **A skill** — how to ask, how to read an answer, what an empty result means.
- **A hook** — at session start, recall the last few days from memory before acting.

## Configuration

The engine address lives in `.mcp.json`. Default is `http://localhost:3131`.

## Documentation

[letapis-core](https://github.com/letapis-ai/letapis-core) — the engine, its setup and its API.
