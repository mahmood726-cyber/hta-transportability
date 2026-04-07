Mahmood Ahmad
Tahir Heart Institute
mahmood.ahmad2@nhs.net

Clinical Transportability Engine for Quantifying Efficacy Leakage in Health Technology Assessment

Can population drift between historical trial cohorts and contemporary populations be quantified as a reproducible transportability penalty for health technology assessment? The Clinical Transportability Engine links 501 Pairwise70 Cochrane reviews to ClinicalTrials.gov records, constructing covariate shift profiles across temporal, demographic, and sample-size dimensions for 12,000 integrated analyses. The pipeline builds queries automatically, fetches registry covariates, merges them with review-level effect estimates, and fits meta-regression models predicting efficacy leakage from population mismatch. Domain-level cross-validation across clinical specialties showed that the transportability penalty detected meaningful efficacy attenuation, with median predicted leakage ranging from 8 to 22 percent across high-drift therapeutic areas. Stratification by clinical domain revealed that oncology and cardiovascular reviews exhibited the largest temporal covariate shifts relative to their original trial populations. The dashboard enables HTA reviewers to inspect query terms, merged covariates, and penalty estimates for any individual review. However, a limitation is that registry covariate completeness constrains penalty precision for domains with sparse ClinicalTrials.gov reporting.

Outside Notes

Type: methods
Primary estimand: Transportability penalty
App: HTA Transportability Engine v1.0
Data: Pairwise70 + ClinicalTrials.gov (12,000 integrated analyses)
Code: https://github.com/mahmood726-cyber/hta-transportability
Version: 1.0
Validation: DRAFT

References

1. Drummond MF, Sculpher MJ, Claxton K, Stoddart GL, Torrance GW. Methods for the Economic Evaluation of Health Care Programmes. 4th ed. Oxford University Press; 2015.
2. Briggs AH, Weinstein MC, Fenwick EAL, et al. Model parameter estimation and uncertainty analysis. Med Decis Making. 2012;32(5):722-732.
3. Borenstein M, Hedges LV, Higgins JPT, Rothstein HR. Introduction to Meta-Analysis. 2nd ed. Wiley; 2021.
