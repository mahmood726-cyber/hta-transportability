# config_paths.R - Portable path configuration for HTA Transportability Engine

# Source this file at the top of any pipeline script.

`%||%` <- function(a, b) {
  if (is.null(a) || length(a) == 0 || is.na(a) || identical(a, "")) b else a
}

candidate_path <- function(...) {
  normalizePath(file.path(...), winslash = "/", mustWork = FALSE)
}

# Pairwise70 root: use environment variable if set, else detect common locations.
PAIRWISE70_ROOT <- Sys.getenv("PAIRWISE70_ROOT", unset = "")

if (PAIRWISE70_ROOT == "") {
  home <- normalizePath("~", winslash = "/", mustWork = FALSE)
  onedrive <- Sys.getenv("OneDrive", unset = "")
  userprofile <- Sys.getenv("USERPROFILE", unset = "")

  candidates <- unique(c(
    candidate_path(dirname(getwd()), "Pairwise70"),
    candidate_path(getwd(), "Pairwise70"),
    candidate_path(home, "Pairwise70"),
    if (onedrive != "") candidate_path(onedrive, "Documents", "Pairwise70"),
    if (userprofile != "") candidate_path(userprofile, "Documents", "Pairwise70"),
    candidate_path(home, "OneDrive - NHS", "Documents", "Pairwise70")
  ))

  found <- candidates[dir.exists(candidates)]
  if (length(found) > 0) {
    PAIRWISE70_ROOT <- found[1]
  } else {
    stop("Pairwise70 data directory not found. Set PAIRWISE70_ROOT environment variable.")
  }
}

PAIRWISE70_ROOT <- normalizePath(PAIRWISE70_ROOT, winslash = "/", mustWork = TRUE)

# Project root.
script_file <- tryCatch(sys.frame(1)$ofile, error = function(e) NULL) %||% "."
PROJECT_ROOT <- normalizePath(dirname(script_file), winslash = "/", mustWork = FALSE)

cat(sprintf("Pairwise70 root: %s\n", PAIRWISE70_ROOT))
cat(sprintf("Project root: %s\n", PROJECT_ROOT))
