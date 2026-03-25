# HTA Transportability Engine: reviewer rerun manifest

This manifest is the shortest reviewer-facing rerun path for the local software package. It lists the files that should be sufficient to recreate one worked example, inspect saved outputs, and verify that the manuscript claims remain bounded to what the repository actually demonstrates.

## Reviewer Entry Points
- Project directory: `C:\Models\HTA_Transportability_Engine`.
- Preferred documentation start points: `README.md`, `f1000_artifacts/tutorial_walkthrough.md`.
- Detected public repository root: `https://github.com/mahmood726-cyber/hta-transportability`.
- Detected public source snapshot: Fixed public commit snapshot available at `https://github.com/mahmood726-cyber/hta-transportability/tree/44cca520b46a7c341849b5071287de251643a4bd`.
- Detected public archive record: No project-specific DOI or Zenodo record URL was detected locally; archive registration pending.
- Environment capture files: `environment.yml`.
- Validation/test artifacts: `f1000_artifacts/validation_summary.md`, `tests/run_tests.R`, `tests/test_transportability.R`.

## Worked Example Inputs
- Manuscript-named example paths: `paper/cte_manuscript.md` and `PROTOCOL_CTE.md` as local narrative references; `transportability_target_summary.md` and `transportability_domain_report.md` for precomputed outputs; `Transportability_Dashboard.html` for interactive inspection; f1000_artifacts/example_dataset.csv.
- Auto-detected sample/example files: `f1000_artifacts/example_dataset.csv`.

## Expected Outputs To Inspect
- Transportability penalties and efficacy-leakage classes.
- Target-population and domain-level cross-validation reports.
- An HTA dashboard summarizing high-, medium-, and low-transportability findings.

## Minimal Reviewer Rerun Sequence
- Start with the README/tutorial files listed below and keep the manuscript paths synchronized with the public archive.
- Create the local runtime from the detected environment capture files if available: `environment.yml`.
- Run at least one named example path from the manuscript and confirm that the generated outputs match the saved validation materials.
- Quote one concrete numeric result from the local validation snippets below when preparing the final software paper.
- Open the browser deliverable and confirm that the embedded WebR validation panel completes successfully after the page finishes initializing.

## Local Numeric Evidence Available
- `transportability_cv_summary.md` reports 465 reviews modeled; reported: RMSE = 6.344, MAE = 1.096 (n = 3854); or: RMSE = 0.708, MAE = 0.451 (n = 8509).
- `transportability_domain_cv_summary.md` reports endocrine_metabolic: 293 rows, 8 reviews, 10 reviews_in_list.
- `transportability_target_cv_summary.md` reports reported: RMSE = 6.424, MAE = 1.113 (n = 3762).

## Browser Deliverables
- HTML entry points: `Transportability_Dashboard.html`.
- The shipped HTML applications include embedded WebR self-validation and should be checked after any UI or calculation change.
