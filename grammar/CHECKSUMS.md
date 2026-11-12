# Grammar artifact checksums

The compiled artifact is committed HERE — this repository is the
single source of truth for both the PARG text contract and the
compiled artifact every runtime vendors. Verify your vendored copy
against this file in CI; a mismatch means you drifted from the
contract.

## grammar-v0.4.0 (the current pin)

| File | sha256 |
|---|---|
| `asciichem.parg` (the PARG text contract) | `a94cfb4f59936a381e9974e8c141c661e56a25babe46d64b0a288bfd0b4b3e3d` |
| `asciichem.json` (the compiled artifact) | `b5c1f5289f0487e974091e451f5b2703c12c861347c09dd8332bdcfd1822c34f` |

Artifact header: grammar `AsciiChemCore`, artifact version `0.4.0`,
shape `parsanol-tree/v2`, binding_version 1.

## Vendored today (verified byte-identical, 2026-11-12)

| Runtime | Path |
|---|---|
| asciichem-rs | `artifacts/asciichem.json` (embedded via `include_str!`) |
| asciichem-ruby | `lib/asciichem/engine/parg/asciichem.json` |
| asciichem-ts | `src/parg/asciichem.json` |
| asciichem-py | `src/asciichem/parg/asciichem.json` |

## Compiling

`grammar/asciichem.json` is produced by the Parsanol::PARG compiler
from `asciichem.parg` (see the pipeline in the README). The compiled
bytes are committed here so a runtime's only build-time dependency is
THIS repository — never another implementation. Re-compiling and
committing the result is part of any grammar change: bump the version,
update this file, tag `grammar-vX.Y.Z`, then ride the new tag across
the runtimes.
