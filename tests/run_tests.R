# Test runner for HTA Transportability Engine.
# Run from the repo root: Rscript tests/run_tests.R
# (Auto-detects repo root via the script's own location when sourced directly.)

resolve_repo_root <- function() {
  # 1) Rscript: use the --file argument
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- sub("^--file=", "", args[grep("^--file=", args)])
  if (length(file_arg) > 0 && nzchar(file_arg[1])) {
    return(normalizePath(dirname(dirname(file_arg[1])), winslash = "/"))
  }
  # 2) source()'d interactively
  this_frame <- sys.frame(1)
  if (!is.null(this_frame$ofile)) {
    return(normalizePath(dirname(dirname(this_frame$ofile)), winslash = "/"))
  }
  # 3) Fallback: current working directory
  normalizePath(getwd(), winslash = "/")
}

repo_root <- resolve_repo_root()
setwd(repo_root)
cat("Running tests from:", repo_root, "\n")

tryCatch(
  testthat::test_file("tests/test_transportability.R"),
  error = function(e) {
    cat("ERROR:", conditionMessage(e), "\n")
    quit(status = 1)
  }
)
