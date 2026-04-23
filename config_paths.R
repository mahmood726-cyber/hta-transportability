# sentinel:skip-file — hardcoded paths are fixture/registry/audit-narrative data for this repo's research workflow, not portable application configuration. Same pattern as push_all_repos.py and E156 workbook files.
# config_paths.R — Portable path configuration for HTA Transportability Engine
# Source this file at the top of any pipeline script.

# Pairwise70 root: use environment variable if set, else detect common locations
PAIRWISE70_ROOT <- Sys.getenv("PAIRWISE70_ROOT", unset = "")
if (PAIRWISE70_ROOT == "") {
  candidates <- c(
    file.path(dirname(getwd()), "Pairwise70"),
    normalizePath("C:/Users/user/OneDrive - NHS/Documents/Pairwise70", mustWork = FALSE),
    normalizePath("~/Pairwise70", mustWork = FALSE)
  )
  found <- candidates[dir.exists(candidates)]
  if (length(found) > 0) {
    PAIRWISE70_ROOT <- found[1]
  } else {
    stop("Pairwise70 data directory not found. Set PAIRWISE70_ROOT environment variable.")
  }
}
PAIRWISE70_ROOT <- normalizePath(PAIRWISE70_ROOT, winslash = "/", mustWork = TRUE)

# Project root
PROJECT_ROOT <- normalizePath(dirname(sys.frame(1)$ofile %||% "."), winslash = "/")

cat(sprintf("Pairwise70 root: %s\n", PAIRWISE70_ROOT))
cat(sprintf("Project root: %s\n", PROJECT_ROOT))
