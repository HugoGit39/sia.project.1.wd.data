########################################################################
# Read in raw data
#
# Stress in Action 2025
########################################################################

p_devices     <- here("data","raw","devices.xlsx")
p_signals     <- here("data","raw","signals.xlsx")
p_specs       <- here("data","raw","technical_specs.xlsx")
p_data_access <- here("data","raw","data_access.xlsx")
p_rvu         <- here("data","raw","rvu_synthesis.xlsx")
p_scores      <- here("data","raw","expert_scores.xlsx")

devices <- read_xlsx(p_devices) %>% clean_names()
signals_long <- read_xlsx(p_signals) %>% clean_names()
specs <- read_xlsx(p_specs) %>% clean_names()
data_access <- read_xlsx(p_data_access) %>% clean_names()
rvu <- read_xlsx(p_rvu) %>% clean_names()
scores <- read_xlsx(p_scores) %>% clean_names()