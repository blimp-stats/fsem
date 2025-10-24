# FSEM Software Benchmark

This directory contains a reproducible benchmark system for comparing the execution speed of three Bayesian structural equation modeling software packages:

- **Blimp** (via rblimp)
- **blavaan** (Bayesian lavaan)
- **Mplus** (Bayes estimator, via MplusAutomation)

**[View Benchmark Report](benchmark_report.md)**

## Quick Start

To run the complete benchmark and generate the report:

```r
source("run_benchmark.R")
```

This single command will:
1. Execute all benchmark analyses (10 runs per software per model)
2. Save results to `benchmark_results.rds`
3. Generate reports: `benchmark_report.html` and `benchmark_report.md`

## Models Benchmarked

The benchmark compares **11 structural equation models** that all three software packages can estimate:

| Model | Description | MCMC Settings |
|-------|-------------|---------------|
| Model 1 | Normal outcome, latent predictor | burn=10000, iter=10000 |
| Model 2 | Normal outcome, latent mediator | burn=10000, iter=10000 |
| Model 3 | Correlated latent/manifest predictors | burn=10000, iter=10000 |
| Model 5 | Ordinal indicators, latent response variable | burn=20000, iter=20000 |
| Model 6 | Multicategorical predictor, ordinal indicators | burn=20000, iter=20000 |
| Model 13 | Growth model with AR(1) residuals | burn=10000, iter=10000 |
| Model 14 | Sum score model | burn=20000, iter=20000 |
| Model 17 | Two-level random slope model | burn=10000, iter=10000 |
| Model 20 | Two-part outcome model | burn=20000, iter=20000 |
| Model 21 | Random intercept cross-lagged panel (RI-CLPM) | burn=10000, iter=10000 |
| Model 22 | Dynamic SEM | burn=10000, iter=10000 |

**Note:** Models 4, 7a, 7b, 8, 9, 10, 11, 12, 15, 16, 18, and 19 are excluded because they can only be estimated by Blimp.

## Files

- **`run_benchmark.R`**: Master script - runs everything with one call
- **`benchmark.R`**: Main benchmark script using `microbenchmark` package
- **`benchmark_report.Rmd`**: RMarkdown template for automated report generation (produces both HTML and Markdown)
- **`benchmark_results.rds`**: Output file containing timing data (generated after run)
- **`benchmark_report.html`**: HTML report with interactive visualizations (generated after run)
- **`benchmark_report.md`**: Markdown report for GitHub viewing (generated after run)

## Requirements

Required R packages:
- `microbenchmark`
- `rblimp`
- `MplusAutomation`
- `blavaan`
- `rstan`
- `ggplot2`
- `dplyr`
- `tidyr`
- `knitr`
- `kableExtra`
- `rmarkdown`

Install missing packages:
```r
install.packages(c("microbenchmark", "rblimp", "MplusAutomation", "blavaan",
                   "rstan", "ggplot2", "dplyr", "tidyr", "knitr",
                   "kableExtra", "rmarkdown"))
```

## Data Requirements

The benchmark requires the following datasets from the `../Analysis Examples/` directory:
- `data1.RData`, `data2.RData`, `data3.RData`, `data4.RData`, `data5.RData`
- `data1comp.RData`, `data2comp.RData`, `data3comp.RData`

Mplus scripts must be available in `../Analysis Examples/Mplus Scripts/`:
- `model1_bayes.inp`, `model2_bayes.inp`, `model3_bayes.inp`, etc.

## Methodology

- **Timing tool**: `microbenchmark` package
- **Replications**: 10 runs per software per model
- **MCMC settings**: Original settings preserved from main analysis (not reduced)
- **Error handling**: Each model wrapped in `tryCatch()` for robustness
- **Random seeds**: Fixed (seed=90291) for reproducibility

## Report Contents

The generated reports include:
- Executive summary with model descriptions
- Summary statistics (min, Q1, mean, median, Q3, max) for each model × software
- Speed ratio comparisons (relative to fastest software per model)
- Boxplots showing timing distributions
- Bar charts comparing median execution times
- Overall performance comparison across all models
- Model-specific detailed results
- Session and system information for reproducibility

## Expected Runtime

**Warning:** The complete benchmark will take several hours to complete, as each model must be estimated 10 times per software package with full MCMC iterations.

Approximate total runtime will vary based on:
- Computer hardware (CPU, RAM)
- Number of available cores
- System load

## Manual Execution

If you prefer to run steps separately:

1. Run benchmark only:
```r
source("benchmark.R")
```

2. Generate reports from existing results:
```r
# Generate both HTML and Markdown reports
rmarkdown::render("benchmark_report.Rmd", output_format = "all")

# Or generate only HTML
rmarkdown::render("benchmark_report.Rmd", output_format = "html_document")

# Or generate only Markdown
rmarkdown::render("benchmark_report.Rmd", output_format = "md_document")
```

## Notes

- Models 13, 17, 21, and 22 can only be estimated by Blimp and Mplus (blavaan cannot estimate these models)
- Models 6 and 20 require complete data for Mplus and blavaan (nominal predictors)
- Mplus will create `.out` files in the Mplus Scripts directory during execution
- The benchmark uses `system.time()` internally via `microbenchmark` for accurate timing
