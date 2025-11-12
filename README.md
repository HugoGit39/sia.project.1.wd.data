# sia.project.1.wi.data

Data-wrangling pipeline to build **Shiny-ready** and **OSF-ready** datasets for the Wearables Inventory (WI).  
The workflow follows best practices from _[Reproducible Science in Ecology & Evolution](https://ecorepsci.github.io/reproducible-science/)_ — emphasising tidy data, version control, scripted processing, and reproducible environments.

---

## Why this repo?

- Provides a **reproducible data pipeline** from raw Excel files to Shiny/OSF-ready datasets.  
- Ensures **tidy, relational** structures with `device_id` as the primary key.  
- Guarantees transparency, traceability, and consistency between analyses and published data.

---

## Repository structure

```bash
sia.project.1.wi.data/
├─ data/
│  ├─ processed/           # Clean intermediate data (not exported)
│  ├─ raw/                 # Excel inputs (not tracked, see .gitignore)
│  └─ output/
│     ├─ data/             # Final tidy outputs (CSV/XLSX for Shiny & OSF)
│     ├─ plots/            # Visualisations
│     └─ reporting/        # Tables, summaries, figures
├─ src/
│  ├─ application/         # Shiny integration, UI and data loading scripts
│  ├─ function/            # Utility functions (wrangling, validation, helpers)
│  ├─ reporting/           # Reporting scripts and markdown generators
│  └─ temp/                # Temporary or testing scripts
├─ .gitignore
├─ sia.project.1.wi.data.Rproj
└─ README.md
