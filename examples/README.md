# FSEM Examples

This folder contains comprehensive examples demonstrating Factored Structural Equation Modeling in Blimp using the `rblimp` R package.

## Contents

### [FSEM-Example.R](FSEM-Example.R)

The main R script containing 22 complete modeling examples (Models 0-22) that demonstrate the full range of Blimp's capabilities. The script includes detailed comments explaining each model specification and interpretation.

**Available in multiple formats:**
- **FSEM-Example.R** - Executable R script
- **FSEM-Example.html** - HTML document with rendered output
- **FSEM-Example.pdf** - PDF document for offline viewing

### [FSEM Real Data Analysis.pdf](FSEM%20Real%20Data%20Analysis.pdf)

Applied examples demonstrating factored structural equation modeling with real-world data sets, including complete analysis workflows and interpretation guidelines.

## Model Overview

The examples are organized into six thematic groups:

### Basic Models (Models 0-3)
Introduction to `rblimp` and basic latent variable models:
- Simple one-predictor model
- Normal outcome with latent predictor
- Mediation model with latent mediator
- Correlated predictors model

### Ordinal Indicators and Outcome Types (Models 4-8)
Handling different variable types:
- Ordinal factor indicators
- Latent response variables for binary predictors
- Multicategorical (nominal) predictors
- Binary, multicategorical, and count outcomes

### Advanced Latent Variable Models (Models 9-12)
Complex modeling techniques:
- Nonnormal factor indicators with Yeo-Johnson transformations
- Heterogeneous factor variance across groups
- Latent variable interactions
- Curvilinear effects and moderation

### Growth and Sum Score Models (Models 13-15)
Alternative approaches:
- Linear growth model with AR(1) residuals
- Sum score predictors as alternatives to latent variables
- Sum score interactions

### Multilevel Models (Models 16-19)
Hierarchical data structures:
- Two-level random effects models (explicit and implicit specifications)
- Cross-level interactions
- Group mean centering
- Heterogeneous within-cluster variation (HEV)
- Variance predictors at multiple levels

### Advanced Longitudinal Models (Models 20-22)
Specialized longitudinal techniques:
- Two-part models for semi-continuous outcomes
- Random intercept cross-lagged panel model (RI-CLPM)
- Dynamic structural equation model (DSEM) for intensive longitudinal data

## Getting Started

### Prerequisites

1. **Install Blimp** - Download from [https://www.appliedmissingdata.com/blimp](https://www.appliedmissingdata.com/blimp)
   - See [installation instructions](../README.md#blimp-installation-guide) for your platform

2. **Install rblimp** - Run in R:
   ```r
   install.packages("remotes")
   remotes::install_github('blimp-stats/rblimp')
   ```

### Running the Examples

```r
# Load the rblimp package
library(rblimp)

# Data sets are loaded automatically from GitHub in the script
# Or load locally if you have the repository cloned
source('examples/FSEM-Example.R')

# Run individual models by executing the relevant sections
# For example, to run Model 1a:
model1a <- rblimp(
    data = data1,
    latent = 'eta',
    model = '
        eta -> x1:x4;
        y ~ eta;',
    seed = 90291,
    burn = 10000,
    iter = 10000
)

# View results
output(model1a)       # Raw Blimp output
summary(model1a)      # R summary
model_table(model1a)  # HTML table
posterior_plot(model1a) # Posterior plots
```

## Key Features Demonstrated

- **Model Specification**: `~` for regression, `->` for factor loadings, `~~` for correlations
- **Variable Types**: Normal, ordinal, nominal, count, and two-part outcomes
- **Latent Variables**: Factor analysis, structural equation models, random effects
- **Interactions**: Latent-by-observed, latent-by-latent, cross-level
- **Transformations**: Yeo-Johnson for nonnormal indicators
- **Missing Data**: Automatic handling via MCMC estimation
- **Model Comparisons**: Simple slopes, conditional effects, Johnson-Neyman plots

## Data Sets

All examples use simulated data from the [`data/`](../data/) folder:
- **data1.csv** - General-purpose data for Models 1-12, 14-15, 20
- **data2.csv** - Longitudinal data for Model 13
- **data3.csv** - Multilevel data for Models 16-19
- **data4.csv** - Panel data for Model 21
- **data5.csv** - Intensive longitudinal data for Model 22

See the [data folder README](../data/README.md) for detailed variable descriptions.

## Citation

If you use these examples in your research, please cite:

> Keller, B. T., & Enders, C. K. (2025). *Factored Structural Equation Modeling in Blimp*. Retrieved from https://osf.io/qrza9
