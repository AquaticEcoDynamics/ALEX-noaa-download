library(cronR)
home_dir <- here::here()

cmd <- cronR::cron_rscript(rscript = file.path(home_dir, "download_grid.R"),
                           rscript_log = file.path(home_dir, "noaa_gef_download.log"),
                           log_append = FALSE,
                           workdir = file.path(home_dir))
cronR::cron_add(command = cmd, frequency = '0 */3 * * *', id = 'noaa_download')

cmd <- cronR::cron_rscript(rscript = file.path(home_dir, "process_grid.R"),
                           rscript_log = file.path(home_dir, "noaa_gef_process.log"),
                           log_append = FALSE,
                           workdir = file.path(home_dir))
cronR::cron_add(command = cmd, frequency = '0 */4 * * *', id = 'noaa_process')

cmd <- cronR::cron_rscript(rscript = file.path(home_dir, "run_stack_noaa.R"),
                           rscript_log = file.path(home_dir, "noaa_stack.log"),
                           log_append = FALSE,
                           workdir = file.path(home_dir))
cronR::cron_add(command = cmd, frequency = 'daily', at = "6 am", id = 'noaa_stack')

