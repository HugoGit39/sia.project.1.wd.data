########################################################################
# Build Shiny-ready tables for filtering & detailed info
#
# Purpose:
#   Split the wide master table (one row per device) into:
#     1) A compact filter table used by the Shiny filters
#        (df_shiny_sia_wd_filter)
#     2) A complementary info table with all remaining columns
#        (df_shiny_sia_wd_info) that can be shown in
#        "details" views / popups, etc.
#
# Inputs (from data/processed/):
#   - df_wide_sia_wd_<YYYYMMDD>.rds
#       Full wide dataset:
#         * 1 row per device
#         * All scores, specs, signals, data access & RVU fields
#
# Outputs (to data/processed/):
#   - df_shiny_sia_wd_filter_<YYYYMMDD>.rds
#       * Only columns used in:
#           - product comparison filter
#           - feature filter
#       * Includes device_id + key metadata + yes/no flags + numerics
#
#   - df_shiny_sia_wd_info_<YYYYMMDD>.rds
#       * device_id + all NON-filter columns
#       * Ready to be joined back (by device_id) for:
#           - "Show details" buttons in reactable
#           - extra technical / textual info per device
#
# Notes:
#   - device_id lives in BOTH tables and is the only key you need to
#     re-attach detailed info to filtered results.
#
# Stress in Action 2025
########################################################################

# * 1  Load wide dataset ----
date_suffix <- format(Sys.Date(), "%Y%m%d")
df_wide_sia_wd <- readRDS(here("data", "processed", paste0("df_wide_sia_wd_", date_suffix, ".rds")))

# * 2  Define product filter columns ----
product_filter_cols <- c(
  "device_id",
  "long_term_all_score",
  "short_term_all_score",
  "manufacturer",
  "model",
  "website",
  "release_year",
  "market_status",
  "main_use",
  "device_cost",
  "wearable_type",
  "location",
  "size_mm",
  "weight_gr",
  "bio_cueing_spec_boel_value",
  "bio_feedback_spec_boel_value",
  "water_resistance_spec_boel_value",
  "battery_life_spec_num_value",
  "charging_duration_spec_num_value",
  "accelerometer_available",
  "bp_available",
  "ecg_available",
  "eda_available",
  "eeg_available",
  "emg_available",
  "gps_available",
  "gyroscope_available",
  "icg_available",
  "other_signals_available",
  "ppg_available",
  "respiration_available",
  "skin_temperature_available",
  "fda_clearance_spec_boel_value",
  "gdpr_compliance_spec_boel_value",
  "ce_marking_spec_boel_value",
  "int_storage_met_spec_boel_value",
  "raw_data_available_spec_boel_value",
  "server_data_storage_spec_boel_value",
  "dev_storage_cap_hr_spec_num_value",
  "dev_storage_cap_mb_spec_num_value",
  "usability_n_of_studies",
  "validity_and_reliability_n_of_studies",
  "usability_evidence_level",
  "validity_and_reliability_evidence_level"
)

# * 3  Create Shiny subsets ----

# (A) Filter table
df_shiny_sia_wd_filter <- df_wide_sia_wd %>%
  select(any_of(product_filter_cols))

# (B) Info table (everything else)
df_shiny_sia_wd_info <- df_wide_sia_wd %>%
  select(-any_of(setdiff(product_filter_cols, "device_id"))
  )

# * 4  Save outputs ----
saveRDS(df_shiny_sia_wd_filter, here("data", "processed", paste0("df_shiny_sia_wd_filter_", date_suffix, ".rds")))
saveRDS(df_shiny_sia_wd_info, here("data", "processed", paste0("df_shiny_sia_wd_info_", date_suffix, ".rds")))
