# Data Sets

This folder contains five simulated data sets used in the examples for [*Factored Structural Equation Modeling in Blimp*](https://osf.io/qrza9). Each data set is designed to illustrate different modeling techniques and data structures in Blimp and rblimp.

## Overview

All data sets are in CSV format and can be loaded directly from the GitHub repository or locally. The example scripts automatically load these files from the online repository.

## Data Set Descriptions

### data1.csv (231 KB)
**Used in:** Models 1-12, 14-15, 20

General-purpose data set for demonstrating latent variable models with various outcome types and factor indicators.

**Variables:**
- **Outcome variables:**
  - `y` - Normal continuous outcome
  - `y_bin` - Binary outcome
  - `y_nom` - Multicategorical (nominal) outcome
  - `y_cnt` - Count outcome
  - `y_2pt` - Two-part semi-continuous outcome

- **Mediators and predictors:**
  - `m1`, `m2` - Normal continuous predictors
  - `m_nom` - Multicategorical (nominal) predictor
  - `m_bin` - Binary/ordinal predictor

- **Factor indicators:**
  - `x1`, `x2`, `x3`, `x4` - Normal continuous indicators
  - `xs1`, `xs2`, `xs3`, `xs4` - Skewed continuous indicators (for transformation examples)
  - `xc1`, `xc2`, `xc3`, `xc4` - Ordinal categorical indicators

**Example models:**
- Basic latent variable models (Models 1-3)
- Ordinal indicators and various outcome types (Models 4-8)
- Advanced latent variable models with transformations and interactions (Models 9-12)
- Sum score models (Models 14-15)
- Two-part outcome models (Model 20)

### data2.csv (86 KB)
**Used in:** Model 13

Longitudinal data for linear growth modeling with autoregressive residuals.

**Variables:**
- `x1`, `x2`, `x3`, `x4` - Repeated measurements at four time points
- `m_bin` - Binary exogenous predictor
- `y` - Normal distal outcome

**Example models:**
- Linear growth model with AR(1) residuals (Model 13)

### data3.csv (403 KB)
**Used in:** Models 16-19

Multilevel (hierarchical) data with observations nested within clusters.

**Variables:**
- `l2id` - Level-2 cluster identification variable
- `y` - Normal continuous outcome
- `x` - Normal continuous predictor
- `m_bin` - Binary exogenous predictor

**Example models:**
- Two-level random effects models with explicit and implicit specifications (Models 16-17)
- Heterogeneous within-cluster variation models (Models 18-19)

### data4.csv (108 KB)
**Used in:** Model 21

Panel data with three waves of bivariate measurements for cross-lagged panel modeling.

**Variables:**
- `x1`, `x2`, `x3` - First variable measured at three time points
- `y1`, `y2`, `y3` - Second variable measured at three time points

**Example models:**
- Random intercept cross-lagged panel model (RI-CLPM) (Model 21)

### data5.csv (120 KB)
**Used in:** Model 22

Intensive longitudinal data for dynamic structural equation modeling.

**Variables:**
- `l2id` - Level-2 cluster (person) identification variable
- `time` - Time identification variable for creating lagged predictors
- `x` - First continuous variable
- `y` - Second continuous variable

**Example models:**
- Dynamic structural equation model (DSEM) with lagged effects (Model 22)

## Usage

### In R (using rblimp)
```r
# Load data directly from GitHub
baseurl <- 'https://raw.githubusercontent.com/blimp-stats/fsem/refs/heads/main/data'
data1 <- read.csv(paste0(baseurl, '/data1.csv'))

# Or load from local file
data1 <- read.csv('data/data1.csv')
```

## References

For complete examples and model specifications using these data sets, see:
- [Example R script](../example/FSEM-Example.R)
- [Benchmark comparisons](../benchmark/benchmark.R)
- [Quickstart guide](../docs/QUICKSTART.md)
