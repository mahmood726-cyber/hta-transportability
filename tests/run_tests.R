setwd("C:/Models/HTA_Transportability_Engine")
tryCatch(
  testthat::test_file("tests/test_transportability.R"),
  error = function(e) cat("ERROR:", conditionMessage(e), "\n")
)
