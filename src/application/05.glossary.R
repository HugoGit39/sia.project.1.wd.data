########################################################################
# Glossary (GLOS)
#
# Purpose:
#   Central glossary for the Stress in Action Wearables App.
#   Contains definitions and abbreviations for all variables,
#   signals, and parameters shown in tables and filters.
#
# Structure:
#   GLOS <- list(A = div(...), B = div(...), ... Z = div(...))
#   Each letter groups terms alphabetically for Shiny rendering.
#
# Usage:
#   - Displayed via “Table Information” buttons and glossary modals.
#   - Loaded in global.R as:
#         GLOS <- readRDS("data/GLOS.rds")
#
# Notes:
#   - Stored separately as data/GLOS.rds to keep global.R compact.
#   - Updated when new variables or signals are added.
#
# Stress in Action 2025
########################################################################

glos <- list(

  A = div(style = "font-size:16px", align = "justify",
          p(strong("ACC — Acceleration"), br(),
            "Acceleration measured by an accelerometer."),
          p(strong("Accelerometer"), br(),
            "Sensor that measures acceleration in multiple axes to detect motion and posture."),
          p(strong("Activity Detection"), br(),
            "Automatic detection of walking, running or other activities."),
          p(strong("Activity metrics"), br(),
            "Various metrics derived from accelerometer signals indicating activity levels."),
          p(strong("Additional software"), br(),
            "Additional software available (e.g., for analysis purposes)."),
          p(strong("Afib — Atrial fibrillation"), br(),
            "Detection or recording of atrial fibrillation episodes."),
          p(strong("Alpha 1 / Alpha 2"), br(),
            "Purified trend fluctuations (short- and long-term scales) used in HRV analysis."),
          p(strong("ApEn — Approximate Entropy"), br(),
            "Measure of heart-rate-variability signal complexity.")
  ),

  B = div(style = "font-size:16px", align = "justify",
          p(strong("Battery life"), br(),
            "Maximum battery life (in hours) as specified by the manufacturer. Note: enabling detailed recording (e.g., continuous EDA or raw data) can significantly reduce it."),
          p(strong("Bio-cueing"), br(),
            "Options to cue users based on their physiology (e.g., vibrations, stress notifications, sound alerts)."),
          p(strong("Bio-feedback"), br(),
            "Information provided to users about their physiology (e.g., via device display)."),
          p(strong("Body Battery daily summary"), br(),
            "Daily summary providing insight into stress and recovery balance."),
          p(strong("BP — Blood Pressure"), br(),
            "Blood pressure measurement."),
          p(strong("BP (mean) — Mean Blood Pressure"), br(),
            "Average arterial pressure within a cardiac cycle."),
          p(strong("BPV — Blood Pressure Variability"), br(),
            "Variation in blood pressure over time."),
          p(strong("BVP — Blood Volume Pulse"), br(),
            "PPG-derived waveform reflecting blood-volume changes."),
          p(strong("BRS — Baroreflex Sensitivity"), br(),
            "Relationship between changes in blood pressure and heart rate.")
  ),

  C = div(style = "font-size:16px", align = "justify",
          p(strong("Calories"), br(),
            "Total energy expenditure (calories burned)."),
          p(strong("CE approval/label"), br(),
            "Device assessed to meet EU market regulations. CE marking is required for official EU sales."),
          p(strong("Charging duration"), br(),
            "Time (in minutes) required for a full battery charge."),
          p(strong("Charging method"), br(),
            "Method used to recharge the device’s battery."),
          p(strong("Compatibility"), br(),
            "System compatibility of the device (mobile and/or computer)."),
          p(strong("CO — Cardiac Output"), br(),
            "Volume of blood pumped by the heart per minute."),
          p(strong("Core body temp — Core body temperature"), br(),
            "Internal body temperature."),
          p(strong("CwK — Total Arterial Compliance"), br(),
            "Index of arterial elasticity.")
  ),

  D = div(style = "font-size:16px", align = "justify",
          p(strong("D1 — Beat-to-beat variability"), br(),
            "Standard deviation of instantaneous beat-to-beat intervals."),
          p(strong("Data transfer method"), br(),
            "All methods of transferring data from the device to a computer or mobile phone."),
          p(strong("DBP — Diastolic Blood Pressure"), br(),
            "Minimum arterial pressure during relaxation of the heart."),
          p(strong("DFA α1"), br(),
            "Detrended fluctuation analysis index of short-term HRV."),
          p(strong("Device name"), br(),
            "Name of the device."),
          p(strong("Device costs"), br(),
            "One-time purchase price and any additional costs (e.g., subscription, required software, discounts)."),
          p(strong("Device storage capacity"), br(),
            "Internal recording capacity (hours/size). Maximum values are reported; may vary with sampling frequency."),
          p(strong("Dividers/Notes"), br(), "—"),
          p(strong("dp/dt"), br(),
            "Maximum steepness of the upstroke in pressure or impedance signals."),
          p(strong("dZ/dt"), br(),
            "Derivative of the impedance signal (ICG).")
  ),

  E = div(style = "font-size:16px", align = "justify",
          p(strong("ECG — Electrocardiogram"), br(),
            "Electrical recording of heart activity."),
          p(strong("ECG-Q"), br(),
            "Q-wave of the ECG complex."),
          p(strong("EDA — Electrodermal Activity"), br(),
            "Also known as Galvanic Skin Response."),
          p(strong("EDL — Electrodermal level"), br(),
            "Absolute level of skin conductance."),
          p(strong("ΔEDL — Change in EDL"), br(),
            "Variation in electrodermal level."),
          p(strong("EE — Energy Expenditure"), br(),
            "Total energy burned during activity."),
          p(strong("EMG — Electromyography"), br(),
            "Electrical activity of muscles."),
          p(strong("EOG — Electrooculogram"), br(),
            "Eye-movement potential used for sleep or alertness detection.")
  ),

  F = div(style = "font-size:16px", align = "justify",
          p(strong("FDA approval/clearance"), br(),
            "Device or components have been FDA-approved or cleared.")
  ),

  G = div(style = "font-size:16px", align = "justify",
          p(strong("GDPR compliance"), br(),
            "Compliance with the General Data Protection Regulation Act. Researchers must determine the final verdict."),
          p(strong("General usability synthesis"), br(),
            "Summary of usability outcomes including user experience and adherence."),
          p(strong("General validity and reliability synthesis"), br(),
            "Summary of validity and reliability outcomes across parameters."),
          p(strong("GPS — Global Positioning System"), br(),
            "Satellite-based location tracking."),
          p(strong("Gyroscope"), br(),
            "Sensor measuring angular velocity; often combined with an accelerometer in an IMU.")
  ),

  H = div(style = "font-size:16px", align = "justify",
          p(strong("HF — High-frequency power"), br(),
            "Parasympathetic HRV spectral component (0.15–0.4 Hz)."),
          p(strong("Highest level of validation evidence"), br(),
            "External > Internal > No validation."),
          p(strong("HMI — Hip Motion Intensity"), br(),
            "Derived measure of motion intensity."),
          p(strong("HP — Heart Period"), br(),
            "Interval between consecutive heartbeats."),
          p(strong("HR — Heart Rate"), br(),
            "Beats per minute derived from ECG or PPG."),
          p(strong("HR pause"), br(),
            "Defined pause of heartbeats (≥ 3 s)."),
          p(strong("HR zones"), br(),
            "Standardized intensity ranges based on % HR max."),
          p(strong("HRV — Heart Rate Variability"), br(),
            "Variability in time intervals between heartbeats."),
          p(strong("Hyperlink to the device RVU page"), br(),
            "Link to the device’s RVU sheet using the device name as display text.")
  ),

  I = div(style = "font-size:16px", align = "justify",
          p(strong("IBI — Interbeat Interval"), br(),
            "Time between consecutive heartbeats (ms)."),
          p(strong("IC — Inspiratory Capacity"), br(),
            "Maximum air volume inhaled after normal exhalation."),
          p(strong("ICG — Impedance Cardiography"), br(),
            "Technique to measure thoracic impedance for cardiac parameters."),
          p(strong("ICG-B / C / X points"), br(),
            "Key fiducial points on the ICG waveform."),
          p(strong("Internal storage method"), br(),
            "Availability and method of internal data storage."),
          p(strong("IRV — Inspiratory Reserve Volume"), br(),
            "Additional inhalable air after normal inspiration.")
  ),

  J = div(style = "font-size:16px", align = "justify", p("")),
  K = div(style = "font-size:16px", align = "justify", p("")),

  L = div(style = "font-size:16px", align = "justify",
          p(strong("Last updated"), br(),
            "Date on which the device information was last updated."),
          p(strong("LF — Low-frequency power"), br(),
            "HRV spectral component (0.04–0.15 Hz)."),
          p(strong("Location"), br(),
            "Where the device is worn (e.g., wrist, chest). May differ from recording location."),
          p(strong("LVET — Left Ventricular Ejection Time"), br(),
            "Duration of left-ventricular blood ejection.")
  ),
  M = div(style = "font-size:16px", align = "justify",
          p(strong("Main use"), br(),
            "Primary intended setting the device was developed for (usually derived from website/manual or intended use statement)."),
          p(strong("Manufacturer"), br(),
            "Name of the manufacturer."),
          p(strong("MAP — Mean Arterial Blood Pressure"), br(),
            "Average arterial pressure during a single cardiac cycle."),
          p(strong("Market status"), br(),
            "Current — available for purchase; Discontinued — no longer sold/supported; Upcoming — soon to be available."),
          p(strong("Menstrual cycle tracking"), br(),
            "Tracks menstrual cycle phase, cycle length and related logs."),
          p(strong("Most recent date of RVU search"), br(),
            "Date of the most recent RVU search for a device.")
  ),

  N = div(style = "font-size:16px", align = "justify",
          p(strong("NIBP — Non-invasive Blood Pressure"), br(),
            "Blood pressure measured without arterial catheterization."),
          p(strong("NS-SCRs — Non-Specific Skin Conductance Responses"), br(),
            "Skin conductance responses not tied to identifiable discrete stimuli."),
          p(strong("Number of usability studies reviewed"), br(),
            "Number of usability studies included in the device review (use 0 if none)."),
          p(strong("Number of validity and reliability studies reviewed"), br(),
            "Total number of all validity, reliability and usability studies included in the device review.")
  ),

  O = div(style = "font-size:16px", align = "justify",
          p(strong("On other signals"), br(),
            "Free-text notes on ‘other signals’."),
          p(strong("Other signals"), br(),
            "All other signals the device can record that are not listed explicitly elsewhere; separate entries with ‘;’."),
          p(strong("Oxygen saturation — SpO2"), br(),
            "Percentage of oxygen-saturated hemoglobin in the blood.")
  ),

  P = div(style = "font-size:16px", align = "justify",
          p(strong("%BF — Percentage Body Fat"), br(),
            "Proportion of body mass that is fat, expressed as a percentage."),
          p(strong("% HR max"), br(),
            "Current heart rate expressed as a percentage of maximum heart rate."),
          p(strong("% HR at anaerobic threshold"), br(),
            "Current heart rate expressed as a percentage of heart rate at anaerobic threshold."),
          p(strong("%MM — Percentage Muscle Mass"), br(),
            "Proportion of body mass that is muscle, expressed as a percentage."),
          p(strong("% Recovery"), br(),
            "Percentage estimate of how recovered the body is and how ‘ready’ it is for performance."),
          p(strong("Parameter sampling window"), br(),
            "Time window over which each parameter is calculated (can range, e.g., from 1 minute to 1 day)."),
          p(strong("PEP — Pre-Ejection Period"), br(),
            "Time interval between electrical activation of the heart and the opening of the aortic valve."),
          p(strong("PP — Pulse Pressure"), br(),
            "Difference between systolic and diastolic blood pressure (mmHg)."),
          p(strong("PPG — Photoplethysmography"), br(),
            "Optical technique used to record blood volume changes in the microvascular bed."),
          p(strong("Provided parameters"), br(),
            "All processed data that can be exported for analysis. Beware that systems may filter or average over large time windows; always check computation details before use."),
          p(strong("PS*HR — Rate Pressure Product"), br(),
            "Product of systolic blood pressure and heart rate, used as an index of myocardial oxygen demand."),
          p(strong("PTT — Pulse Transit Time"), br(),
            "Time taken for the arterial pulse wave to travel between two points in the arterial tree.")
  ),

  Q = div(style = "font-size:16px", align = "justify",
          p(strong("QRS"), br(),
            "Duration of the QRS complex in the ECG (time from Q peak to S peak)."),
          p(strong("QT"), br(),
            "Duration between the Q and T peaks of the ECG (Q-peak to T-peak)."),
          p(strong("QTc — Corrected QT"), br(),
            "QT interval corrected for heart rate.")
  ),

  R = div(style = "font-size:16px", align = "justify",
          p(strong("Raw data available"), br(),
            "Indicates whether signal-level data can be recorded and exported for analysis."),
          p(strong("Recovery time"), br(),
            "Estimate of the time remaining before the user is fully recovered and ready for the next intense workout."),
          p(strong("Release date"), br(),
            "Official market release date of the device."),
          p(strong("REM — Rapid Eye Movement"), br(),
            "REM sleep stage characterized by rapid eye movements and vivid dreaming."),
          p(strong("Resp — Respiration / Respiratory signal"), br(),
            "Respiration signal; includes how respiration is derived (e.g., via ICG or PPG; specify under method)."),
          p(strong("Respiration"), br(),
            "Respiration and how it is derived (e.g., via ICG or PPG; specify under method)."),
          p(strong("Required software"), br(),
            "Software required to record data and/or extract it from the device."),
          p(strong("RMSSD — Root Mean Square of Successive RR Interval Differences"), br(),
            "Time-domain HRV metric reflecting short-term variability."),
          p(strong("RR — Respiratory Rate"), br(),
            "Number of breaths per minute."),
          p(strong("RR rest"), br(),
            "Respiratory rate at rest (breaths per minute)."),
          p(strong("RR tri"), br(),
            "Integral of the RR interval histogram divided by its maximum height."),
          p(strong("RSA — Respiratory Sinus Arrhythmia"), br(),
            "Cyclic variation in heart rate modulated by breathing."),
          p(strong("RVU — Related fields"), br(),
            "Other related fields or domains relevant to the device.")
  ),

  S = div(style = "font-size:16px", align = "justify",
          p(strong("SampEn — Sample Entropy"), br(),
            "Nonlinear HRV index of signal irregularity."),
          p(strong("SBP — Systolic Blood Pressure"), br(),
            "Maximum arterial pressure during heart contraction (mmHg)."),
          p(strong("SCL — Skin Conductance Level"), br(),
            "Tonic level of skin conductance."),
          p(strong("SCR-AMP — Skin Conductance Response Amplitude"), br(),
            "Amplitude of individual skin conductance responses."),
          p(strong("SCRs — Skin Conductance Responses"), br(),
            "Phasic changes in skin conductance in response to stimuli or internal states."),
          p(strong("SD1"), br(),
            "Short-term HRV variability component (ms)."),
          p(strong("SD1UP"), br(),
            "Short-term accelerations in heart rate (ms)."),
          p(strong("SD1DOWN"), br(),
            "Short-term decelerations in heart rate (ms)."),
          p(strong("SD2"), br(),
            "Long-term HRV variability component (ms)."),
          p(strong("SD2/SD1"), br(),
            "Ratio of long-term to short-term HRV variability."),
          p(strong("SDNN — Standard Deviation of NN intervals"), br(),
            "Standard deviation of normal-to-normal (NN) intervals."),
          p(strong("SDRR"), br(),
            "Standard deviation of RR intervals (ECG) or interbeat intervals (PPG) in ms."),
          p(strong("Server data storage"), br(),
            "Data stored on external servers (including location). Often requires direct inquiry to clarify."),
          p(strong("SiA long-term usefulness score"), br(),
            "Average perceived usefulness for long-term SiA studies (assessed by three authors)."),
          p(strong("SiA short-term usefulness score"), br(),
            "Average perceived usefulness for short-term SiA studies (assessed by three authors)."),
          p(strong("Size"), br(),
            "Device dimensions (mm): Length × Width × Height, or Diameter × Height for round devices. Rings use US ring sizes (e.g., 4–10)."),
          p(strong("Skin Temp — Skin Temperature"), br(),
            "Skin temperature at the measurement site."),
          p(strong("SpO2 — Oxygen Saturation"), br(),
            "Estimated arterial oxygen saturation (%)."),
          p(strong("Steps"), br(),
            "Number of steps taken."),
          p(strong("Studied parameters"), br(),
            "List of parameters included in all reviewed studies for the device."),
          p(strong("Support notes"), br(),
            "Additional support-related notes or clarifications."),
          p(strong("SV — Stroke Volume"), br(),
            "Volume of blood ejected by the heart per beat.")
  ),

  T = div(style = "font-size:16px", align = "justify",
          p(strong("tachycardia"), br(),
            "Accelerated heart rate (e.g., onset/offset beats ≥ 16, HR ≥ 140 bpm)."),
          p(strong("TP — Total Power"), br(),
            "Total power of the HRV spectrum."),
          p(strong("TPR — Total Peripheral Resistance"), br(),
            "Resistance offered by the systemic vasculature."),
          p(strong("TWA — T-wave Amplitude"), br(),
            "Amplitude of the T-wave in the ECG."),
          p(strong("Data transfer method"), br(),
            "All methods of transferring data from device to computer or phone."),
          p(strong("Water resistance (see also ‘Testing standards’)"), br(),
            "Water resistance in meters and minutes. Different naming standards exist (ATM, ISO, IEC). Values are standardized to meters/minutes. Note that ATM-to-meter depth is based on static pressure; real-world dynamic pressure (e.g., swimming) can exceed ratings (e.g., 3 ATM = 30 m = splash only).")
  ),

  U = div(style = "font-size:16px", align = "justify",
          p(strong("ULF — Ultra-Low Frequency Power"), br(),
            "Very-low-frequency component of HRV over long recording windows."),
          p(strong("General usability synthesis"), br(),
            "Short synthesis of usability results, including adherence.")
  ),

  V = div(style = "font-size:16px", align = "justify",
          p(strong("Validation — Highest level of validation evidence"), br(),
            "Highest level of validation available: external > internal > no validation."),
          p(strong("VLF — Very-Low Frequency Power"), br(),
            "HRV spectral component below ~0.04 Hz."),
          p(strong("VM — Minute Ventilation"), br(),
            "Volume of air breathed in or out per minute."),
          p(strong("VO2max"), br(),
            "Maximum oxygen volume (ml/min/kg) consumed at maximal performance."),
          p(strong("VPBs — Ventricular Premature Beats"), br(),
            "Premature beats originating in the ventricles."),
          p(strong("VT — Tidal Volume"), br(),
            "Air volume inhaled or exhaled during normal breathing.")
  ),

  W = div(style = "font-size:16px", align = "justify",
          p(strong("Wearable type"), br(),
            "Type of device (e.g., watch, CPU + electrodes). New types can be added if needed."),
          p(strong("Website"), br(),
            "Link to the device webpage."),
          p(strong("Weight"), br(),
            "Device weight (grams), rounded to whole numbers."),
          p(strong("Water resistance"), br(),
            "See also ‘T — Water resistance’ for detailed explanation.")
  ),

  X = div(style = "font-size:16px", align = "justify", p("")),

  Y = div(style = "font-size:16px", align = "justify", p("")),

  Z = div(style = "font-size:16px", align = "justify",
          p(strong("Zao — Ascending Aortic Impedance"), br(),
            "Impedance in the ascending aorta."),
          p(strong("Z0 — Cardiac Impedance Signal"), br(),
            "Baseline thoracic impedance signal used in ICG.")
  )
)

saveRDS(glos, file = "glos.rds")




df_codebook <- map_dfr(names(glos), function(letter) {
  html_text <- glos[[letter]] %>%
    as.character() %>%
    read_html() %>%
    html_nodes("p") %>%
    html_text(trim = TRUE)
  
  if (length(html_text) == 0) {
    return(data.frame(Letter = letter, Term = NA_character_))
  }
  
  data.frame(
    Letter = letter,
    Term   = html_text,
    stringsAsFactors = FALSE
  )
})

saveRDS(df_codebook, file = "df_codebook.rds")

