# Test runner for the HTA Transportability Engine.
# Resolves the repo root portably (no hardcoded local path) so the suite
# runs from any checkout location, e.g. Rscript tests/run_tests.R

get_script_path <- function() {
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("^--file=", args, value = TRUE)
  if (length(file_arg) > 0) {
    return(normalizePath(sub("^--file=", "", file_arg[1]), mustWork = FALSE))
  }
  # Fallback when sourced interactively
  if (!is.null(sys.frame(1)$ofile)) {
    return(normalizePath(sys.frame(1)$ofile, mustWork = FALSE))
  }
  NA_character_
}

script_path <- get_script_path()
repo_root <- if (!is.na(script_path)) dirname(dirname(script_path)) else getwd()
setwd(repo_root)

tryCatch(
  testthat::test_file("tests/test_transportability.R"),
  error = function(e) cat("ERROR:", conditionMessage(e), "\n")
)
