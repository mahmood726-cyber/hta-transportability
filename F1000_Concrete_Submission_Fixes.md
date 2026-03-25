# HTA Transportability Engine: concrete submission fixes

This file converts the multi-persona review into repository-side actions that should be checked before external submission of the F1000 software paper for `HTA_Transportability_Engine`.

## Detectable Local State
- Documentation files detected: `README.md`, `f1000_artifacts/tutorial_walkthrough.md`.
- Environment lock or container files detected: `environment.yml`.
- Package manifests detected: none detected.
- Example data files detected: `f1000_artifacts/example_dataset.csv`.
- Validation artifacts detected: `f1000_artifacts/validation_summary.md`, `tests/run_tests.R`, `tests/test_transportability.R`.
- Detected public repository root: `https://github.com/mahmood726-cyber/hta-transportability`.
- Detected public source snapshot: Fixed public commit snapshot available at `https://github.com/mahmood726-cyber/hta-transportability/tree/44cca520b46a7c341849b5071287de251643a4bd`.
- Detected public archive record: No project-specific DOI or Zenodo record URL was detected locally; archive registration pending.

## High-Priority Fixes
- Check that the manuscript's named example paths exist in the public archive and can be run without repository archaeology.
- Confirm that the cited repository root (`https://github.com/mahmood726-cyber/hta-transportability`) resolves to the same fixed public source snapshot used for submission.
- Archive the tagged release and insert the Zenodo DOI or record URL once it has been minted; no project-specific archive DOI was detected locally.
- Reconfirm the quoted benchmark or validation sentence after the final rerun so the narrative text matches the shipped artifacts.
- Keep the embedded WebR validation panel enabled in shipped HTML files and rerun it after any UI or calculation changes.

## Numeric Evidence Available To Quote
- `transportability_cv_summary.md` reports 465 reviews modeled; reported: RMSE = 6.344, MAE = 1.096 (n = 3854); or: RMSE = 0.708, MAE = 0.451 (n = 8509).
- `transportability_domain_cv_summary.md` reports endocrine_metabolic: 293 rows, 8 reviews, 10 reviews_in_list.
- `transportability_target_cv_summary.md` reports reported: RMSE = 6.424, MAE = 1.113 (n = 3762).

## Manuscript Files To Keep In Sync
- `F1000_Software_Tool_Article.md`
- `F1000_Reviewer_Rerun_Manifest.md`
- `F1000_MultiPersona_Review.md`
- `F1000_Submission_Checklist_RealReview.md` where present
- README/tutorial files and the public repository release metadata
