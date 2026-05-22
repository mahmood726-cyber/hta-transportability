# HTA Transportability Engine — convenience targets.
# Requires R (>= 4.3) with metafor, data.table, jsonlite, readr, dplyr, testthat.
# Set PAIRWISE70_ROOT before running pipeline targets.

R ?= Rscript

.PHONY: help test audit scaffold queries fetch aggregate merge cv domain-cv domain-report cte pipeline clean-outputs

help:
	@echo "Common targets:"
	@echo "  make test          - run testthat suite"
	@echo "  make audit         - 01_audit_pairwise70.R"
	@echo "  make scaffold      - 03_transportability_scaffold.R"
	@echo "  make queries       - 05_build_ctgov_queries.R"
	@echo "  make fetch         - 06_ctgov_fetch.R (honors CTGOV_* env vars)"
	@echo "  make aggregate     - 07_ctgov_aggregate.R"
	@echo "  make merge         - 08_transportability_merge.R"
	@echo "  make cv            - 09_transportability_target_cv.R"
	@echo "  make domain-cv     - 10_transportability_domain_cv.R"
	@echo "  make domain-report - 11_transportability_domain_report.R"
	@echo "  make cte           - cte_penalty_model.R (writes output/transportability_results.csv)"
	@echo "  make pipeline      - run audit -> scaffold -> queries -> aggregate -> merge -> cv -> cte"
	@echo "                       (skips fetch; run it explicitly when you want fresh CT.gov data)"
	@echo "  make clean-outputs - remove output/ (regenerable)"

test:
	$(R) tests/run_tests.R

audit:
	$(R) 01_audit_pairwise70.R

scaffold:
	$(R) 03_transportability_scaffold.R

queries:
	$(R) 05_build_ctgov_queries.R

fetch:
	$(R) 06_ctgov_fetch.R

aggregate:
	$(R) 07_ctgov_aggregate.R

merge:
	$(R) 08_transportability_merge.R

cv:
	$(R) 09_transportability_target_cv.R

domain-cv:
	$(R) 10_transportability_domain_cv.R

domain-report:
	$(R) 11_transportability_domain_report.R

cte:
	$(R) cte_penalty_model.R

pipeline: audit scaffold queries aggregate merge cv cte

clean-outputs:
	rm -rf output/
