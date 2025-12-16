########################################################################
# Build OSF-ready overview df 
#
# Purpose:
#   Create a c human-readable overview (one row per device)
#   for OSF / Excel, starting FROM the wide df_wide_sia_wd_subset.
#
# Important:
#   - This is an extra, convenience layer on top of df_wide_sia_wd_subset.
#
# What happens here:
#   1) Create derived columns:
#      - merge device_cost + device_cost_info
#      - prefer rectangular size, else round
#      - combine OS compatibility into a single text field
#      - build per-signal cells: 1/0 + info + rate range + location
#      - build spec / data access / RVU synthesis fields
#   2) Select and rename columns into the final layout
#   3) Write df_osf.xlsx to output/data/
#
# Inputs:
#   df_wide_sia_wd_subset  (from the wide pipeline)
#
# Output:
#   output/data/df_osf.xlsx
#
# Stress in Action 2025
########################################################################

# * 1  functions ----
source(here("src","function","sai.p1.functions.R"))

# * 2  read wide  data wd df ----

# Create today date
date_suffix <- format(Sys.Date(), "%Y%m%d")

df_wide_sia_wd <- read_rds(here("data","processed",paste0("df_wide_sia_wd_", date_suffix, ".rds")))

# * 3  create df_osf ----
df_osf_sia_wd <- df_wide_sia_wd %>%
  # first create all derived columns we need
  mutate(

# * * 3.1  devices ----
    device_costs = paste_nonempty(device_cost, device_cost_info),
    
    # compatibility merged from data_access specs
    compatibility = paste_nonempty(
      ifelse(!is.na(windows_compatible_spec_boel_value),
             paste0("Windows ", windows_compatible_spec_char_value), NA_character_),
      ifelse(!is.na(ios_compatible_spec_boel_value),
             paste0("iOS ", ios_compatible_spec_char_value), NA_character_),
      ifelse(!is.na(android_compatible_spec_boel_value),
             paste0("Android ", android_compatible_spec_char_value), NA_character_),
      ifelse(!is.na(macos_compatible_spec_boel_value),
             paste0("macOS ", macos_compatible_spec_char_value), NA_character_)
    ),
    
# * * 3.2  signals ----
    PPG           = paste_nonempty(
      yn_to_flag(ppg_available),
      ppg_additional_info,
      rate_str(ppg_sampling_rate_min, ppg_sampling_rate_max),
      ppg_recording_location),
    ECG           = paste_nonempty(
      yn_to_flag(ecg_available),
      ecg_additional_info,
      rate_str(ecg_sampling_rate_min, ecg_sampling_rate_max),
      ecg_recording_location),
    ICG           = paste_nonempty(
      yn_to_flag(icg_available),
      icg_additional_info,
      rate_str(icg_sampling_rate_min, icg_sampling_rate_max),
      icg_recording_location),
    EMG           = paste_nonempty(
      yn_to_flag(emg_available),
      emg_additional_info,
      rate_str(emg_sampling_rate_min, emg_sampling_rate_max),
      emg_recording_location),
    Respiration   = paste_nonempty(
      yn_to_flag(respiration_available),
      respiration_additional_info,
      rate_str(respiration_sampling_rate_min, respiration_sampling_rate_max),
      respiration_recording_location),
    EDA           = paste_nonempty(
      yn_to_flag(eda_available),
      eda_additional_info,
      rate_str(eda_sampling_rate_min, eda_sampling_rate_max),
      eda_recording_location),
    EEG           = paste_nonempty(
      yn_to_flag(eeg_available),
      eeg_additional_info,
      rate_str(eeg_sampling_rate_min, eeg_sampling_rate_max),
      eeg_recording_location),
    BP            = paste_nonempty(
      yn_to_flag(bp_available),
      bp_additional_info,
      rate_str(bp_sampling_rate_min, bp_sampling_rate_max),
      bp_recording_location),
    Accelerometer = paste_nonempty(
      yn_to_flag(accelerometer_available),
      accelerometer_additional_info,
      rate_str(accelerometer_sampling_rate_min, accelerometer_sampling_rate_max),
      accelerometer_recording_location),
    Gyroscope     = paste_nonempty(
      yn_to_flag(gyroscope_available),
      gyroscope_additional_info,
      rate_str(gyroscope_sampling_rate_min, gyroscope_sampling_rate_max),
      gyroscope_recording_location),
    GPS           = paste_nonempty(
      yn_to_flag(gps_available),
      gps_additional_info,
      rate_str(gps_sampling_rate_min, gps_sampling_rate_max),
      gps_recording_location),
    Skin_temperature = paste_nonempty(
      yn_to_flag(skin_temperature_available),
      skin_temperature_additional_info,
      rate_str(skin_temperature_sampling_rate_min, skin_temperature_sampling_rate_max),
      skin_temperature_recording_location),
    Other_signals = paste_nonempty(
      yn_to_flag(other_signals_available),
      other_signals_additional_info,
      rate_str(other_signals_sampling_rate_min, other_signals_sampling_rate_max),
      other_signals_recording_location),
    
# * * 3.3  technical specs ----
    Water_resistance   = yn_to_flag(water_resistance_spec_boel_value),
    Battery_life       = paste_nonempty(battery_life_spec_num_value, battery_life_spec_num_unit),
    Charging_method    = charging_method_spec_char_value,
    Charging_duration  = paste_nonempty(charging_duration_spec_num_value, charging_duration_spec_num_unit),
    Bio_cueing         = yn_to_flag(bio_cueing_spec_boel_value),
    Bio_feedback       = yn_to_flag(bio_feedback_spec_boel_value),
    
# * * 3.4  data acces ----
    Raw_data_available      = yn_to_flag(raw_data_available_spec_boel_value),
    Provided_parameters     = parameters_available_spec_char_value,
    Parameter_sampling_window = parameters_resolution_spec_char_value,
    Data_transfer_method    = data_transfer_method_spec_char_value,
    Required_software       = software_required_spec_char_value,
    Additional_software     = software_additional_spec_char_value,
    Internal_storage_method = int_storage_met_spec_char_value,
    Device_storage_capacity = paste_nonempty(
      paste_nonempty(dev_storage_cap_hr_spec_num_value, dev_storage_cap_hr_spec_num_unit),
      paste_nonempty(dev_storage_cap_mb_spec_num_value, dev_storage_cap_mb_spec_num_unit)
    ),
    Server_Data_Storage  = server_data_storage_spec_char_value,
    GDPR_compliance      = yn_to_flag(gdpr_compliance_spec_boel_value),
    FDA_approval         = yn_to_flag(fda_clearance_spec_boel_value),
    CE_approval          = yn_to_flag(ce_marking_spec_boel_value),
    
# * * 3.5  rvu ----
Highest_validation_evidence =
  reliability_and_validity_evidence_level,
N_validity_reliability =
  reliability_and_validity_n_of_studies,
RVU_studied_parameters =
  reliability_and_validity_parameters_studied,
RVU_validity_synthesis =
  reliability_and_validity_synthesis,
N_usability_studies =
  usability_n_of_studies,
RVU_usability_synthesis =
  usability_synthesis,
RVU_last_search_date =
  coalesce(reliability_and_validity_date_of_last_search,
           usability_date_of_last_search),

    
# * * 3.6  expert scores scores ----
    SiA_score_short_term = short_term_all_score,
    SiA_score_long_term  = long_term_all_score
  ) %>%
  # rename columns into the final layout
  transmute(
    device_id,
    Manufacturer              = manufacturer,
    Device                    = model,
    Website                   = website,
    `Release date`            = release_year,
    `Market status`           = market_status,
    `Main use`                = main_use,
    `Device costs`            = device_costs,
    `Wearable type`           = wearable_type,
    Location                  = location,
    Weight                    = weight_gr,
    Size                      = size_mm,
    
    PPG                       = PPG,
    ECG                       = ECG,
    ICG                       = ICG,
    EMG                       = EMG,
    Respiration               = Respiration,
    EDA                       = EDA,
    EEG                       = EEG,
    BP                        = BP,
    Accelerometer             = Accelerometer,
    Gyroscope                 = Gyroscope,
    GPS                       = GPS,
    `Skin temperature`        = Skin_temperature,
    `Other signals`           = Other_signals,
    
    `Water resistance`        = Water_resistance,
    `Battery life`            = Battery_life,
    `Charging method`         = Charging_method,
    `Charging duration`       = Charging_duration,
    `Bio-cueing`              = Bio_cueing,
    `Bio-feedback`            = Bio_feedback,
    
    `Raw data available`      = Raw_data_available,
    `Provided parameters`     = Provided_parameters,
    `Parameter sampling window (1min; 5min; 1hour; 1day)` = Parameter_sampling_window,
    `Data transfer method`    = Data_transfer_method,
    Compatibility             = compatibility,
    `Required software`       = Required_software,
    `Additional software`     = Additional_software,
    `Internal storage method` = Internal_storage_method,
    `Device storage capacity` = Device_storage_capacity,
    `Server Data Storage`     = Server_Data_Storage,
    `GDPR compliance`         = GDPR_compliance,
    `FDA approval/clearance`  = FDA_approval,
    `CE approval/label`       = CE_approval,
    
    `Highest level of Validation Evidence`          = Highest_validation_evidence,
    `Number of validity and reliability studies reviewed` = N_validity_reliability,
    `Studied parameters`                            = RVU_studied_parameters,
    `General validity and reliability synthesis`    = RVU_validity_synthesis,
    `Number of usability studies reviewed`          = N_usability_studies,
    `General usability synthesis`                   = RVU_usability_synthesis,
    `Hyperlink to the device VRU page`              = NA_character_,  # fill later if needed
    `Most recent date of RVU search`                = RVU_last_search_date,
    
    `SiA Expert score (short-term)` = SiA_score_short_term,
    `SiA Expert score (long-term)`  = SiA_score_long_term
  )

# * 4 write final osf df----
write_xlsx(list(df_osf_sia_wd = df_osf_sia_wd), here("data","processed", paste0("df_osf_sia_wd_", date_suffix, ".xlsx")))

saveRDS(df_osf_sia_wd, here("data", "processed", paste0("df_osf_sia_wd_shiny_", date_suffix, ".rds")))
