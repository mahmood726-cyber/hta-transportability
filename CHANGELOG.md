# Changelog

## 2026-05-20
- Made `tests/run_tests.R` portable (removed hardcoded Windows `setwd`); now auto-resolves the repo root and exits non-zero on failure so CI can detect regressions.
- Added GitHub Actions workflow (`.github/workflows/tests.yml`) to run the `testthat` suite on push and pull request.
- Expanded `README.md` with a repository map, install / quick-start, test instructions, and submission-package pointers.
- Strengthened `.gitignore` for R/Python projects (RStudio, Renviron, pytest, editor, and CT.gov raw cache directories).

## 2026-03-06
- Added F1000 software tool manuscript package.
- Added real-review-aligned submission checklist.
- Added metadata files for reproducibility readiness.
