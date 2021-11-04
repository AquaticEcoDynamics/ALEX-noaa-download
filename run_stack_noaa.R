# combine first cycle noaa forecasts as obs
#dates <- seq(lubridate::as_date("2021--19"), Sys.Date() - lubridate::days(1), by = "1 day")
#dates <- seq(lubridate::as_date("2021-10-15"), lubridate::as_date("2021-10-17"), by = "1 day")
library(tidyverse)
test_dir <- "/home/rstudio/"

#noaa_directory <- normalizePath(file.path(Sys.getenv("MINIO_HOME"), "drivers/noaa"))
noaa_directory <- normalizePath(file.path(test_dir, "drivers"))

#Read list of latitude and longitudes
neon_sites <- readr::read_csv("noaa_download_site_list.csv")

neon_sites <- neon_sites %>% 
  filter(site_id %in% c("fcre", "bvre", "ccre", "sunp", "feea"))

noaa_model <- "noaa/NOAAGEFS_6hr"
output_directory <- noaa_directory
model_name <- "observed-met-noaagefs"
#dates_w_errors <- c("2020-12-05","2020-12-06","2020-12-25")

site_start_date <- c(
  "2018-04-22",
  "2020-09-25",
  "2020-09-25",
  "2019-07-09",
  "2021-10-19"
)

dates_w_errors <- list(
  c("2020-10-26", "2020-12-05","2020-12-06","2020-12-11", "2020-12-25"),
  c("2020-10-26", "2020-12-05","2020-12-06", "2020-12-11", "2020-12-25"),
  c("2020-10-26", "2020-12-05", "2020-12-06", "2020-12-11", "2020-12-25"),
  c("2020-06-12", "2020-09-09", "2020-10-26", "2020-12-05","2020-12-06","2020-12-11", "2020-12-25"),
  c("2020-10-26", "2020-12-05", "2020-12-06", "2020-12-11", "2020-12-25"))




for(i in 1:length(neon_sites$site_id)){
  
  print(neon_sites$site_id[i])

  Rnoaa4cast::stack_noaa_forecasts(forecast_dates = seq(lubridate::as_date(site_start_date[i]), Sys.Date() - lubridate::days(1), by = "1 day"),
                       site = neon_sites$site_id[i],
                       noaa_directory = noaa_directory,
                       noaa_model = noaa_model,
                       output_directory = output_directory,
                       model_name = model_name,
                       dates_w_errors = lubridate::as_date(dates_w_errors[[i]]),
                       s3_mode = TRUE,
                       bucket = "drivers")
}

