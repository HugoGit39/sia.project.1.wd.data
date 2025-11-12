Data-wrangling pipeline to build Shiny-ready and OSF-ready datasets for the Wearables Inventory (WI).
The workflow follows best practices from Reproducible Science in Ecology & Evolution
—emphasising tidy data, version control, scripted processing, and frozen environments.

Why this repo?

One canonical, scripted pipeline from raw Excel inputs → tidy mother tables → one-row-per-device view → exports for Shiny & OSF.

Deterministic runs, minimal manual steps, clear provenance of each output.

Repository structure
sia.project.1.wi.data/
├─ data/
│  ├─ raw/                # Excel inputs (not tracked, see .gitignore)
│  └─ output/             # Pipeline outputs (CSV/XLSX) for Shiny & OSF
├─ R/
│  ├─ build_df_shiny_wi.R # Main script: reads Excels, validates, exports
│  └─ utils.R             # Small helpers (e.g., yn_to_logical, norm_id)
├─ renv/                  # Reproducible R environment (optional)
├─ .gitignore
└─ README.md

Inputs (expected in data/raw/)

devices.xlsx

signals.xlsx (long format with additional fields, e.g., sampling_rate_min/max, notes, location)

technical_specs.xlsx

data_access.xlsx

rvu_synthesis.xlsx (validity/reliability/usability)

expert_scores.xlsx

Keep raw files out of version control. Add large or sensitive files to .gitignore.

Outputs (written to output/data/)

df_shiny_wi.csv / df_shiny_wi.xlsx — one row per device, joined metadata (no signals flattened)

signals_long.csv / signals_long.xlsx — per-signal long table (source of truth for signal details)

df_shiny_wi_flags.csv / df_shiny_wi_flags.xlsx — optional availability matrix for quick UI
