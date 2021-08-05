all_files <- list.files("/efi_neon_challenge/drivers/noaa/NOAAGEFS_6hr/", full.names = TRUE, recursive = TRUE)

for(i in 1:length(all_files)){
  print(i)
  output_file <- stringr::str_replace_all(all_files[i], pattern = "6hr", replacement = "1hr")
  noaaGEFSpoint::temporal_downscale(input_file = all_files[i], output_file = output_file )
}