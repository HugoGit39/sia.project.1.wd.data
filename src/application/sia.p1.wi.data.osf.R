

# * 1 devices df ----
devices_osf <- devices %>%
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
signals_osf <- signals_long %>%
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
# summarise per device/spec_name and pivot wide
specs_osf <- specs %>%
  mutate(
    spec_num_value = suppressWarnings(as.numeric(spec_num_value))
  ) %>%
  group_by(device_id, spec_name) %>%
  summarise(
    spec_boel_value = first(na.omit(spec_boel_value), default = NA),
    spec_num_value  = suppressWarnings(max(spec_num_value, na.rm = TRUE)),
    spec_num_unit   = first(na.omit(spec_num_unit),  default = NA),
    spec_char_value = first(na.omit(spec_char_value), default = NA),
    .groups = "drop"
  ) %>%
  mutate(
    spec_num_value = ifelse(is.infinite(spec_num_value), NA_real_, spec_num_value)
  ) %>%
  pivot_wider(
    id_cols = device_id,
    names_from = spec_name,
    values_from = c(spec_boel_value, spec_num_value, spec_num_unit, spec_char_value),
    names_glue = "{spec_name}_{.value}"
  )

# build OSF-ready columns from the wide specs
df_osf_specs <- specs_wide_osf %>%
  mutate(
    # Water resistance: 1/0 flag + char (e.g. "1; 30")
    Water_resistance = paste_nonempty(
      yn_to_flag(water_resistance_spec_boel_value),
      water_resistance_spec_char_value
    ),
    # Battery life: numeric + unit (or just numeric if you prefer)
    Battery_life     = paste_nonempty(
      battery_life_spec_num_value,
      battery_life_spec_num_unit
    ),
    # Charging method: free text
    Charging_method  = charging_method_spec_char_value,
    # Charging duration: numeric + unit
    Charging_duration = paste_nonempty(
      charging_duration_spec_num_value,
      charging_duration_spec_num_unit
    ),
    # Bio-cueing: 1/0 flag from Yes/No
    Bio_cueing       = yn_to_flag(bio_cueing_spec_boel_value),
    # Bio-feedback: 1/0 + textual explanation
    # (if you want -1 instead of 1 for “special case”, change yn_to_flag() here)
    Bio_feedback     = paste_nonempty(
      yn_to_flag(bio_feedback_spec_boel_value),
      bio_feedback_spec_char_value
    )
  ) %>%
  transmute(
    device_id,
    `Water resistance`   = Water_resistance,
    `Battery life`       = Battery_life,
    `Charging method`    = Charging_method,
    `Charging duration`  = Charging_duration,
    `Bio-cueing`         = Bio_cueing,
    `Bio-feedback`       = Bio_feedback
  )
