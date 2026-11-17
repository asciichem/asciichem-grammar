# Grammar artifact checksums

The compiled artifact is committed HERE — this repository is the
single source of truth for both the PARG text contract and the
compiled artifact every runtime vendors. Verify your vendored copy
against this file in CI; a mismatch means you drifted from the
contract.

## grammar-v0.7.0 (the current pin)

| File | sha256 |
|---|---|
| `asciichem.parg` (the PARG text contract) | `d40377f7318f4619de9d84bb381668689855ce265fa7b5b31affee93ea061b09` |
| `asciichem.json` (the compiled artifact) | `0d163020614f170680ded929a3b4a3490dedc1c2101035747dd3c5668c167229` |

Artifact header: grammar `AsciiChemCore`, artifact version `0.7.0`,
shape `parsanol-tree/v2`, binding_version 1.

**The v0.7.0 change (asciichem-ruby#188, part 2 — the aromatic text
bond):** the `bond` rule gains `":" as aromatic` (ahead of the plain
dash) — the text grammar now parses the aromatic-bond spelling the
writers emit for SMILES/molfile-ingested aromatic rings. Before this,
`@smiles("c1ccccc1")` canonicalised to `C1:C:C:C:C:C1`, which the text
grammar itself rejected — the writer-only bond form. The inline suite
carries the accepts. The lint baseline is unchanged (29 advisories).

## grammar-v0.6.0 (superseded)

| File | sha256 |
|---|---|
| `asciichem.parg` (the PARG text contract) | `fe6eb0c21a0427095c45927f0557e8bdaeb40d5f84bec96e5d55731a19460a74` |
| `asciichem.json` (the compiled artifact) | `bc14145fa033472cc18363a3ca0ebd512e262d3a43c9329a2dd0e9cc34d9a068` |

Artifact header: grammar `AsciiChemCore`, artifact version `0.6.0`,
shape `parsanol-tree/v2`, binding_version 1.

**The v0.6.0 change (asciichem-rs#45 — the structure reference):**
`formula_node` gains the leading `structure_reference` alternative —
`@smiles("...")` standing alone is an ingest edge, the same posture
as the CLI's `-i smiles` input mode: the annotation carries the
structure in, the model is the molecule the runtime's own SMILES
reader produces. The attached form (`molecule @smiles("...")`) is
unchanged — there it stays the identifier annotation it has always
been. `ref_type` is captured so later sources (`@molfile`, `@inchi`)
join as data, not grammar; v1 carries `smiles` only and the grammar
hard-codes the word (a standalone `@molfile(...)` rejects at parse).
The inline suite carries the accepts and the rejects. The lint
baseline is unchanged (29 order-dependence advisories, the
classification is ordered choice by design).

## grammar-v0.5.0 (superseded)

| File | sha256 |
|---|---|
| `asciichem.parg` (the PARG text contract) | `7bd31dd8b31e514b9b2b91f459323ddadee30bbd773d70baa8bd6eb527191529` |
| `asciichem.json` (the compiled artifact) | `88024d6ec31e061011dc255106cb205ed9877105d8e691e5a56abbb7cb1d7e9f` |

Artifact header: grammar `AsciiChemCore`, artifact version `0.5.0`,
shape `parsanol-tree/v2`, binding_version 1.

**The v0.5.0 change (model#16, option B — the grammar narrows):**
`known_annotation_type` drops `iupac` and `cid`, and `property_name`
(the lowercase catch-all that would otherwise re-admit them as
property annotations) gains the `!"iupac" !"cid"` exclusion
predicates — so `@iupac(...)` and `@cid(...)` REJECT at parse time
across all runtimes. Corpus parity verified: 275 fixtures, 0
mismatches under the narrowed grammar (including the two new reject
fixtures). `chebi` remains (schema-valid, validator-less).

## grammar-v0.4.0 (superseded)

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
