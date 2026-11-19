# Grammar artifact checksums

The compiled artifact is committed HERE — this repository is the
single source of truth for both the PARG text contract and the
compiled artifact every runtime vendors. Verify your vendored copy
against this file in CI; a mismatch means you drifted from the
contract.

## grammar-v0.9.0 (the current pin)

| File | sha256 |
|---|---|
| `asciichem.parg` (the PARG text contract) | `ca9e69cccc5cfb044a2fb51b176afd88b92ec61bc1ccf1ea5c2acb56a6504ebc` |
| `asciichem.json` (the compiled artifact) | `337468e78f7da6a8c989985b7150f0fe9ad138f2eaf395fba095b27643f46f4d` |

Artifact header: grammar `AsciiChemCore`, artifact version `0.9.0`,
shape `parsanol-tree/v2`, binding_version 1.

**The v0.9.0 change (asciichem-ruby#202 — the adduct):** the new
`adduct` formula_node alternative — the middle-dot connective
between molecules at the FORMULA level. `CuSO4 . 5H2O` parses as one
`adduct` node whose components carry the molecules (the coefficient
carries each multiplicity; n-ary, mapping one-to-one onto the InChI
multi-component layers). The ASCII spelling is the period with
whitespace on both sides; the literal middle dot (·) is accepted as
the mhchem alias. The UNspaced period stays radical-suffix territory
(`Cl.` is one radical electron) — all three readings resolve by
construction, no whitespace rule surprises. The canonical text emits
the ASCII ` . ` form. The lint baseline moves 29 → 34
order-dependence advisories (the new ordered-choice alternatives,
the classification is ordered choice by design). Inline suite: three
new accepts. Corpus parity: 300 fixtures, 0 mismatches.

## grammar-v0.8.0 (superseded)

| File | sha256 |
|---|---|
| `asciichem.parg` (the PARG text contract) | `81738c28a1c88ad7a77567ed6488c89160ad141ea33f28c040b8af41f39883c3` |
| `asciichem.json` (the compiled artifact) | `86a62ebd000b4952a72aa0802be609a16b069e77a2bf888d87ffb609e47498df` |

Artifact header: grammar `AsciiChemCore`, artifact version `0.8.0`,
shape `parsanol-tree/v2`, binding_version 1.

**The v0.8.0 change (asciichem-ruby#201 — the atomic-number prefix):**
`prefixed_atom` gains an optional `atomic_number` capture — mhchem's
left-subscript isotope component. `^227_90Th` carries isotope 227 AND
atomic number 90. The atomic number only arrives attached to a
`^`-mass prefix: the standalone `_90Th` keeps its legacy isotope
reading (never breaking), and after the element the `_digits` suffix
stays a subscript (`^14C_6` is six carbons-14). The linter
cross-checks the pair against the element's real Z. Inline suite:
two new accepts. Corpus parity: 295 fixtures, 0 mismatches. The lint
baseline is unchanged (29 order-dependence advisories).

## grammar-v0.7.0 (superseded)

| File | sha256 |
|---|---|
| `asciichem.parg` (the PARG text contract) | `56e560fa869b330d5fcef1d5fb435e8884e0b89e2b388d1aa97b2e3aec6048d8` |
| `asciichem.json` (the compiled artifact) | `7c1d337555b424dfd8d33a5f021b0553cb2e54ff7af62560ea7e571243016a95` |

Artifact header: grammar `AsciiChemCore`, artifact version `0.7.0`,
shape `parsanol-tree/v2`, binding_version 1.

**The v0.7.0 change (asciichem-ruby#199 — the state markers):**
`molecule` gains an optional trailing `state` capture — the mhchem
phase glyph. `AgCl v` is the precipitate mark (typeset ↓), `AgCl ^`
the gas mark (↑). The mark is whitespace-separated and lowercase-only
so it cannot collide with a vanadium atom (uppercase `V`), and for `^`
the tight forms keep their existing meaning: `AgCl^14C` (isotope
prefix) and `Ca^2+` (charge superscript) bind to the adjacent atom
without whitespace, while a separated ` ^` is the gas mark — `Ca ^2+`
rejects at parse. Renderers type the glyph; the model carries
`precipitate` / `gas`. The inline suite carries the accepts and the
new reject. Corpus parity: 284 fixtures, the single pre-existing
`structure-reference/dot-components` harness mismatch (the PARG sees
the quoted payload opaquely; the reject is runtime-level, tracked by
chemomer#131) — zero new mismatches. The lint baseline is unchanged
(29 order-dependence advisories, the classification is ordered choice
by design).

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
