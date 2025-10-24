# Factored Structural Equation Modeling in Blimp

This repository contains supplemental material for [*Factored Structural Equation Modeling in Blimp*](https://osf.io/qrza9).

The file structure is as follows:

- **benchmark**: [Blimp speed comparison](benchmark)
- **data**: [Data sets for examples](data)
- **docs**: [Additional online supplemental documents](docs)
  - [Blimp Scripting Quick Start](docs/Blimp%20Scripting%20Quick%20Start.pdf)
  - [Install Guide](docs/Blimp%20Install%20Guide.pdf)
  - [Extended Model Descriptions](docs/Extended%20Model%20Descriptions.pdf)
  - [Derivation of Latent Variable Predictive Distribution](docs/Derivation%20of%20Latent%20Variable%20Predictive%20Distribution.pdf)
- **examples**: [`rblimp` and Blimp Studio examples](examples)
  - [FSEM Real Data Analysis](examples/FSEM%20Real%20Data%20Analysis.pdf)

# Blimp Scripting Language

- See the [quickstart guide](docs/QUICKSTART.md)

# Blimp Installation Guide

Blimp is a standalone software package for Bayesian multilevel structural equation modeling and imputation. It runs as a command-line application across all major operating systems and may also be accessed through **Blimp Studio**, a graphical interface for interactive use, or **rblimp**, an R interface for Blimp.

## 1. System Requirements

| Platform  | Supported Versions | Notes |
|------------|--------------------|-------|
| **macOS** | macOS 11.6 (Big Sur) or later | Intel and Apple Silicon supported |
| **Windows** | Windows 10 or later | Requires admin privileges for installation |
| **Linux** | Ubuntu 20.04+ or RHEL 8+ | Static or dynamic binaries available |

> **Tip:** For Linux users, if your system is older or managed (e.g., a cluster), prefer the **static** build to avoid library dependency issues.

## 2. Downloading Blimp and Blimp Studio

Blimp binaries and installers are hosted on the official website:

**[https://www.appliedmissingdata.com/blimp](https://www.appliedmissingdata.com/blimp)**


### Blimp Studio (Optional GUI for Mac or Windows)

**Blimp Studio** is a companion graphical interface to Blimp that provides:
- Model editing with syntax highlighting  
- Automatic update notifications  
- Project organization tools


Available downloads:

- **macOS installer** (`.dmg`)
- **Windows installer** (`.exe`)
- **Linux binaries:**

   - `blimp_binary.tar.gz` – Ubuntu Static  
   - `blimp_binary_dynlibs.tar.gz` – Ubuntu Dynamic  
   - `blimp_binary-RHEL8.tar.gz` – RHEL 8 Static  
   - `blimp_binary_dynlibs-RHEL8.tar.gz` – RHEL 8 Dynamic  

Offline installers that do not require internet connection are also available for macOS and Windows.

## 3. Installation Instructions

* Note: Blimp Installers version number differs from Blimp's computational engine version number.*

### macOS
1. Download the `.dmg` installer for macOS 11.6+ from the Blimp website.
2. Open the `.dmg` and double-click the installer, follow the installation prompts.
3. Once installed, Blimp and Blimp Studio will be available in `/Applications/Blimp/` by default.

### Windows
1. Download the `.exe` installer for Windows 10+.
2. Right-click and choose **Run as Administrator**, and follow the installation prompts.
3. Once installed, Blimp and Blimp studio will be available in `C:\Program Files\Blimp` by default.


### Linux (Ubuntu/RHEL)
1. Download the appropriate archive for your distribution. Note Blimp Studio is not available for Linux. 
2. Extract the tarball:
   ```bash
   tar -xzf blimp_binary.tar.gz
   ```
3. Move the executable to a directory in your `$PATH`:

4. Run Blimp directly from the terminal:
   ```bash
   blimp mymodel.imp
   ```

#### Static vs. Dynamic Linux Builds

| Type | Description | Recommended for |
|------|--------------|----------------|
| **Static** | Includes all dependencies; larger download size | Clusters, older distros, or restricted systems |
| **Dynamic** | Relies on system libraries; smaller file size | Modern desktop systems with up-to-date runtimes |

If you encounter runtime errors such as `missing libstdc++` or `glibc`, switch to the **static** version.

### Using Blimp on Clusters or Headless Systems

Blimp can be executed without a GUI, making it suitable for:
- High-Performance Computing (HPC) clusters
- Batch job submissions
- Command-line workflows

You can specify data, seeds, or output files directly:
```bash
blimp myscript.imp --data=data.csv --output=results.txt
```

For full argument details, see the *Running From Terminal* section of the [*User Guide*](https://docs.google.com/document/d/1D3MS79CakuX9mVVvGH13B5nRd9XLttp69oGsvrIRK64/view?tab=t.0).

## 5. Known Issues and Troubleshooting

- **Windows antivirus conflicts:**  
  Some antivirus tools may block the installer or executable. Run the installer as Administrator or use the offline installer if network restrictions exist.

- **macOS security warnings:**  
  If macOS prevents launching Blimp, go to *System Settings → Security & Privacy* and click *Allow Anyway*.

## 6. Installing `rblimp` (R Interface)

The **rblimp** package provides an R interface to the Blimp engine.

### Installation (current version)
```r
install.packages("remotes")
remotes::install_github("blimp-stats/rblimp")
```

> Ensure that Blimp itself is installed and available in your system before loading `rblimp`.

### Updating
- Update Blimp by launching the application (it auto-checks for new releases).  
- Update `rblimp` in R:
  ```r
  remotes::update_packages("rblimp")
  ```
  Check your version with:
  ```r
  packageVersion("rblimp")
  ```

> Once `rblimp` is available on CRAN, these instructions will be updated accordingly.

## 8. Support and Resources

- **Official site:** [https://www.appliedmissingdata.com/blimp](https://www.appliedmissingdata.com/blimp)  
- **Documentation:** Included in the [*User Guide*](https://docs.google.com/document/d/1D3MS79CakuX9mVVvGH13B5nRd9XLttp69oGsvrIRK64/view?tab=t.0) available above
- **Support:** Contact information available on the website  

