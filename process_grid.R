test_dir <- here::here()
output_directory <- normalizePath(file.path(test_dir, "drivers"))
config_file <- yaml::read_yaml("noaa_download_scale_config.yml")

#Read list of latitude and longitudes
neon_sites <- readr::read_csv(config_file$site_file)
site_list <- neon_sites$site_id
lat_list <- neon_sites$latitude
lon_list <- neon_sites$longitude

Rnoaa4cast::noaa_gefs_grid_process_downscale(lat_list = lat_list,
                                             lon_list = lon_list,
                                             site_list = site_list,
                                             downscale = TRUE,
                                             debias = FALSE,
                                             overwrite = TRUE,
                                             model_name = "noaa/NOAAGEFS_6hr",
                                             model_name_ds = "noaa/NOAAGEFS_1hr",
                                             model_name_ds_debias = "noaa/NOAAGEFS_1hr-debias",
                                             model_name_raw = "noaa/NOAAGEFS_raw",
                                             debias_coefficients = NA,
                                             num_cores = 1,
                                             output_directory = output_directory,
                                             reprocess = FALSE,
                                             write_intermediate_ncdf = TRUE,
                                             process_specific_date =  NA,
                                             process_specific_cycle = NA,
                                             delete_bad_files = TRUE,
                                             grid_name = "aed",
                                             s3_mode = FALSE,
                                             bucket = "drivers")
