# Changelog

## 2026-05-20
- Added `Makefile` with `test`, `pipeline`, and per-step targets so reviewers can reproduce results with a single command and so the canonical script ordering is discoverable from `make help`.
- Added schema-integrity tests for `f1000_artifacts/example_dataset.csv` (required columns, finite effects, plausible bounds) so the F1000 reviewer reproduction artifact can't silently rot.
- Documented `cte_penalty_model.R` and the HIGH/MEDIUM/LOW thresholds in `transportability_pipeline.md`; the pipeline doc previously stopped at the CV stage and never referenced the script that produces the transport-class classification.
- Updated `README.md` to point at the new Makefile.
- Fixed transport-class threshold mismatch in `tests/test_transportability.R`: HIGH boundary is `>= 0.90`, not `>= 0.85`, to match `cte_penalty_model.R` and `paper/cte_manuscript.md`. Added boundary cases around 0.89/0.69 so the test now catches regressions on either side of the cutoff.
- Fixed `config_paths.R` `PROJECT_ROOT` resolution: replaced `%||%` (base R >= 4.4) with a `tryCatch`-based fallback so scripts that don't load `dplyr`/`rlang` before `source("config_paths.R")` work under R 4.3 (as pinned in `environment.yml`).
- Added `CITATION.cff` (referenced by `push.sh`) generated from `.zenodo.json` so GitHub renders a "Cite this repository" widget.
- Made `tests/run_tests.R` portable (removed hardcoded Windows `setwd`); now auto-resolves the repo root and exits non-zero on failure so CI can detect regressions.
- Added GitHub Actions workflow (`.github/workflows/tests.yml`) to run the `testthat` suite on push and pull request.
- Expanded `README.md` with a repository map, install / quick-start, test instructions, submission-package pointers, and a CI badge.
- Strengthened `.gitignore` for R/Python projects (RStudio, Renviron, pytest, editor, and CT.gov raw cache directories).

## 2026-03-06
- Added F1000 software tool manuscript package.
- Added real-review-aligned submission checklist.
- Added metadata files for reproducibility readiness.
