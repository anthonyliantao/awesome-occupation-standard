# This script extracts and cleans CFPS occupational codes from year 10 - 22.
# It handles conflicts in labels across different years.

library(tidyverse)

# Function to extract codes from CFPS dta files
extract_code <- function(file_path, var_name, from, write = FALSE, output_dir = NULL) {
  data <- haven::read_dta(file_path)
  codes <- attr(data[[var_name]], "labels")
  code_df <- data.frame(code = codes, title = names(codes), from = from)
  if (write) {
    if (is.null(output_dir)) {
      stop("Output directory must be specified if write is TRUE.")
    }
    output_file <- paste0(output_dir, '/', from, ".csv")
    readr::write_csv(code_df, file = output_file)
  }
  return(code_df)
}

# Extract codes of CFPS for each year and save to CSV files
# Users should specify the correct file paths for their data files.
cfps10 <- extract_code("/Volumes/APFS/DataHub/CFPS/cfps2010adult.dta", "qg307code", "cfps10")
cfps12 <- extract_code("/Volumes/APFS/DataHub/CFPS/cfps2012adult.dta", "job2012mn_occu","cfps12")
cfps14 <- extract_code("/Volumes/APFS/DataHub/CFPS/cfps2014adult.dta", "qg303code", "cfps14")
cfps16 <- extract_code("/Volumes/APFS/DataHub/CFPS/cfps2016adult.dta", "qg303code", "cfps16")
cfps18 <- extract_code("/Volumes/APFS/DataHub/CFPS/cfps2018adult.dta", "qg303code", "cfps18")
cfps20 <- extract_code("/Volumes/APFS/DataHub/CFPS/cfps2020adult.dta", "qg303code", "cfps20")
cfps22 <- extract_code("/Volumes/APFS/DataHub/CFPS/cfps2022adult.dta", "qg303code", "cfps22")

# Combine years and check confilicts
cfps_all <- rbind(cfps10, cfps12, cfps14, cfps16, cfps18, cfps20, cfps22) %>%
  group_by(code, title) %>%
  summarise(
    from = paste(unique(from), collapse = ", "),
    .groups = "drop"
  ) %>%
  group_by(code) %>%
  mutate(has_conflict = n() > 1) %>%
  ungroup() %>%
  select(code, title, from, has_conflict)

readr::write_csv(cfps_all, file = "CFPS/cfps_10-22_raw.csv")

# Handle conflicts and clean up the data
cfps_clean <- cfps_all %>%
  mutate(
    title = case_when(
      code == 61509 ~ "其他木材加工、人造板生产、木制品制作及制浆、造纸和纸制品生产加工人员",
      code == 61500 ~ "木材加工、人造板生产、木制品制作及制浆、造纸和纸制品生产加工人员",
      code == 61209 ~ "其他粮油、食品、饮料生产加工及饲料生产加工人员",
      code == 61200 ~ "粮油、食品、饮料生产加工及饲料生产加工人员",
      code == 60800 ~ "电子元器件与设备制造、装配、调试及维修人员",
      code == 60200 ~ "金属冶炼、轧制人员",
      code == 60100 ~ "勘测及矿物开采人员",
      code == 10302 ~ "工会、共青团、妇联、其他人民团体及其工作机构负责人",
      TRUE ~ title
    ),
  ) %>%
  group_by(code, title) %>%
  summarise(code = unique(code), title = unique(title), .groups = "drop")

readr::write_csv(cfps_clean, file = "CFPS/cfps_10-22_clean.csv")
