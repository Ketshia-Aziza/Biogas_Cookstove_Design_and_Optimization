# Computational Fluid Dynamics (CFD) Analysis of a Household Biogas Burner

![Status](https://img.shields.io/badge/Status-Complete-green)
![Field](https://img.shields.io/badge/Field-Energy%20Engineering-blue)
![Software](https://img.shields.io/badge/Software-ANSYS%20%7C%20MATLAB%20%7C%20SolidWorks-orange)

## 👤 Author & Background
* **Author:** Ketshia Ngalula Aziza
* **Degree:** MSc Energy Engineering (PAUWES)
* **Focus:** Clean Cooking Technology & Computational Modeling

---

## 1. 🎯 Background and Objective
Clean cooking technologies require optimized fuel–air mixing and controlled heat distribution to improve thermal efficiency and reduce pollutant emissions. As part of my Master’s thesis, CFD simulations were conducted to analyze the airflow behavior, thermal fields, and combustion characteristics of a household biogas burner.

**The objectives of this study were:**
* **Evaluate** fuel–air mixing quality inside the burner.
* **Assess** flame stabilization and temperature distribution.
* **Validate** analytical design parameters calculated using a custom MATLAB-based model.

---

## 2. 🛠️ Methodology & Software Stack
This project follows a "Computational X" workflow, integrating parametric design with numerical validation.

| Stage | Software | Function |
| :--- | :--- | :--- |
| **Analytical Design** | MATLAB | Dimensioning of injector, mixing tube, and air ports. |
| **3D Modeling** | SolidWorks | Generating watertight CAD geometries. |
| **Simulation** | ANSYS Fluent R2025 | CFD Analysis (Mixing & Reacting Flows). |

### Geometry and Mesh Generation
A watertight polyhedral hex-core mesh was constructed with local refinement in high-gradient zones (fuel/air inlets and combustion zones). This ensured accurate resolution of velocity, temperature, and species gradients while maintaining computational efficiency.

---

## 3. 🧪 Numerical Solver Setup

### 3.1 Mixing Flow Simulation (Non-Reacting)
Analyzes the quality of fuel–air mixing inside the mixing tube prior to combustion.
* **Solver:** Pressure-based, steady-state.
* **Models:** Species Transport (non-reacting), Realizable k–ε Turbulence.
* **Boundary Conditions:** Mass flow inlet (60% CH₄, 40% CO₂) and air inlet (21% O₂).

### 3.2 Combustion Simulation (Reacting Flow)
Analyzes flame structure, temperature fields, and species distribution.
* **Models:** Non-premixed combustion, PDF approach for turbulent mixing.
* **Radiation:** P1 model.
* **Physics:** Non-adiabatic energy treatment; Stoichiometric mixture fraction refinement.

---

## 4. 📊 Results and Interpretation

### 4.1 Cold-Flow Analysis
The simulation confirmed that the analytically calculated injector and port dimensions provided a **uniform velocity profile** at the burner outlet, essential for preventing flash-back or lift-off and ensuring stable combustion.

### 4.2 Reacting Flow Analysis
The combustion results validated a stable flame anchored near the burner ports with the following characteristics:

| Metric | Result | Interpretation |
| :--- | :--- | :--- |
| **Max Temperature** | **2063 K** | Combustion occurring within the stoichiometric reaction zone. |
| **O₂ Contours** | Depletion at front | Confirms proper stoichiometric balance and stabilization. |
| **CO₂ Contours** | Post-flame conc. | Indicates complete and efficient fuel utilization. |
| **CO Contours** | Localized core | Rapid downstream oxidation to CO₂ confirms low emissions. |
| **CH₄ Contours** | Rapid consumption | Effective fuel-air mixing and immediate oxidation. |

### Visual Validation
*(Upload your contours to a folder named `images` and update the links below)*

![Temperature Contour](images/temperature_contour.png)  
*Figure 1: Temperature contour showing stabilized flame at 2063K.*

---

## 5. 🔗 Integration & Impact
This repository demonstrates a complete engineering design loop:
1. **Parametric Modeling:** Using MATLAB for theoretical engineering foundations.
2. **CFD Validation:** Using ANSYS Fluent to refine and prove the design through numerical analysis.
3. **Policy Relevance:** This data-driven approach supports clean energy transition strategies by providing a framework for low-emission cooking solutions in developing contexts.

## ⚠️ Scope & Limitations
* Simulations were conducted under **steady-state** assumptions using RANS turbulence modeling.
* Future work could include transient simulations, detailed chemical kinetic models, and sensitivity analyses.

---

## 📂 Repository Structure
* `/MATLAB`: Analytical design and ranking scripts.
* `/CAD`: STEP and STL files of the burner geometry.
* `/Docs`: Detailed technical walkthrough and parameter tables.
* `/Images`: Result contours (Temperature, CO, CO2, O2, CH4) and mesh previews.

---
*For more information or collaboration inquiries, feel free to reach out via [LinkedIn](https://www.linkedin.com/in/ketshia-ngalula-aziza-b5b00b122).*
