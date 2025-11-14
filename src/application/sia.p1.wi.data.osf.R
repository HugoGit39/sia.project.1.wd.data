# * 1  read raw data ----
source(here("src","application","sia.p1.read.data.R"))

# * 1 devices df ----
osf_devices <- devices %>%
  mutate(
    # merge numeric cost + textual info
    device_costs = paste_nonempty(device_cost, device_cost_info),
    # prefer rectangular size, else round
    size_osf = coalesce(size_rect_mm, size_round_mm)
  ) %>%
  transmute(
    device_id,
    Manufacturer    = manufacturer,
    Device          = model,
    Website         = website,
    `Release date`  = release_year,
    `Market status` = market_status,
    `Main use`      = main_use,
    `Device costs`  = device_costs,
    `Wearable type` = wearable_type,
    Location        = location,
    Size            = size_osf,
    Weight          = weight_gr
  )

# * 2 signals df ----
osf_signals <- signals_long %>%
  mutate(
    # numeric sampling rates
    sampling_rate_min = suppressWarnings(as.numeric(sampling_rate_min)),
    sampling_rate_max = suppressWarnings(as.numeric(sampling_rate_max)),
    # 1/0 flag from Yes/No
    available_flag    = yn_to_flag(available)
  ) %>%
  group_by(device_id, signal_name) %>%
  summarise(
    available_flag     = first(na.omit(available_flag)),
    sr_min             = suppressWarnings(min(sampling_rate_min, na.rm = TRUE)),
    sr_max             = suppressWarnings(max(sampling_rate_max, na.rm = TRUE)),
    additional_info    = first(na.omit(additional_info)),
    recording_location = first(na.omit(recording_location)),
    .groups = "drop"
  ) %>%
  mutate(
    sr_min = ifelse(is.infinite(sr_min), NA_real_, sr_min),
    sr_max = ifelse(is.infinite(sr_max), NA_real_, sr_max),
    signal_cell = paste_nonempty(
      available_flag,
      additional_info,
      rate_str(sr_min, sr_max),
      recording_location
    )
  ) %>%
  select(device_id, signal_name, signal_cell) %>%
  # long -> wide: one column per signal
  pivot_wider(
    id_cols = device_id,
    names_from = signal_name,
    values_from = signal_cell
  ) %>%
  rename(
    PPG              = ppg,
    ECG              = ecg,
    ICG              = icg,
    EMG              = emg,
    Respiration      = respiration,
    EDA              = eda,
    EEG              = eeg,
    BP               = bp,
    Accelerometer    = accelerometer,
    Gyroscope        = gyroscope,
    GPS              = gps,
    `Skin temperature` = skin_temperature,
    `Other signals`  = other_signals
  )

# * 3 technical specs df ----
# specs already loaded as:
# specs <- read_xlsx(p_specs) %>% clean_names()

osf_specs <- specs %>%
  mutate(
    spec_num_value = suppressWarnings(as.numeric(spec_num_value))
  ) %>%
  group_by(device_id, spec_name) %>%
  summarise(
    spec_boel_value = first(na.omit(spec_boel_value), default = NA),
    spec_num_value  = suppressWarnings(max(spec_num_value, na.rm = TRUE)),
    spec_char_value = first(na.omit(spec_char_value), default = NA),
    .groups = "drop"
  ) %>%
  mutate(
    spec_num_value = ifelse(is.infinite(spec_num_value), NA_real_, spec_num_value)
  ) %>%
  # long -> wide: separate columns for boel/num/char per spec_name
  pivot_wider(
    id_cols   = device_id,
    names_from  = spec_name,
    values_from = c(spec_boel_value, spec_num_value, spec_char_value),
    names_glue = "{.value}_{spec_name}"
  ) %>%
  # build the OSF technical-spec columns from those wide cols
  mutate(
    # Water resistance: 1/0 flag + char value ("1; 30")
    Water_resistance = paste_nonempty(
      yn_to_flag(spec_boel_value_water_resistance),
      spec_char_value_water_resistance
    ),
    # Battery life: numeric only (48)
    Battery_life     = spec_num_value_battery_life,
    # Charging method: text
    Charging_method  = spec_char_value_charging_method,
    # Charging duration: numeric only (120, 90, ...)
    Charging_duration = spec_num_value_charging_duration,
    # Bio-cueing: 1/0 flag
    Bio_cueing       = yn_to_flag(spec_boel_value_bio_cueing),
    # Bio-feedback: Yes -> -1, No -> 0, plus explanation text
    Bio_feedback     = paste_nonempty(
      -1L * yn_to_flag(spec_boel_value_bio_feedback),
      spec_char_value_bio_feedback
    )
  ) %>%
  transmute(
    device_id,
    `Water resistance`  = Water_resistance,
    `Battery life`      = Battery_life,
    `Charging method`   = Charging_method,
    `Charging duration` = Charging_duration,
    `Bio-cueing`        = Bio_cueing,
    `Bio-feedback`      = Bio_feedback
  )

# * 3 data acces ----
osf_data_access <- data_access %>%
  mutate(
    spec_num_value = suppressWarnings(as.numeric(spec_num_value))
  ) %>%
  group_by(device_id, spec_name) %>%
  summarise(
    spec_boel_value = first(na.omit(spec_boel_value), default = NA),
    spec_num_value  = suppressWarnings(max(spec_num_value, na.rm = TRUE)),
    spec_char_value = first(na.omit(spec_char_value), default = NA),
    .groups = "drop"
  ) %>%
  mutate(
    spec_num_value = ifelse(is.infinite(spec_num_value), NA_real_, spec_num_value)
  ) %>%
  # long -> wide: separate boel/num/char cols per spec_name
  pivot_wider(
    id_cols    = device_id,
    names_from = spec_name,
    values_from = c(spec_boel_value, spec_num_value, spec_char_value),
    names_glue = "{.value}_{spec_name}"
  ) %>%
  # build OSF columns
  mutate(
    # 1) Simple flags / text
    Raw_data_available  = yn_to_flag(spec_boel_value_raw_data_available),
    Provided_parameters = spec_char_value_parameters_available,
    Parameter_sampling_window = spec_char_value_parameters_resolution,
    Data_transfer_method      = spec_char_value_data_transfer_method,
    
    # 2) Compatibility from OS-specific specs
    Compatibility = paste_nonempty(
      ifelse(!is.na(spec_boel_value_windows_compatible),
             paste0("Windows ", spec_char_value_windows_compatible), NA_character_),
      ifelse(!is.na(spec_boel_value_ios_compatible),
             paste0("iOS ", spec_char_value_ios_compatible), NA_character_),
      ifelse(!is.na(spec_boel_value_android_compatible),
             paste0("Android ", spec_char_value_android_compatible), NA_character_),
      ifelse(!is.na(spec_boel_value_macos_compatible),
             paste0("macOS ", spec_char_value_macos_compatible), NA_character_)
    ),
    
    # 3) Software: include 1/0 flag + list
    Required_software = paste_nonempty(
      yn_to_flag(spec_boel_value_software_required),
      spec_char_value_software_required
    ),
    Additional_software = paste_nonempty(
      yn_to_flag(spec_boel_value_software_additional),
      spec_char_value_software_additional
    ),
    
    # 4) Internal storage
    Internal_storage_method = paste_nonempty(
      yn_to_flag(spec_boel_value_int_storage_met),
      spec_char_value_int_storage_met
    ),
    
    # 5) Device storage capacity: numeric hours + numeric MB
    Device_storage_capacity = paste_nonempty(
      spec_num_value_dev_storage_cap_hr,
      spec_num_value_dev_storage_cap_mb
    ),
    
    # 6) Server data storage: 1/0 + location text
    Server_Data_Storage = paste_nonempty(
      yn_to_flag(spec_boel_value_server_data_storage),
      spec_char_value_server_data_storage
    ),
    
    # 7) Compliance / approvals (just 1/0)
    GDPR_compliance     = yn_to_flag(spec_boel_value_gdpr_compliance),
    FDA_approval        = yn_to_flag(spec_boel_value_fda_clearance),
    CE_approval         = yn_to_flag(spec_boel_value_ce_marking)
  ) %>%
  transmute(
    device_id,
    `Raw data available`      = Raw_data_available,
    `Provided parameters`     = Provided_parameters,
    `Parameter sampling window (1min; 5min; 1hour; 1day)` = Parameter_sampling_window,
    `Data transfer method`    = Data_transfer_method,
    Compatibility             = Compatibility,
    `Required software`       = Required_software,
    `Additional software`     = Additional_software,
    `Internal storage method` = Internal_storage_method,
    `Device storage capacity` = Device_storage_capacity,
    `Server Data Storage`     = Server_Data_Storage,
    `GDPR compliance`         = GDPR_compliance,
    `FDA approval/clearance`  = FDA_approval,
    `CE approval/label`       = CE_approval
  )


osf_rvu <- rvu %>%
  mutate(
    # make a stable key from synthesis_type (e.g. "validity_and_reliability", "usability")
    synth_key    = norm_key(synthesis_type),
    n_of_studies = suppressWarnings(as.integer(n_of_studies))
  ) %>%
  group_by(device_id, synth_key) %>%
  summarise(
    n_of_studies        = suppressWarnings(max(n_of_studies, na.rm = TRUE)),
    evidence_level      = first(na.omit(evidence_level),      default = NA),
    parameters_studied  = first(na.omit(parameters_studied),  default = NA),
    synthesis           = first(na.omit(synthesis),           default = NA),
    date_of_last_search = first(na.omit(date_of_last_search), default = NA),
    .groups = "drop"
  ) %>%
  mutate(
    n_of_studies = ifelse(is.infinite(n_of_studies), NA_integer_, n_of_studies)
  ) %>%
  # long -> wide: separate cols for validity_and_reliability_* and usability_*
  pivot_wider(
    id_cols    = device_id,
    names_from = synth_key,
    values_from = c(n_of_studies, evidence_level, parameters_studied, synthesis, date_of_last_search),
    names_glue = "{synth_key}_{.value}"
  ) %>%
  # build OSF columns
  mutate(
    Highest_validation_evidence    = validity_and_reliability_evidence_level,
    N_validity_reliability         = validity_and_reliability_n_of_studies,
    RVU_studied_parameters         = validity_and_reliability_parameters_studied,
    RVU_validity_synthesis         = validity_and_reliability_synthesis,
    N_usability_studies            = usability_n_of_studies,
    RVU_usability_synthesis        = usability_synthesis,
    RVU_last_search_date           = coalesce(validity_and_reliability_date_of_last_search,
                                              usability_date_of_last_search),
    VRU_link                       = NA_character_   # fill later if you have URLs
  ) %>%
  transmute(
    device_id,
    `Highest level of Validation Evidence` = Highest_validation_evidence,
    `Number of validity and reliability studies reviewed` = N_validity_reliability,
    `Studied parameters`     = RVU_studied_parameters,
    `General validity and reliability synthesis` = RVU_validity_synthesis,
    `Number of usability studies reviewed` = N_usability_studies,
    `General usability synthesis`          = RVU_usability_synthesis,
    `Hyperlink to the device VRU page`     = VRU_link,
    `Most recent date of RVU search`       = RVU_last_search_date
  )
