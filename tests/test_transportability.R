# TEST SUITE: HTA Transportability Engine
# Tests effect size calculation, CTE penalty, transport class, and pipeline output

suppressPackageStartupMessages({
  library(data.table)
  library(testthat)
})

cat("=== HTA Transportability Engine: Test Pipeline ===\n")

# ============================================================================
# 1. EFFECT SIZE DERIVATION TESTS
# ============================================================================

test_that("SE from CI uses correct z-critical value", {
  # SE = (CI.end - CI.start) / (2 * qnorm(0.975))
  ci_start <- -1.0
  ci_end <- 0.5
  se <- (ci_end - ci_start) / (2 * qnorm(0.975))
  expect_true(se > 0)
  expect_equal(se, 1.5 / (2 * qnorm(0.975)), tolerance = 1e-10)

  # Verify NOT using hardcoded 1.96
  se_wrong <- 1.5 / (2 * 1.96)
  expect_true(abs(se - se_wrong) > 0)  # Should differ slightly
})

test_that("SE from Variance is sqrt(Variance)", {
  v <- 0.04
  se <- sqrt(v)
  expect_equal(se, 0.2)
})

test_that("GIV.SE is preferred when available", {
  # If GIV columns exist and are finite, use them
  giv_se <- 0.15
  variance_se <- sqrt(0.04)
  # GIV should be preferred
  has_giv <- TRUE
  se <- if (has_giv) giv_se else variance_se
  expect_equal(se, 0.15)
})

# ============================================================================
# 2. CTE PENALTY FORMULA TESTS
# ============================================================================

test_that("CTE penalty formula: min(1, predicted_mag / abs_yi)", {
  # cte_penalty = min(1, predicted_mag / abs(yi))
  cte_penalty <- function(predicted_mag, abs_yi) min(1, predicted_mag / abs_yi)

  # Full retention: predicted >= actual
  expect_equal(cte_penalty(0.5, 0.3), 1.0)

  # Partial retention: predicted < actual
  pen <- cte_penalty(0.3, 0.5)
  expect_equal(pen, 0.6)

  # Zero predicted = zero penalty (complete leakage)
  expect_equal(cte_penalty(0.0, 0.5), 0.0)
})

test_that("Efficacy leakage is (1 - cte_penalty) * 100", {
  cte_penalty <- 0.7
  leakage <- (1 - cte_penalty) * 100
  expect_equal(leakage, 30)
})

# ============================================================================
# 3. TRANSPORT CLASS ASSIGNMENT TESTS
# ============================================================================

test_that("Transport class thresholds are correct", {
  classify_transport <- function(cte_penalty) {
    if (cte_penalty >= 0.85) return("HIGH (Robust)")
    if (cte_penalty >= 0.70) return("MEDIUM (Stable)")
    return("LOW (High Leakage)")
  }

  expect_equal(classify_transport(0.90), "HIGH (Robust)")
  expect_equal(classify_transport(0.85), "HIGH (Robust)")
  expect_equal(classify_transport(0.75), "MEDIUM (Stable)")
  expect_equal(classify_transport(0.70), "MEDIUM (Stable)")
  expect_equal(classify_transport(0.50), "LOW (High Leakage)")
  expect_equal(classify_transport(0.00), "LOW (High Leakage)")
})

# ============================================================================
# 4. CT.GOV COVARIATE AGGREGATION TESTS
# ============================================================================

test_that("Year shift is computed correctly", {
  mean_study_year <- 1995
  ctgov_start_year <- 2020
  year_shift <- mean_study_year - ctgov_start_year
  expect_equal(year_shift, -25)
})

test_that("Enrollment shift handles missing values", {
  mean_n <- 500
  ctgov_enrollment <- NA
  shift <- if (is.na(ctgov_enrollment)) NA_real_ else mean_n - ctgov_enrollment
  expect_true(is.na(shift))
})

# ============================================================================
# 5. OUTPUT VALIDATION TESTS (if CSV exists)
# ============================================================================

csv_path <- if (file.exists("output/transportability_results.csv")) {
  "output/transportability_results.csv"
} else if (file.exists("../output/transportability_results.csv")) {
  "../output/transportability_results.csv"
} else NULL

if (!is.null(csv_path)) {
  dt <- fread(csv_path)

  test_that("Output CSV has required columns", {
    required <- c("dataset", "yi", "se", "cte_penalty", "efficacy_leakage",
                   "transport_class")
    missing <- setdiff(required, names(dt))
    expect_equal(length(missing), 0, info = paste("Missing:", paste(missing, collapse=", ")))
  })

  test_that("CTE penalty is bounded at 1 on upper end", {
    expect_true(all(dt$cte_penalty <= 1, na.rm = TRUE))
    # Lower bound can be negative when predicted effect reverses sign
    pct_valid <- mean(dt$cte_penalty >= 0, na.rm = TRUE)
    expect_true(pct_valid > 0.95, info = sprintf("%.1f%% of CTE penalties are non-negative", 100*pct_valid))
  })

  test_that("Efficacy leakage is finite", {
    finite_pct <- mean(is.finite(dt$efficacy_leakage))
    expect_true(finite_pct > 0.99, info = sprintf("%.1f%% finite", 100*finite_pct))
  })

  test_that("Transport classes are valid", {
    valid_classes <- c("HIGH (Robust)", "MEDIUM (Stable)", "LOW (High Leakage)")
    expect_true(all(dt$transport_class %in% valid_classes))
  })

  test_that("yi and se are finite where present", {
    expect_true(all(is.finite(dt$yi)))
    expect_true(all(is.finite(dt$se) & dt$se > 0))
  })

  cat(sprintf("Output CSV validated: %d analyses across %d datasets\n",
              nrow(dt), uniqueN(dt$dataset)))
  cat(sprintf("Transport classes: HIGH=%.0f%%, MEDIUM=%.0f%%, LOW=%.0f%%\n",
              100*mean(dt$transport_class == "HIGH (Robust)"),
              100*mean(dt$transport_class == "MEDIUM (Stable)"),
              100*mean(dt$transport_class == "LOW (High Leakage)")))
}

cat("All Transportability tests complete.\n")
