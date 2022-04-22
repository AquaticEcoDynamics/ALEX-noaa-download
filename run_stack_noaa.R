library(tidyverse)
test_dir <- here::here()

noaa_directory <- normalizePath(file.path(test_dir, "drivers"))

#Read list of latitude and longitudes
neon_sites <- readr::read_csv("noaa_download_site_list.csv")

#neon_sites <- neon_sites %>% 
#  filter(site_id %in% c("fcre", "bvre", "ccre", "sunp", "feea"))

noaa_model <- "noaa/NOAAGEFS_6hr"
output_directory <- noaa_directory
model_name <- "observed-met-noaagefs"
#dates_w_errors <- c("2020-12-05","2020-12-06","2020-12-25")

site_start_date <- c(
  "2020-09-25", #BARC
  "2020-01-28", #CRAM
  "2020-09-25",  #LIRO
  "2020-09-25", #PRPL
  "2020-03-03", #PRPO
  "2019-07-09", #SUGG
  "2020-03-03", #TOOL
  "2018-04-22", #fcre
  "2020-09-25", #bvre
  "2020-09-25", #ccre
  "2019-07-09", #sunp
  "2021-10-19" #feea
)

dates_w_errors <- list(
  c("2020-10-26", "2020-12-05","2020-12-06", "2020-12-11", "2020-12-25"), #BARC
  c("2020-10-26", "2020-12-05","2020-12-06", "2020-12-11", "2020-12-25"), #CRAM
  c("2020-10-26", "2020-12-05","2020-12-06", "2020-12-11", "2020-12-25"), #LIRO
  c("2020-10-26", "2020-12-05","2020-12-06", "2020-12-11", "2020-12-25"), #PRLA
  c("2020-10-26", "2020-12-05","2020-12-06", "2020-12-11", "2020-12-25"), #PRPO
  c("2020-06-22", "2020-10-26", "2020-12-05","2020-12-06", "2020-12-11", "2020-12-25"), #SUGG
  c("2020-10-26", "2020-12-05","2020-12-06", "2020-12-11", "2020-12-25"), #TOOL
  c("2020-10-26", "2020-12-05","2020-12-06","2020-12-11", "2020-12-25"), #fcre
  c("2020-10-26", "2020-12-05","2020-12-06", "2020-12-11", "2020-12-25"), #bvre
  c("2020-10-26", "2020-12-05", "2020-12-06", "2020-12-11", "2020-12-25"), #ccre
  c("2020-06-12", "2020-09-09", "2020-10-26", "2020-12-05","2020-12-06","2020-12-11", "2020-12-25"), #sunp
  c("2020-10-26", "2020-12-05", "2020-12-06", "2020-12-11", "2020-12-25")) #feea




for(i in 1:length(neon_sites$site_id)){
  
  print(neon_sites$site_id[i])

  Rnoaa4cast::stack_noaa_forecasts(forecast_dates = seq(lubridate::as_date(site_start_date[i]), Sys.Date() - lubridate::days(1), by = "1 day"),
                       site = neon_sites$site_id[i],
                       noaa_directory = noaa_directory,
                       noaa_model = noaa_model,
                       output_directory = output_directory,
                       model_name = model_name,
                       dates_w_errors = lubridate::as_date(dates_w_errors[[i]]),
                       s3_mode = FALSE,
                       bucket = "drivers",
                       verbose = TRUE)
  
  stack_file_name <- file.path(noaa_directory,"noaa", "NOAAGEFS_1hr_stacked_avarage", neon_sites$site_id[i], paste0("observed-met-noaa_",neon_sites$site_id[i], ".nc"))
  
  if(!dir.exists(dirname(stack_file_name))){
    dir.create(dirname(stack_file_name), recursive = TRUE)
  }
  
  Rnoaa4cast::average_stacked_forecasts(forecast_dates = seq(lubridate::as_date(site_start_date[i]), Sys.Date() - lubridate::days(1), by = "1 day"), # cycle through historical dates
                            noaa_stacked_directory = file.path(noaa_directory, "noaa", "NOAAGEFS_1hr_stacked", neon_sites$site_id[i]),
                            output_file = stack_file_name)
  
}

