# HTA Transportability Engine: multi-persona peer review

This memo applies the recurring concerns in the supplied peer-review document to the current F1000 draft for this project (`HTA_Transportability_Engine`). It distinguishes changes already made in the draft from repository-side items that still need to hold in the released repository and manuscript bundle.

## Detected Local Evidence
- Detected documentation files: `README.md`, `f1000_artifacts/tutorial_walkthrough.md`.
- Detected environment capture or packaging files: `environment.yml`.
- Detected validation/test artifacts: `f1000_artifacts/validation_summary.md`, `tests/run_tests.R`, `tests/test_transportability.R`.
- Detected browser deliverables: `Transportability_Dashboard.html`.
- Detected public repository root: `https://github.com/mahmood726-cyber/hta-transportability`.
- Detected public source snapshot: Fixed public commit snapshot available at `https://github.com/mahmood726-cyber/hta-transportability/tree/44cca520b46a7c341849b5071287de251643a4bd`.
- Detected public archive record: No project-specific DOI or Zenodo record URL was detected locally; archive registration pending.

## Reviewer Rerun Companion
- `F1000_Reviewer_Rerun_Manifest.md` consolidates the shortest reviewer-facing rerun path, named example files, environment capture, and validation checkpoints.

## Detected Quantitative Evidence
- `transportability_cv_summary.md` reports 465 reviews modeled; reported: RMSE = 6.344, MAE = 1.096 (n = 3854); or: RMSE = 0.708, MAE = 0.451 (n = 8509).
- `transportability_domain_cv_summary.md` reports endocrine_metabolic: 293 rows, 8 reviews, 10 reviews_in_list.
- `transportability_target_cv_summary.md` reports reported: RMSE = 6.424, MAE = 1.113 (n = 3762).

## Current Draft Strengths
- States the project rationale and niche explicitly: Meta-analytic estimates are often applied to populations that differ from the historical trial populations that generated them. HTA teams therefore need a reproducible way to quantify temporal drift, enrollment shift, and population mismatch rather than discussing generalizability only qualitatively.
- Names concrete worked-example paths: `paper/cte_manuscript.md` and `PROTOCOL_CTE.md` as local narrative references; `transportability_target_summary.md` and `transportability_domain_report.md` for precomputed outputs; `Transportability_Dashboard.html` for interactive inspection.
- Points reviewers to local validation materials: `tests/test_transportability.R` and `tests/run_tests.R` for code-level regression checks; `transportability_cv_summary.md` and domain-level CV outputs for predictive assessment; Saved CT.gov query terms, counts, and merged covariate tables for auditability.
- Moderates conclusions and lists explicit limitations for HTA Transportability Engine.

## Remaining High-Priority Fixes
- Keep one minimal worked example public and ensure the manuscript paths match the released files.
- Ensure README/tutorial text, software availability metadata, and public runtime instructions stay synchronized with the manuscript.
- Confirm that the cited repository root resolves to the same fixed public source snapshot used for the submission package.
- Mint and cite a Zenodo DOI or record URL for the tagged release; none was detected locally.
- Reconfirm the quoted benchmark or validation sentence after the final rerun so the narrative text stays synchronized with the shipped artifacts.
- Keep the embedded WebR validation panel enabled in public HTML releases and rerun it after any UI or calculation changes.

## Persona Reviews

### Reproducibility Auditor
- Review question: Looks for a frozen computational environment, a fixed example input, and an end-to-end rerun path with saved outputs.
- What the revised draft now provides: The revised draft names concrete rerun assets such as `paper/cte_manuscript.md` and `PROTOCOL_CTE.md` as local narrative references; `transportability_target_summary.md` and `transportability_domain_report.md` for precomputed outputs and ties them to validation files such as `tests/test_transportability.R` and `tests/run_tests.R` for code-level regression checks; `transportability_cv_summary.md` and domain-level CV outputs for predictive assessment.
- What still needs confirmation before submission: Before submission, freeze the public runtime with `environment.yml` and keep at least one minimal example input accessible in the external archive.

### Validation and Benchmarking Statistician
- Review question: Checks whether the paper shows evidence that outputs are accurate, reproducible, and compared against known references or stress tests.
- What the revised draft now provides: The manuscript now cites concrete validation evidence including `tests/test_transportability.R` and `tests/run_tests.R` for code-level regression checks; `transportability_cv_summary.md` and domain-level CV outputs for predictive assessment; Saved CT.gov query terms, counts, and merged covariate tables for auditability and frames conclusions as being supported by those materials rather than by interface availability alone.
- What still needs confirmation before submission: Concrete numeric evidence detected locally is now available for quotation: `transportability_cv_summary.md` reports 465 reviews modeled; reported: RMSE = 6.344, MAE = 1.096 (n = 3854); or: RMSE = 0.708, MAE = 0.451 (n = 8509); `transportability_domain_cv_summary.md` reports endocrine_metabolic: 293 rows, 8 reviews, 10 reviews_in_list.

### Methods-Rigor Reviewer
- Review question: Examines modeling assumptions, scope conditions, and whether method-specific caveats are stated instead of implied.
- What the revised draft now provides: The architecture and discussion sections now state the method scope explicitly and keep caveats visible through limitations such as ClinicalTrials.gov is an imperfect target-population proxy and may truncate large result sets; The model uses population-level covariates and cannot guarantee individual-level transportability.
- What still needs confirmation before submission: Retain method-specific caveats in the final Results and Discussion and avoid collapsing exploratory thresholds or heuristics into universal recommendations.

### Comparator and Positioning Reviewer
- Review question: Asks what gap the tool fills relative to existing software and whether the manuscript avoids unsupported superiority claims.
- What the revised draft now provides: The introduction now positions the software against an explicit comparator class: The appropriate comparison is not a conventional meta-analysis package alone, but the broader HTA practice of qualitative indirectness assessment. The engine adds a quantitative proxy and is presented as a supplement to, not a replacement for, substantive clinical judgment.
- What still needs confirmation before submission: Keep the comparator discussion citation-backed in the final submission and avoid phrasing that implies blanket superiority over better-established tools.

### Documentation and Usability Reviewer
- Review question: Looks for a README, tutorial, worked example, input-schema clarity, and short interpretation guidance for outputs.
- What the revised draft now provides: The revised draft points readers to concrete walkthrough materials such as `paper/cte_manuscript.md` and `PROTOCOL_CTE.md` as local narrative references; `transportability_target_summary.md` and `transportability_domain_report.md` for precomputed outputs; `Transportability_Dashboard.html` for interactive inspection and spells out expected outputs in the Methods section.
- What still needs confirmation before submission: Make sure the public archive exposes a readable README/tutorial bundle: currently detected files include `README.md`, `f1000_artifacts/tutorial_walkthrough.md`.

### Software Engineering Hygiene Reviewer
- Review question: Checks for evidence of testing, deployment hygiene, browser/runtime verification, secret handling, and removal of obvious development leftovers.
- What the revised draft now provides: The draft now foregrounds regression and validation evidence via `f1000_artifacts/validation_summary.md`, `tests/run_tests.R`, `tests/test_transportability.R`, and browser-facing projects are described as self-validating where applicable.
- What still needs confirmation before submission: Before submission, remove any dead links, exposed secrets, or development-stage text from the public repo and ensure the runtime path described in the manuscript matches the shipped code.

### Claims-and-Limitations Editor
- Review question: Verifies that conclusions are bounded to what the repository actually demonstrates and that limitations are explicit.
- What the revised draft now provides: The abstract and discussion now moderate claims and pair them with explicit limitations, including ClinicalTrials.gov is an imperfect target-population proxy and may truncate large result sets; The model uses population-level covariates and cannot guarantee individual-level transportability; Thresholds for HTA action are exploratory and need external validation against real-world outcomes.
- What still needs confirmation before submission: Keep the conclusion tied to documented functions and artifacts only; avoid adding impact claims that are not directly backed by validation, benchmarking, or user-study evidence.

### F1000 and Editorial Compliance Reviewer
- Review question: Checks for manuscript completeness, software/data availability clarity, references, and reviewer-facing support files.
- What the revised draft now provides: The revised draft is more complete structurally and now points reviewers to software availability, data availability, and reviewer-facing support files.
- What still needs confirmation before submission: Confirm repository/archive metadata, figure/export requirements, and supporting-file synchronization before release.
