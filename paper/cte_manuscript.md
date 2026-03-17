# RESEARCH ARTICLE

## The Clinical Transportability Engine: Quantifying the Generalizability Gap between RCT Evidence and Real-World Populations for Health Technology Assessment

**Authors:** Mahmood Ul Hassan
**Affiliation:** Independent Researcher
**Correspondence:** Mahmood Ul Hassan (Independent Researcher)
**ORCID:** [To be added]

---

### Abstract

**Background:** Health Technology Assessment (HTA) relies heavily on Randomized Controlled Trial (RCT) evidence from meta-analyses, yet the generalizability of these findings to contemporary real-world populations remains poorly quantified. Temporal drift, demographic shifts, and enrollment scale changes between historical trial populations and current patient cohorts may attenuate treatment effects during "transport" from the trial setting to clinical practice.

**Methods:** We developed the Clinical Transportability Engine (CTE), an automated pipeline that links 445 Cochrane Pairwise70 meta-analysis datasets to condition-matched ClinicalTrials.gov records (484 condition-level queries). For each meta-analysis, we computed population-level covariates (temporal shift, enrollment shift, sex distribution) by querying condition-matched ongoing and future trials. A fixed-effect meta-regression model, fit on a random subsample of 1,000 observations, estimated the predicted effect magnitude in the target population, yielding a CTE Penalty Index (0--1 scale, where 1 = full effect retention).

**Results:** Across 11,974 analysis-level comparisons from 445 Cochrane reviews, 65.7% of findings were classified as HIGH transportability (CTE penalty $\geq$ 0.90), 5.8% as MEDIUM (0.70--0.90), and 28.5% as LOW ($<$ 0.70, indicating high efficacy leakage). The mean CTE penalty was 0.77 (median 1.00), with a mean efficacy leakage of 22.5%. Domain-stratified cross-validation across 18 clinical domains confirmed that cardiovascular and psychiatric interventions exhibited the highest temporal drift. Of the HIGH-transportability analyses, 25.0% (n=1,965) had near-zero pooled effects where transportability is trivially preserved.

**Conclusion:** The CTE provides a systematic, reproducible framework for quantifying the "generalizability gap" in HTA. We recommend that HTA agencies mandate the reporting of a Transportability Penalty alongside standard meta-analytic outputs, with conditional reimbursement models for technologies showing CTE penalty below 0.70.

---

### 1. Introduction

The translation of randomized controlled trial (RCT) evidence into real-world clinical practice is a fundamental challenge in health technology assessment [1]. Meta-analyses synthesize evidence across multiple trials, but the populations studied in historical RCTs may differ substantially from the patients who will ultimately receive the intervention. This "generalizability gap" encompasses three dimensions of population drift:

1. **Temporal drift**: Standard-of-care changes over time; trials conducted decades ago may not reflect current treatment landscapes.
2. **Demographic drift**: Trial eligibility criteria often exclude elderly patients, women, or specific ethnic groups, creating representation gaps [6].
3. **Scale drift**: Phase III trials operate under controlled conditions with small, selected populations; real-world deployment involves heterogeneous, larger populations.

Current HTA frameworks acknowledge external validity as a concern but lack quantitative tools for estimating the magnitude of efficacy attenuation during "transport" from trial settings to target populations [2]. The GRADE framework downgrades for indirectness, but this assessment is qualitative and subjective [3]. Recent work on transportability and generalizability has established formal causal frameworks [7,8], but automated, large-scale applications to HTA datasets remain rare.

We introduce the Clinical Transportability Engine (CTE), an automated pipeline that quantifies the expected efficacy leakage for each meta-analysis by linking historical trial populations to contemporaneous ClinicalTrials.gov registry data [5]. The CTE produces a penalty index that can be directly integrated into HTA decision models.

---

### 2. Materials and Methods

#### 2.1 Data Sources

**Source evidence:** The Pairwise70 dataset [4] contains systematically extracted pairwise meta-analysis data from 501 Cochrane systematic reviews. Of these, 445 reviews (11,974 analysis-level comparisons) had complete effect size and covariate data for the transportability analysis.

**Target population data:** ClinicalTrials.gov (CT.gov) was queried via the public API (v2) [5] to obtain contemporary and planned trial characteristics. For each of 484 Cochrane review conditions, we retrieved up to 300 matching trials per condition query, including enrollment numbers, start dates, completion dates, and sex distribution. The API's per-query limit of 300 results means that conditions with more registered trials may be incompletely captured.

#### 2.2 Pipeline Architecture

The CTE pipeline consists of 13 sequential scripts plus a penalty model:

1. **Audit** (Script 01): Validate Pairwise70 data completeness and column availability across 501 reviews.
2. **Scaffold** (Script 03): Extract effect sizes ($y_i$) and standard errors ($SE_i$) from available columns (GIV.Mean/GIV.SE preferred, with fallback to CI-derived SE using $SE = (CI_{upper} - CI_{lower}) / (2 \times \Phi^{-1}(0.975))$).
3. **CT.gov Query & Fetch** (Scripts 05--07): Build condition-specific API queries, fetch trial records, and aggregate population covariates at the condition level.
4. **Merge** (Script 08): Join Pairwise70 effect-level data with CT.gov target covariates, computing:
   - $\Delta_{year}$: temporal shift (mean study year minus mean CT.gov trial start year)
   - $\Delta_{enrollment}$: scale shift (mean study enrollment minus mean CT.gov enrollment)
   - $\%_{female}$: proportion of female participants in matched CT.gov trials
5. **CTE Model** (`cte_penalty_model.R`): Fit a meta-regression predicting effect magnitude from population covariates, then compute the CTE penalty for all 11,974 observations.
6. **Domain Classification & Cross-Validation** (Scripts 09--14): Assign reviews to 18 therapeutic domains and perform leave-one-domain-out cross-validation.

#### 2.3 The CTE Penalty Model

The meta-regression model was fit using fixed-effect meta-regression (`rma()` from the metafor R package [9]) on a random subsample of 1,000 observations (seed = 42) to ensure computational tractability:

$$|y_i| = \beta_0 + \beta_1 \Delta_{year} + \beta_2 \Delta_{enrollment} + \beta_3 \%_{female} + \epsilon_i$$

where $|y_i|$ is the absolute pooled effect size and $SE_i^2$ from the original meta-analysis was used as the sampling variance. We note that using $SE^2$ of $y_i$ as the variance for $|y_i|$ is an approximation; future work should employ bootstrap or delta-method variance estimation.

Predictions were then generated for all 11,974 observations using the fitted coefficients. The CTE penalty was computed as:

$$CTE_{penalty} = \min\left(1, \frac{\hat{y}_{predicted}}{|y_i|}\right)$$

where $\hat{y}_{predicted}$ is the model-predicted effect magnitude (signed; not absolute-valued). This means that when the model predicts effects in the opposite direction to the observed pooled effect, the penalty can become negative, indicating a directional reversal. In practice, 4 analyses produced negative penalties (capped at the minimum observed value for classification). Analyses with $y_i = 0$ were assigned a penalty of 1.0 (no effect to transport).

**Efficacy leakage** is defined as $(1 - CTE_{penalty}) \times 100\%$.

#### 2.4 Transport Classification

Analyses are classified into three tiers:
- **HIGH (Robust):** $CTE_{penalty} \geq 0.90$ --- effect expected to persist in real-world populations.
- **MEDIUM (Stable):** $0.70 \leq CTE_{penalty} < 0.90$ --- moderate attenuation expected.
- **LOW (High Leakage):** $CTE_{penalty} < 0.70$ --- substantial efficacy loss anticipated.

#### 2.5 Domain-Stratified Cross-Validation

To assess generalizability across clinical areas, we performed leave-one-domain-out cross-validation across 18 therapeutic domains (cardiovascular, cerebrovascular, dentistry, dermatology, endocrine/metabolic, gastrointestinal, infectious disease, maternal/neonatal, mental health, musculoskeletal, neurology, oncology, ophthalmology, pain, renal, respiratory, urology, and other). The cross-validation models used multilevel random-effects meta-regression (`rma.mv()`) with domain-specific covariates. We note that this model specification differs from the penalty model (Section 2.3), representing a conservative assessment of cross-domain prediction accuracy.

---

### 3. Results

#### 3.1 Overview

The pipeline processed 445 unique Cochrane review datasets from 484 condition-level CT.gov queries, yielding 11,974 analysis-level comparisons with matched covariates. A further 381 analyses were excluded from domain cross-validation due to incomplete domain assignment, leaving 11,593 observations for domain-level analysis.

#### 3.2 Transport Classification Distribution

| Class | n | % | Mean CTE Penalty |
|:------|--:|--:|:-----------------|
| HIGH (Robust) | 7,869 | 65.7% | 0.998 |
| MEDIUM (Stable) | 698 | 5.8% | 0.795 |
| LOW (High Leakage) | 3,407 | 28.5% | 0.253 |

The overall mean CTE penalty was 0.77 (median 1.00), indicating that while the majority of findings retain their effect, approximately 28.5% exhibit meaningful efficacy leakage.

**Note on zero-effect analyses:** Of the 7,869 HIGH-transportability analyses, 1,965 (25.0%) had pooled effects of exactly zero ($y_i = 0$), for which transportability is trivially preserved (penalty = 1.0). Excluding these, 5,904 analyses (49.3% of total) had genuinely retained effects classified as HIGH.

#### 3.3 Efficacy Leakage

The mean efficacy leakage across all analyses was 22.5% (median 0%), with a heavily right-skewed distribution. This indicates that a minority of analyses account for most of the transportability concern, while the majority transport well.

#### 3.4 Domain Cross-Validation

Domain-stratified cross-validation across 11,593 observations from 18 therapeutic domains confirmed heterogeneity in transportability across clinical areas. Domains with older trial bases and rapidly evolving standards of care (e.g., cardiovascular, psychiatry) exhibited higher leakage, while domains with stable interventions (e.g., dentistry, ophthalmology) showed stronger transportability.

---

### 4. Discussion

#### 4.1 The Generalizability Gap Is Quantifiable

Our results demonstrate that the gap between RCT evidence and real-world applicability can be systematically measured [2]. The finding that 28.5% of analyses fall into the LOW transportability category suggests that nearly three in ten HTA evidence syntheses may overestimate real-world effectiveness.

#### 4.2 Policy Implications

We propose that HTA agencies adopt the CTE Penalty Index as a standard reporting requirement:
- If $CTE_{penalty} < 0.70$, the HTA should consider a **Conditional Reimbursement** model subject to Real-World Evidence (RWE) confirmation.
- If $CTE_{penalty} \geq 0.90$, standard approval pathways apply.
- Technologies in the MEDIUM range (0.70--0.90) should be subject to enhanced post-market monitoring.

These thresholds are exploratory and require validation against real-world outcomes data before adoption as formal decision criteria.

#### 4.3 Integration with Other HTA Engines

The CTE is designed to operate as one pillar of a broader HTA intelligence framework. When combined with evidence integrity assessment (publication bias, information sufficiency) and economic value modeling, the CTE penalty can be incorporated into a Unified Decision Score that accounts for all dimensions of evidence quality.

#### 4.4 Limitations

1. **Model subsampling:** The CTE penalty model was fit on a random subsample of 1,000/11,974 observations (8.3%). Different random seeds would yield different coefficients. Future implementations should fit on all available data or use cross-validated model selection.
2. **Variance approximation:** Using the standard error of $y_i$ as the variance for $|y_i|$ introduces systematic bias in meta-regression weights. Delta-method or bootstrap variance estimation would be more appropriate.
3. **Cross-validation model mismatch:** The domain cross-validation used a different model specification (multilevel random-effects with different covariates) than the penalty model. Results from the CV should be interpreted as assessing the general feasibility of covariate-based transportability prediction, not as validation of the specific penalty model.
4. **CT.gov representativeness:** Not all clinical activity is registered on CT.gov; the target population proxy may be incomplete. Per-query API limits (300 trials) may truncate results for common conditions [5].
5. **Covariate scope:** Current covariates (temporal shift, enrollment shift, sex distribution) are a subset of possible population differences. Comorbidity profiles, geographic distribution, and concomitant medications are not captured.
6. **Zero-effect inflation:** 25% of HIGH-transportability findings have zero pooled effects, making transportability trivially preserved. Excluding these, the genuine HIGH rate drops from 65.7% to 49.3%.
7. **Ecological fallacy:** Population-level covariate shifts do not guarantee individual-level effect modification [1].
8. **Mixed effect types:** The analysis combines different effect measures (log-OR, SMD, MD) into a single meta-regression. While the penalty is scale-free (ratio of predicted to observed), the regression model's coefficients are influenced by this heterogeneity.

---

### 5. Conclusion

The Clinical Transportability Engine provides an automated, scalable framework for quantifying the generalizability gap in HTA. By linking 445 Cochrane reviews to condition-matched CT.gov trial data and producing a standardized penalty index, the CTE enables evidence-informed decisions about which technologies require additional real-world validation before full reimbursement approval.

---

### Data Availability Statement

All analysis scripts and the CTE pipeline are available in the project repository. The Pairwise70 source data is derived from publicly available Cochrane systematic reviews. ClinicalTrials.gov data was accessed via the public API (v2).

### Author Contributions

**Conceptualization:** Mahmood Ul Hassan. **Methodology:** Mahmood Ul Hassan. **Software:** Mahmood Ul Hassan. **Validation:** Mahmood Ul Hassan. **Formal Analysis:** Mahmood Ul Hassan. **Writing -- Original Draft:** Mahmood Ul Hassan. **Writing -- Review & Editing:** Mahmood Ul Hassan.

### Funding

The author received no specific funding for this work.

### Competing Interests

The author declares no competing interests.

### Ethics Statement

This study used publicly available aggregate data from Cochrane systematic reviews and ClinicalTrials.gov registry records. No human participants were involved and no ethics approval was required.

### Keywords

Health technology assessment, transportability, generalizability, meta-analysis, ClinicalTrials.gov, real-world evidence, efficacy leakage

### References

1. Stuart EA, Cole SR, Bradshaw CP, Leaf PJ. The use of propensity scores to assess the generalizability of results from randomized trials. J R Stat Soc Ser A. 2011;174(2):369-386.
2. Degtiar I, Rose S. A review of generalizability and transportability. Annu Rev Stat Appl. 2023;10:501-524.
3. Guyatt GH, Oxman AD, Vist GE, et al. GRADE: an emerging consensus on rating quality of evidence and strength of recommendations. BMJ. 2008;336(7650):924-926.
4. Higgins JPT, Thomas J, Chandler J, et al. Cochrane Handbook for Systematic Reviews of Interventions. Version 6.4. Cochrane, 2023.
5. Zarin DA, Tse T, Williams RJ, Carr S. Trial reporting in ClinicalTrials.gov --- the final rule. N Engl J Med. 2016;375(20):1998-2004.
6. Westreich D, Edwards JK, Lesko CR, Stuart EA, Cole SR. Transportability of trial results using inverse odds of sampling weights. Am J Epidemiol. 2017;186(8):1010-1014.
7. Bareinboim E, Pearl J. A general algorithm for deciding transportability of experimental results. J Causal Inference. 2013;1(1):107-134.
8. Dahabreh IJ, Robertson SE, Steingrimsson JA, Stuart EA, Hernan MA. Extending inferences from a randomized trial to a new target population. Stat Med. 2020;39(14):1999-2014.
9. Viechtbauer W. Conducting meta-analyses in R with the metafor package. J Stat Softw. 2010;36(3):1-48.
10. Cole SR, Stuart EA. Generalizing evidence from randomized clinical trials to target populations: the ACTG 320 trial. Am J Epidemiol. 2010;172(1):107-115.
