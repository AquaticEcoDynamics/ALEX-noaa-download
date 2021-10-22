remotes::install_github("rqthomas/cronR")
#remotes::install_deps()
library(cronR)

home_dir <- "/home/rstudio/neon4cast-noaa-download"

cmd <- cronR::cron_rscript(rscript = file.path(home_dir, "launch_download_downscale.R"),
                           rscript_log = file.path(home_dir, "noaa_gef.log"),
                           log_append = FALSE,
                           workdir = file.path(home_dir))
#trailing_arg = "curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/cb249e47-f56b-45da-af7f-9c0c47db1a6c")
cronR::cron_add(command = cmd, frequency = '0 */4 * * *', id = 'noaa_download')

#cmd <- cronR::cron_rscript(rscript = file.path(home_dir, "run_stack_noaa.R"),
#                           rscript_log = file.path(home_dir, "noaa_stack.log"),
#                           log_append = FALSE,
#                           workdir = file.path(home_dir))
#trailing_arg = "curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/cb249e47-f56b-45da-af7f-9c0c47db1a6c")
#cronR::cron_add(command = cmd, frequency = 'daily', at = "6 am", id = 'noaa_stack')

