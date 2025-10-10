#-------------------------------------------------------------------#
# FSEM Software Benchmark
#
# Comparing execution speed of:
#  - Blimp (via rblimp)
#  - blavaan (Bayesian lavaan)
#  - Mplus (Bayes estimator via MplusAutomation)
#
# Each model is estimated 10 times per software package using
# the microbenchmark package. Only models that all three software
# packages can estimate are included.
#-------------------------------------------------------------------#

#-------------------------------------------------------------------#
#### Required Packages ####
#-------------------------------------------------------------------#

## Load required packages
library(rblimp)
library(MplusAutomation)
library(lavaan)
library(blavaan)
library(rstan)
library(microbenchmark)

## Set options
options(check_blimp_update = FALSE)

#-------------------------------------------------------------------#
#### Reading Data ####
#-------------------------------------------------------------------#

## Base url for Github Repository
baseurl <- 'https://raw.githubusercontent.com/blimp-stats/fsem/refs/heads/main/data'

## Read in all data sets for benchmark
data1 <- read.csv(paste0(baseurl, '/data1.csv'))
data2 <- read.csv(paste0(baseurl, '/data2.csv'))
data3 <- read.csv(paste0(baseurl, '/data3.csv'))
data4 <- read.csv(paste0(baseurl, '/data4.csv'))
data5 <- read.csv(paste0(baseurl, '/data5.csv'))

#-------------------------------------------------------------------#
#### Benchmark Setup ####
#-------------------------------------------------------------------#

## Set number of benchmark replications
n_times <- 10 # Change this to 10 for full benchmark

## Initialize results list
benchmark_results <- list()

## Create temp directory for Mplus files
tmp <- tempdir()

## Print benchmark start information
cat("================================================================================\n")
cat("FSEM Software Benchmark\n")
cat("================================================================================\n")
cat("Each model will be run", n_times, "time(s) per software package.\n")
if (n_times < 10) {
    cat("NOTE: Running with", n_times, "replication(s) for testing. Set n_times=10 for full benchmark.\n")
}
cat("================================================================================\n\n")

#-------------------------------------------------------------------#
#### MODEL 1: Normal Outcome with Latent Predictor ####
#
# Model Specification:
#  - Normal outcome variable
#  - Latent predictor (eta)
#  - Normal factor indicators (x1:x4)
#  - MCMC Settings: burn=10000, iter=10000
#-------------------------------------------------------------------#

cat("Benchmarking Model 1...\n")
benchmark_results$model1 <- microbenchmark(
    blimp = {
        model1_blimp <- rblimp_source('assets/model1.imp', output = 'none')
    },
    mplus = {
        model1_mplus <- suppressWarnings(runModels('assets/model1.inp'))
    },
    blavaan = {
        model1_blavaan <- bsem(
            data = data1,
            model = '
                eta ~~ 1*eta
                eta =~ NA*x1 + x2 + x3 + x4
                y ~ eta',
            test = 'none',
            bcontrol = list(refresh = 0, cores = 2),
            n.chains = 2,
            burnin = 500, sample = 1000)
    },
    times = n_times,
    unit = "s"
)
cat("Model 1 complete.\n\n")

#-------------------------------------------------------------------#
#### MODEL 2: Mediation Model with Latent Mediator ####
#
# Model Specification:
#  - Normal outcome variable
#  - Normal manifest predictors (m1, m2)
#  - Latent mediator (eta)
#  - Normal factor indicators (x1:x4)
#  - Correlated indicator residuals
#  - MCMC Settings: burn=10000, iter=10000
#-------------------------------------------------------------------#

cat("Benchmarking Model 2...\n")
benchmark_results$model2 <- microbenchmark(
    blimp = {
        model2_blimp <- rblimp_source('assets/model2.imp', output = 'none')
    },
    mplus = {
        model2_mplus <- suppressWarnings(runModels('assets/model2.inp'))
    },
    blavaan = {
        model2_blavaan <- bsem(
            data = data1,
            model = '
                eta ~ m1 + m2
                eta ~~ 1*eta
                eta =~ NA*x1 + x2 + x3 + x4
                y ~ m1 + m2 + eta',
            test = 'none',
            bcontrol = list(refresh = 0, cores = 2),
            n.chains = 2,
            burnin = 500, sample = 1000)
    },
    times = n_times,
    unit = "s"
)
cat("Model 2 complete.\n\n")

#-------------------------------------------------------------------#
#### MODEL 3: Correlated Predictors Model ####
#
# Model Specification:
#  - Normal outcome variable
#  - Correlated latent and normal manifest predictors
#  - Normal factor indicators (x1:x4)
#  - Correlated indicator residuals (x3, x4)
#  - MCMC Settings: burn=10000, iter=10000
#-------------------------------------------------------------------#

cat("Benchmarking Model 3...\n")
benchmark_results$model3 <- microbenchmark(
    blimp = {
        model3_blimp <- rblimp_source('assets/model3.imp', output = 'none')
    },
    mplus = {
        model3_mplus <- suppressWarnings(runModels('assets/model3.inp'))
    },
    blavaan = {
        model3_blavaan <- bsem(
            data = data1,
            model = '
                m1 ~~ eta
                eta ~~ 1*eta
                eta =~ NA*x1 + x2 + x3 + x4
                x3 ~~ x4
                y ~ m1 + eta',
            test = 'none',
            bcontrol = list(refresh = 0, cores = 2),
            n.chains = 2,
            burnin = 500, sample = 1000)
    },
    times = n_times,
    unit = "s"
)
cat("Model 3 complete.\n\n")

#-------------------------------------------------------------------#
#### MODEL 5: Latent Response Variable Model ####
#
# Model Specification:
#  - Normal outcome variable
#  - Correlated latent and binary manifest predictors
#  - Latent response variable replaces binary predictor
#  - Ordinal factor indicators (xc1:xc4)
#  - Correlated indicator residuals (xc3, xc4)
#  - MCMC Settings: burn=20000, iter=20000
#-------------------------------------------------------------------#

cat("Benchmarking Model 5...\n")
benchmark_results$model5 <- microbenchmark(
    blimp = {
        model5_blimp <- rblimp_source('assets/model5.imp', output = 'none')
    },
    mplus = {
        model5_mplus <- suppressWarnings(runModels('assets/model5.inp'))
    },
    blavaan = {
        model5_blavaan <- bsem(
            data = data1,
            ordered = c('m_bin','xc1','xc2','xc3','xc4'),
            model = '
                eta ~~ m_bin
                eta ~~ 1*eta
                eta =~ NA*xc1 + xc2 + xc3 + xc4
                xc3 ~~ xc4
                y ~ m_bin + eta',
            test = 'none',
            bcontrol = list(refresh = 0, cores = 2),
            n.chains = 2,
            burnin = 500, sample = 1000)
    },
    times = n_times,
    unit = "s"
)
cat("Model 5 complete.\n\n")

#-------------------------------------------------------------------#
#### MODEL 6: Multicategorical Predictor Model ####
#
# Model Specification:
#  - Normal outcome variable
#  - Multicategorical exogenous predictor (m_nom)
#  - Ordinal factor indicators (xc1:xc4)
#  - Correlated indicator residuals (xc3, xc4)
#  - MCMC Settings: burn=20000, iter=20000
#
# Note: Requires complete data for Mplus/blavaan
#-------------------------------------------------------------------#

cat("Benchmarking Model 6...\n")

## Create dummy variables for blavaan (requires complete data)
data1$m1dummy <- ifelse(data1$m_nom == 1, 1, 0)
data1$m2dummy <- ifelse(data1$m_nom == 2, 1, 0)

benchmark_results$model6 <- microbenchmark(
    blimp = {
        model6_blimp <- rblimp_source('assets/model6.imp', output = 'none')
    },
    mplus = {
        model6_mplus <- suppressWarnings(runModels('assets/model6.inp'))
    },
    blavaan = {
        model6_blavaan <- bsem(
            data = data1,
            ordered = c('xc1','xc2','xc3','xc4'),
            model = '
                eta ~ m1dummy + m2dummy
                eta ~~ 1*eta
                eta =~ NA*xc1 + xc2 + xc3 + xc4
                xc3 ~~ xc4
                y ~ m1dummy + m2dummy + eta',
            test = 'none',
            bcontrol = list(refresh = 0, cores = 2),
            n.chains = 2,
            burnin = 500, sample = 1000)
    },
    times = n_times,
    unit = "s"
)
cat("Model 6 complete.\n\n")

#-------------------------------------------------------------------#
#### MODEL 13: Linear Growth Model ####
#
# Model Specification:
#  - Linear growth with four normal repeated measurements (x1-x4)
#  - Binary exogenous predictor (m_bin)
#  - AR(1) structure on residuals
#  - Normal distal outcome (y)
#  - Latent variables: alpha (intercept), eta (slope)
#  - MCMC Settings: burn=10000, iter=10000
#
# Note: blavaan cannot estimate this model
#-------------------------------------------------------------------#

cat("Benchmarking Model 13...\n")
benchmark_results$model13 <- microbenchmark(
    blimp = {
        model13_blimp <- rblimp_source('assets/model13.imp', output = 'none')
    },
    mplus = {
        model13_mplus <- suppressWarnings(runModels('assets/model13.inp'))
    },
    times = n_times,
    unit = "s"
)
cat("Model 13 complete (blavaan cannot estimate this model).\n\n")

#-------------------------------------------------------------------#
#### MODEL 14: Sum Score Predictor Model ####
#
# Model Specification:
#  - Normal outcome variable
#  - Sum score predictor (xc1:xc4)
#  - Binary manifest predictor (m_bin)
#  - Ordinal indicators (xc1:xc4)
#  - MCMC Settings: burn=20000, iter=20000
#-------------------------------------------------------------------#

cat("Benchmarking Model 14...\n")

## Create sum score for blavaan
data1$xsum <- data1$xc1 + data1$xc2 + data1$xc3 + data1$xc4

benchmark_results$model14 <- microbenchmark(
    blimp = {
        model14_blimp <- rblimp_source('assets/model14.imp', output = 'none')
    },
    mplus = {
        model14_mplus <- suppressWarnings(runModels('assets/model14.inp'))
    },
    blavaan = {
        model14_blavaan <- bsem(
            data = data1,
            model = 'y ~ xsum + m_bin',
            test = 'none',
            bcontrol = list(refresh = 0, cores = 2),
            n.chains = 2,
            burnin = 500, sample = 1000)
    },
    times = n_times,
    unit = "s"
)
cat("Model 14 complete.\n\n")

#-------------------------------------------------------------------#
#### MODEL 17: Two-Level Random Slope Model ####
#
# Model Specification:
#  - Two-level random slope model
#  - Normal outcome variable
#  - Binary exogenous predictor (m_bin)
#  - Latent group means (x.mean)
#  - Cross-level interaction
#  - Binary by latent group mean interaction
#  - MCMC Settings: burn=10000, iter=10000
#
# Note: blavaan cannot estimate this model
#-------------------------------------------------------------------#

cat("Benchmarking Model 17...\n")
benchmark_results$model17 <- microbenchmark(
    blimp = {
        model17_blimp <- rblimp_source('assets/model17.imp', output = 'none')
    },
    mplus = {
        model17_mplus <- suppressWarnings(runModels('assets/model17.inp'))
    },
    times = n_times,
    unit = "s"
)
cat("Model 17 complete (blavaan cannot estimate this model).\n\n")

#-------------------------------------------------------------------#
#### MODEL 20: Two-Part Outcome Model ####
#
# Model Specification:
#  - Two-part outcome variable (binary indicator u, continuous yr)
#  - Multicategorical exogenous predictor (m_nom)
#  - Ordinal factor indicators (xc1:xc4)
#  - Correlated indicator residuals (xc3, xc4)
#  - Data transformation to create binary and continuous parts
#  - MCMC Settings: burn=20000, iter=20000
#
# Note: Requires complete data for Mplus/blavaan
#-------------------------------------------------------------------#

cat("Benchmarking Model 20...\n")
benchmark_results$model20 <- microbenchmark(
    blimp = {
        model20_blimp <- rblimp_source('assets/model20.imp', output = 'none')
    },
    blavaan = {
        model20_blavaan <- bsem(
            data = data1,
            ordered = c('xc1','xc2','xc3','xc4'),
            model = '
                eta ~ m1dummy + m2dummy
                eta =~ xc1 + xc2 + xc3 + xc4
                xc3 ~~ xc4
                y ~ m1dummy + m2dummy + eta',
            test = 'none',
            bcontrol = list(refresh = 0, cores = 2),
            n.chains = 2,
            burnin = 500, sample = 1000)
    },
    times = n_times,
    unit = "s"
)
cat("Model 20 complete (Mplus cannot estimate this model).\n\n")

#-------------------------------------------------------------------#
#### MODEL 21: Random Intercept Cross-Lagged Panel Model ####
#
# Model Specification:
#  - Random intercept cross-lagged panel model (RI-CLPM)
#  - Three waves of bivariate data (x1-x3, y1-y3)
#  - Latent variables: alpha (random intercept for x),
#    eta (random intercept for y)
#  - Cross-lagged effects between x and y
#  - Correlated residuals within time points
#  - MCMC Settings: burn=10000, iter=10000
#
# Note: blavaan cannot estimate this model
#-------------------------------------------------------------------#

cat("Benchmarking Model 21...\n")
benchmark_results$model21 <- microbenchmark(
    blimp = {
        model21_blimp <- rblimp_source('assets/model21.imp', output = 'none')
    },
    mplus = {
        model21_mplus <- suppressWarnings(runModels('assets/model21.inp'))
    },
    times = n_times,
    unit = "s"
)
cat("Model 21 complete (blavaan cannot estimate this model).\n\n")

#-------------------------------------------------------------------#
#### Save Results ####
#-------------------------------------------------------------------#

cat("================================================================================\n")
cat("Saving benchmark results...\n")

# Capture session info at time of benchmark
attr(benchmark_results, "session_info") <- sessionInfo()
attr(benchmark_results, "benchmark_date") <- Sys.time()

saveRDS(benchmark_results, file = 'benchmark_results.rds')
cat("Benchmark complete! Results saved to benchmark_results.rds\n")
cat("================================================================================\n")
