# Documentation

This folder contains supplemental documentation for [*Factored Structural Equation Modeling in Blimp*](https://osf.io/qrza9).

## Contents

### [QUICKSTART.md](QUICKSTART.md)

A concise quick start guide for Blimp and `rblimp` that covers:

- **Overview** - Introduction to Blimp's scripting language and modeling framework
- **Command Reference** - Descriptions of major Blimp commands including:
  - `DATA`, `VARIABLES`, `MISSING` - Data specification
  - `ORDINAL`, `NOMINAL`, `COUNT` - Variable type declarations
  - `LATENT`, `CLUSTERID` - Latent variables and multilevel structures
  - `CENTER`, `MODEL`, `SIMPLE` - Model specification
  - `BURN`, `ITER`, `SEED` - MCMC algorithm controls
- **Using rblimp** - Examples of translating Blimp scripts to R code using the `rblimp` package

The guide includes a worked example showing how to specify a latent variable model with ordinal indicators, a multicategorical moderator, and interaction effects.

### [Blimp Scripting Quick Start.pdf](Blimp%20Scripting%20Quick%20Start.pdf)

PDF version of the quick start guide with Blimp scripting syntax and command reference.

### [Install-Guide.pdf](Install-Guide.pdf)

Comprehensive installation instructions for Blimp and Blimp Studio across all platforms (macOS, Windows, Linux), including system requirements and troubleshooting.

### [Extended Model Descriptions.pdf](Extended%20Model%20Descriptions.pdf)

Detailed mathematical descriptions and specifications for the 22 models demonstrated in the example scripts, including:
- Model equations and notation
- Parameter interpretations
- Estimation details
- Model comparisons

### [Derivation of Latent Variable Predictive Distribution.pdf](Derivation%20of%20Latent%20Variable%20Predictive%20Distribution.pdf)

Technical document providing mathematical derivations of the latent variable predictive distributions used in Blimp's factored regression approach.
