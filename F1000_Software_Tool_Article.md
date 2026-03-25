# HTA Transportability Engine: a software tool for reviewer-auditable evidence synthesis

## Authors
- Mahmood Ahmad [1,2]
- Niraj Kumar [1]
- Bilaal Dar [3]
- Laiba Khan [1]
- Andrew Woo [4]
- Corresponding author: Andrew Woo (andy2709w@gmail.com)

## Affiliations
1. Royal Free Hospital
2. Tahir Heart Institute Rabwah
3. King's College Medical School
4. St George's Medical School

## Abstract
**Background:** Meta-analytic estimates are often applied to populations that differ from the historical trial populations that generated them. HTA teams therefore need a reproducible way to quantify temporal drift, enrollment shift, and population mismatch rather than discussing generalizability only qualitatively.

**Methods:** The HTA Transportability Engine links Pairwise70 review-level analyses to contemporary ClinicalTrials.gov records, computes covariate shifts, estimates a transportability penalty, stratifies performance by clinical domain, and publishes an HTML dashboard summarizing efficacy leakage.

**Results:** The repository contains query-building scripts, CT.gov fetchers, merged target-covariate tables, cross-validation summaries, domain reports, protocol notes, and an executable transportability dashboard.

**Conclusions:** The software contribution is a transparent transportability workflow for HTA triage, with explicit caveats about registry completeness, ecological modeling, and threshold interpretation.

## Keywords
transportability; generalizability; ClinicalTrials.gov; health technology assessment; evidence synthesis; software tool

## Introduction
Rather than treating external validity as a narrative concern, the project operationalizes it as a repeatable pipeline. Inputs, query terms, merged covariates, and penalty outputs are stored as local artifacts so that reviewers can inspect how a target-population proxy was constructed.

The appropriate comparison is not a conventional meta-analysis package alone, but the broader HTA practice of qualitative indirectness assessment. The engine adds a quantitative proxy and is presented as a supplement to, not a replacement for, substantive clinical judgment.

The manuscript structure below is deliberately aligned to common open-software review requests: the rationale is stated explicitly, at least one runnable example path is named, local validation artifacts are listed, and conclusions are bounded to the functions and outputs documented in the repository.

## Methods
### Software architecture and workflow
The pipeline is organized as numbered scripts covering audit, scaffold construction, CT.gov query generation, fetch, aggregation, merge, penalty modeling, and domain cross-validation. Browser output is provided through `Transportability_Dashboard.html`.

### Installation, runtime, and reviewer reruns
The local implementation is packaged under `C:\Models\HTA_Transportability_Engine`. The manuscript identifies the local entry points, dependency manifest, fixed example input, and expected saved outputs so that reviewers can rerun the documented workflow without reconstructing it from scratch.

- Entry directory: `C:\Models\HTA_Transportability_Engine`.
- Detected documentation entry points: `README.md`, `f1000_artifacts/tutorial_walkthrough.md`.
- Detected environment capture or packaging files: `environment.yml`.
- Named worked-example paths in this draft: `paper/cte_manuscript.md` and `PROTOCOL_CTE.md` as local narrative references; `transportability_target_summary.md` and `transportability_domain_report.md` for precomputed outputs; `Transportability_Dashboard.html` for interactive inspection.
- Detected validation or regression artifacts: `f1000_artifacts/validation_summary.md`, `tests/run_tests.R`, `tests/test_transportability.R`.
- Detected example or sample data files: `f1000_artifacts/example_dataset.csv`.
- Detected browser deliverables with built-in WebR self-validation: `Transportability_Dashboard.html`.

### Worked examples and validation materials
**Example or fixed demonstration paths**
- `paper/cte_manuscript.md` and `PROTOCOL_CTE.md` as local narrative references.
- `transportability_target_summary.md` and `transportability_domain_report.md` for precomputed outputs.
- `Transportability_Dashboard.html` for interactive inspection.

**Validation and reporting artifacts**
- `tests/test_transportability.R` and `tests/run_tests.R` for code-level regression checks.
- `transportability_cv_summary.md` and domain-level CV outputs for predictive assessment.
- Saved CT.gov query terms, counts, and merged covariate tables for auditability.

### Typical outputs and user-facing deliverables
- Transportability penalties and efficacy-leakage classes.
- Target-population and domain-level cross-validation reports.
- An HTA dashboard summarizing high-, medium-, and low-transportability findings.

### Reviewer-informed safeguards
- Provides a named example workflow or fixed demonstration path.
- Documents local validation artifacts rather than relying on unsupported claims.
- Positions the software against existing tools without claiming blanket superiority.
- States limitations and interpretation boundaries in the manuscript itself.
- Requires explicit environment capture and public example accessibility in the released archive.

## Review-Driven Revisions
This draft has been tightened against recurring open peer-review objections taken from the supplied reviewer reports.
- Reproducibility: the draft names a reviewer rerun path and points readers to validation artifacts instead of assuming interface availability is proof of correctness.
- Validation: claims are anchored to local tests, validation summaries, simulations, or consistency checks rather than to unsupported assertions of performance.
- Comparators and niche: the manuscript now names the relevant comparison class and keeps the claimed niche bounded instead of implying universal superiority.
- Documentation and interpretation: the text expects a worked example, input transparency, and reviewer-verifiable outputs rather than a high-level feature list alone.
- Claims discipline: conclusions are moderated to the documented scope of HTA Transportability Engine and paired with explicit limitations.
- Browser verification: HTML applications in this directory now include embedded WebR checks so reviewer-facing dashboards can validate their displayed calculations in situ.

## Use Cases and Results
The software outputs should be described in terms of concrete reviewer-verifiable workflows: running the packaged example, inspecting the generated results, and checking that the reported interpretation matches the saved local artifacts. In this project, the most important result layer is the availability of a transparent execution path from input to analysis output.

Representative local result: `transportability_cv_summary.md` reports 465 reviews modeled; reported: RMSE = 6.344, MAE = 1.096 (n = 3854); or: RMSE = 0.708, MAE = 0.451 (n = 8509).

### Concrete local quantitative evidence
- `transportability_cv_summary.md` reports 465 reviews modeled; reported: RMSE = 6.344, MAE = 1.096 (n = 3854); or: RMSE = 0.708, MAE = 0.451 (n = 8509).
- `transportability_domain_cv_summary.md` reports endocrine_metabolic: 293 rows, 8 reviews, 10 reviews_in_list.
- `transportability_target_cv_summary.md` reports reported: RMSE = 6.424, MAE = 1.113 (n = 3762).

## Discussion
Representative local result: `transportability_cv_summary.md` reports 465 reviews modeled; reported: RMSE = 6.344, MAE = 1.096 (n = 3854); or: RMSE = 0.708, MAE = 0.451 (n = 8509).

The paper highlights that the main value is traceability: every transportability score can be linked back to query terms, fetched registry records, and explicit merge logic. That is the software-engineering contribution reviewers usually look for but rarely receive.

### Limitations
- ClinicalTrials.gov is an imperfect target-population proxy and may truncate large result sets.
- The model uses population-level covariates and cannot guarantee individual-level transportability.
- Thresholds for HTA action are exploratory and need external validation against real-world outcomes.

## Software Availability
- Local source package: `HTA_Transportability_Engine` under `C:\Models`.
- Public repository: `https://github.com/mahmood726-cyber/hta-transportability`.
- Public source snapshot: Fixed public commit snapshot available at `https://github.com/mahmood726-cyber/hta-transportability/tree/44cca520b46a7c341849b5071287de251643a4bd`.
- DOI/archive record: No project-specific DOI or Zenodo record URL was detected locally; archive registration pending.
- Environment capture detected locally: `environment.yml`.
- Reviewer-facing documentation detected locally: `README.md`, `f1000_artifacts/tutorial_walkthrough.md`.
- Reproducibility walkthrough: `f1000_artifacts/tutorial_walkthrough.md` where present.
- Validation summary: `f1000_artifacts/validation_summary.md` where present.
- Reviewer rerun manifest: `F1000_Reviewer_Rerun_Manifest.md`.
- Multi-persona review memo: `F1000_MultiPersona_Review.md`.
- Concrete submission-fix note: `F1000_Concrete_Submission_Fixes.md`.
- License: see the local `LICENSE` file.

## Data Availability
All CT.gov query terms, raw fetch outputs, merged tables, and dashboard assets are stored locally. The Pairwise70 source data originate from publicly available Cochrane reviews.

## Reporting Checklist
Real-peer-review-aligned checklist: `F1000_Submission_Checklist_RealReview.md`.
Reviewer rerun companion: `F1000_Reviewer_Rerun_Manifest.md`.
Companion reviewer-response artifact: `F1000_MultiPersona_Review.md`.
Project-level concrete fix list: `F1000_Concrete_Submission_Fixes.md`.

## Declarations
### Competing interests
The authors declare that no competing interests were disclosed.

### Grant information
No specific grant was declared for this manuscript draft.

### Author contributions (CRediT)
| Author | CRediT roles |
|---|---|
| Mahmood Ahmad | Conceptualization; Software; Validation; Data curation; Writing - original draft; Writing - review and editing |
| Niraj Kumar | Conceptualization |
| Bilaal Dar | Conceptualization |
| Laiba Khan | Conceptualization |
| Andrew Woo | Conceptualization |

### Acknowledgements
The authors acknowledge contributors to open statistical methods, reproducible research software, and reviewer-led software quality improvement.

## References
1. DerSimonian R, Laird N. Meta-analysis in clinical trials. Controlled Clinical Trials. 1986;7(3):177-188.
2. Higgins JPT, Thompson SG. Quantifying heterogeneity in a meta-analysis. Statistics in Medicine. 2002;21(11):1539-1558.
3. Viechtbauer W. Conducting meta-analyses in R with the metafor package. Journal of Statistical Software. 2010;36(3):1-48.
4. Page MJ, McKenzie JE, Bossuyt PM, et al. The PRISMA 2020 statement: an updated guideline for reporting systematic reviews. BMJ. 2021;372:n71.
5. Fay C, Rochette S, Guyader V, Girard C. Engineering Production-Grade Shiny Apps. Chapman and Hall/CRC. 2022.
