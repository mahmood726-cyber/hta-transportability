# Research Protocol: The Clinical Transportability Engine (CTE)
**Project:** Quantifying the Generalizability Gap between RCTs and Real-World Targets
**Data Source:** Pairwise70 + ClinicalTrials.gov (12,000+ Integrated Analyses)
**Goal:** Automate the "Transportability Penalty" calculation for HTA.

---

## 1. The Challenge: The Generalizability Gap
HTA agencies often struggle to apply meta-analysis results from idealized Randomized Controlled Trials (RCTs) to real-world populations. Common issues include:
-   **Temporal Drift:** RCTs were conducted 20 years ago; standard of care has changed.
-   **Demographic Drift:** RCTs excluded women, elderly, or specific ethnicities.
-   **Scale Drift:** Phase III trials are small/controlled; real-world use is massive/messy.

## 2. The Solution: The CTE Model
We propose a **Predictive Transportability Framework**:
1.  **Covariate Mapping:** We link Cochrane reviews to contemporaneous and future trials in ClinicalTrials.gov to define the "Target Population" covariates (Time, Sex, Sample Size).
2.  **Meta-Regression of Drift:** We model how the effect size ($yi$) varies across these population shifts.
3.  **Transported Effect Prediction:** For every meta-analysis, we predict the expected effect size in the "Future/Target" population.
4.  **The CTE Penalty Index:** A percentage reduction in efficacy (e.g., "The effect is expected to leak 15% during transport to the 2026 population").

## 3. High-Tier Integration
The CTE does not work in isolation. It integrates the previous two projects:
-   **Integrity check:** Is the source evidence biased or premature?
-   **Heterogeneity check:** Does population drift increase between-study variance?

## 4. Expected Deliverables
-   **`transported_effects_atlas.csv`**: The predicted real-world efficacy for all Pairwise70 outcomes.
-   **`cte_penalty_model.R`**: The core statistical engine.
-   **`HTA_Transportability_Dashboard.html`**: A visualizer for population drift.

---
**Date:** February 15, 2026
**Lead:** Mahmood Ul Hassan
