#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(data.table)
  library(metafor)
  library(dplyr)
})
source("config_paths.R")

cat("================================================================================\n")
cat("HTA METHODOLOGY: CLINICAL TRANSPORTABILITY ENGINE (CTE) - FAST BUILD\n")
cat("================================================================================\n\n")

# Paths
merge_path <- file.path(PROJECT_ROOT, "transportability_target_merge.csv")
output_path <- file.path(PROJECT_ROOT, "output", "transportability_results.csv")
dir.create(file.path(PROJECT_ROOT, "output"), showWarnings = FALSE)

cat("Loading Data...\n")
dt <- fread(merge_path)
dt_clean <- dt[!is.na(yi) & !is.na(se) & !is.na(year_shift) & !is.na(enrollment_shift) & !is.na(sex_female_pct)]
dt_clean[, abs_yi := abs(yi)]

cat(sprintf("Fitting Global Drift Model (N=1000)...\n"))
set.seed(42)
dt_sample <- dt_clean[sample(.N, min(1000, .N))]

# Simple Meta-Regression (High Speed)
fit_drift <- rma(abs_yi ~ year_shift + enrollment_shift + sex_female_pct, 
                 vi = se^2, 
                 data = dt_sample)

print(summary(fit_drift)$coefficients)

cat("\nCalculating Real-World Efficacy Leakage...\n")
preds <- predict(fit_drift, newmods = as.matrix(dt_clean[, .(year_shift, enrollment_shift, sex_female_pct)]))
dt_clean$predicted_mag <- as.numeric(preds$pred)

# Penalty calculation: Predicted / Original
dt_clean[, cte_penalty := pmin(1, predicted_mag / abs_yi)]
dt_clean[, efficacy_leakage := (1 - cte_penalty) * 100]

dt_clean[, transport_class := case_when(
  cte_penalty >= 0.90 ~ "HIGH (Robust)",
  cte_penalty >= 0.70 ~ "MEDIUM (Stable)",
  TRUE ~ "LOW (High Leakage)"
)]

cat("\n--- TRANSPORTABILITY SUMMARY ---\n")
print(dt_clean[, .N, by = transport_class])

fwrite(dt_clean, output_path)
cat(sprintf("\nResults saved to: %s\n", output_path))
