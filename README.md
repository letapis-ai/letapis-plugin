# letapis

An index over the code and documents you point it at, and four kinds of question it answers:

- **What is there about this?** Search by meaning, not by string — the middleware and the doc
  that explains the flow come back for "authentication", though neither says the word.
- **Who calls this?** Callers and readers of a symbol, with file and line, read off disk — so
  switching a branch needs no reindex.
- **What did we decide before?** Episodic memory: what happened, what it led to, what turned
  out to be wrong.
- **What is in this document?** A research graph over a book, a paper or an unfamiliar
  codebase, and the findings you keep from it.

Git worktrees are first-class: index a branch checkout beside the trunk, and each caller sees
its own — the copy answers the one working in it, and nobody else's results change.

Needs a running [letapis](https://github.com/letapis-ai/letapis-core) engine — the plugin talks
to it and searches nothing on its own.

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

- **Tools** — `search`, `blast_radius`, `ena_get_context` stay in the window; the rest of the
  engine's surface loads on demand.
- **A skill** — how to ask, how to read an answer, what an empty result means.
- **A hook** — at session start, recall the last few days from memory before acting.

## Configuration

The engine address lives in `.mcp.json`. Default is `http://localhost:3131`.

On a fresh install the first session comes up without the tools: `uv` is still building the
proxy's environment. Restart once and they are there.

## Documentation

[letapis-core](https://github.com/letapis-ai/letapis-core) — the engine, its setup and its API.
