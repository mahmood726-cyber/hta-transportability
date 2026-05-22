# HTA Transportability Engine

[![tests](https://github.com/mahmood726-cyber/hta-transportability/actions/workflows/tests.yml/badge.svg)](https://github.com/mahmood726-cyber/hta-transportability/actions/workflows/tests.yml)

A reproducible R pipeline for assessing **transportability of meta-analytic
treatment effects** from Pairwise70 systematic reviews to target populations
approximated by ClinicalTrials.gov (CT.gov) registry covariates.

The engine derives study-level effect sizes, fits a Covariate Transportability
Estimator (CTE), and reports a leakage / robustness classification per analysis.

## Repository layout

| Path | Purpose |
|------|---------|
| `01_audit_pairwise70.R` – `14_ctgov_domain_aggregate.R` | Numbered pipeline scripts (see `transportability_pipeline.md`) |
| `config_paths.R` | Resolves `PAIRWISE70_ROOT` (env var, or common local paths) |
| `cte_penalty_model.R` | Core CTE penalty implementation |
| `tests/` | `testthat` suite covering effect size, CTE, and transport class logic |
| `paper/`, `f1000_artifacts/`, `e156-submission/` | Manuscript and submission material |
| `docs/`, `external/` | Protocol and registry cache directories |
| `*.csv`, `*.md` (root) | Pipeline outputs and audit summaries (committed for reviewer reproducibility) |

## Installation

```bash
# Conda / mamba (recommended)
conda env create -f environment.yml
conda activate hta-transportability-reviewer
```

If you prefer a system R installation, the suite requires R ≥ 4.3 with
`metafor`, `data.table`, `jsonlite`, `readr`, `dplyr`, and `testthat`.

## Quick start

1. Point the pipeline at your Pairwise70 data:
   ```bash
   export PAIRWISE70_ROOT=/path/to/Pairwise70
   ```
2. Run the audit and scaffold:
   ```bash
   Rscript 01_audit_pairwise70.R
   Rscript 03_transportability_scaffold.R
   ```
3. Build queries, fetch CT.gov data, and merge:
   ```bash
   Rscript 05_build_ctgov_queries.R
   Rscript 06_ctgov_fetch.R
   Rscript 07_ctgov_aggregate.R
   Rscript 08_transportability_merge.R
   ```
4. Run cross-validation and the domain report:
   ```bash
   Rscript 09_transportability_target_cv.R
   Rscript 10_transportability_domain_cv.R
   Rscript 11_transportability_domain_report.R
   ```

See `transportability_pipeline.md` for the full step-by-step description,
including the optional CT.gov rate-limit / pagination environment variables.

## Tests

```bash
Rscript tests/run_tests.R
```

The suite validates the SE-from-CI formula, the CTE penalty bound, transport
class thresholds, and (when present) the columns and finiteness of
`output/transportability_results.csv`.

## F1000 / E156 submission package

- Manuscript: `F1000_Software_Tool_Article.md`
- Cover letter: `F1000_Cover_Letter.md`
- Submission checklist: `F1000_Submission_Checklist_RealReview.md`
- Reviewer rerun manifest: `F1000_Reviewer_Rerun_Manifest.md`
- E156 submission bundle: `e156-submission/`

## License

MIT — see `LICENSE`.

## Citation

Metadata for citation (Zenodo) lives in `.zenodo.json`.
