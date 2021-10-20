# combine first cycle noaa forecasts as obs
dates <- seq(lubridate::as_date("2021-10-15"), Sys.Date() - lubridate::days(1), by = "1 day")
#dates <- seq(lubridate::as_date("2021-10-15"), lubridate::as_date("2021-10-17"), by = "1 day")

test_dir <- "/Users/quinn/workfiles/Research/SSC_forecasting/automation_test/"

#noaa_directory <- normalizePath(file.path(Sys.getenv("MINIO_HOME"), "drivers/noaa"))
noaa_directory <- normalizePath(file.path(test_dir, "drivers/noaa"))

#Read list of latitude and longitudes
neon_sites <- readr::read_csv("noaa_download_site_list.csv")

noaa_model <- "NOAAGEFS_6hr"
output_directory <- noaa_directory
model_name <- "observed-met-noaagefs"
dates_w_errors <- c("2020-12-05","2020-12-06","2020-12-25")

for(i in 1:length(neon_sites$site_id)){
  
  print(neon_sites$site_id[i])

  noaaGEFSpoint::stack_noaa_forecasts(forecast_dates = dates,
                       site = neon_sites$site_id[i],
                       noaa_directory = noaa_directory,
                       noaa_model = noaa_model,
                       output_directory = output_directory,
                       model_name = model_name,
                       dates_w_errors = dates_w_errors)
}

