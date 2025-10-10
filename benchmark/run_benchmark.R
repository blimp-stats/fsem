#-------------------------------------------------------------------#
# Master Benchmark Script
#
# This script runs the complete benchmark analysis and generates
# an HTML report comparing Blimp, blavaan, and Mplus (Bayes).
#
# Usage:
#   source("run_benchmark.R")
#
# Output:
#   - benchmark_results.rds: Raw benchmark timing data
#   - benchmark_report.html: Formatted HTML report with visualizations
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
#### Startup Messages ####
#-------------------------------------------------------------------#

cat("================================================================================\n")
cat("FSEM Software Benchmark\n")
cat("Comparing: Blimp, blavaan, and Mplus (Bayes)\n")
cat("================================================================================\n\n")

#-------------------------------------------------------------------#
#### Check Required Packages ####
#-------------------------------------------------------------------#

## List of required packages
required_packages <- c("microbenchmark", "rblimp", "MplusAutomation", "blavaan",
                       "ggplot2", "dplyr", "tidyr", "knitr", "kableExtra", "rmarkdown")

cat("Checking required packages...\n")

## Check which packages are missing
missing_packages <- required_packages[!sapply(required_packages, requireNamespace, quietly = TRUE)]

if (length(missing_packages) > 0) {
    cat("ERROR: Missing required packages:", paste(missing_packages, collapse = ", "), "\n")
    cat("Please install them with: install.packages(c('", paste(missing_packages, collapse = "', '"), "'))\n", sep = "")
    stop("Missing required packages")
}

cat("All required packages are installed.\n\n")

#-------------------------------------------------------------------#
#### Run Benchmark Analysis ####
#-------------------------------------------------------------------#

cat("================================================================================\n")
cat("STEP 1: Running benchmark analysis\n")
cat("================================================================================\n")
cat("This will take a considerable amount of time (potentially several hours).\n")
cat("Each model will be estimated 10 times per software package.\n\n")

## Record start time
start_time <- Sys.time()
cat("Start time:", format(start_time), "\n\n")

## Source the benchmark script
source("benchmark.R")

## Record end time
end_time <- Sys.time()
elapsed_time <- difftime(end_time, start_time, units = "mins")

cat("\n================================================================================\n")
cat("Benchmark complete!\n")
cat("End time:", format(end_time), "\n")
cat("Total elapsed time:", round(elapsed_time, 2), "minutes\n")
cat("================================================================================\n\n")

#-------------------------------------------------------------------#
#### Generate Report ####
#-------------------------------------------------------------------#

cat("================================================================================\n")
cat("STEP 2: Generating HTML report\n")
cat("================================================================================\n\n")

## Attempt to render the RMarkdown report
tryCatch({
    rmarkdown::render("benchmark_report.Rmd",
                      output_file = "benchmark_report.html",
                      output_dir = getwd(),
                      quiet = FALSE)
    cat("\nReport generated successfully: benchmark_report.html\n")
}, error = function(e) {
    cat("\nERROR generating report:", e$message, "\n")
    cat("However, benchmark results are saved in: benchmark_results.rds\n")
})

#-------------------------------------------------------------------#
#### Cleanup Generated Files ####
#-------------------------------------------------------------------#

cat("\n================================================================================\n")
cat("STEP 3: Cleaning up temporary files\n")
cat("================================================================================\n\n")

## Delete .blimp-out and .out files from assets directory
blimp_out_files <- list.files("assets", pattern = "\\.blimp-out$", full.names = TRUE)
mplus_out_files <- list.files("assets", pattern = "\\.out$", full.names = TRUE)

files_to_delete <- c(blimp_out_files, mplus_out_files)

if (length(files_to_delete) > 0) {
    cat("Deleting", length(files_to_delete), "output file(s) from assets/:\n")
    for (file in files_to_delete) {
        cat("  -", basename(file), "\n")
        file.remove(file)
    }
    cat("\nCleanup complete.\n")
} else {
    cat("No output files to delete.\n")
}

#-------------------------------------------------------------------#
#### Completion Messages ####
#-------------------------------------------------------------------#

cat("\n================================================================================\n")
cat("COMPLETE!\n")
cat("================================================================================\n")
cat("Output files:\n")
cat("  - benchmark_results.rds (raw data)\n")
cat("  - benchmark_report.html (formatted report)\n")
cat("\nTo view the report, open benchmark_report.html in a web browser.\n")
cat("================================================================================\n")
