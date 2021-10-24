


test_dir <- "/home/rstudio"
output_directory <- normalizePath(file.path(test_dir, "drivers"))
config_file <- yaml::read_yaml("noaa_download_scale_config.yml")

#Read list of latitude and longitudes
neon_sites <- readr::read_csv(config_file$site_file)
site_list <- neon_sites$site_id
lat_list <- neon_sites$latitude
lon_list <- neon_sites$longitude

Rnoaa4cast::noaa_gefs_grid_download(lat_list = lat_list,
                                    lon_list = lon_list,
                                    forecast_time = NA,
                                    forecast_date = NA,
                                    model_name_raw = "noaa/NOAAGEFS_raw",
                                    output_directory = output_directory,
                                    grid_name = "flare",
                                    s3_mode = TRUE,
                                    bucket = "drivers")

