library(arlodr)

library(dplyr, warn.conflicts=FALSE)
library(readr, warn.conflicts=FALSE)


# update this file path to point toward appropriate folder on your computer
folder <- "input_data/T100_D_MARKET_US_CARRIER_ONLY_DATA"      
file_list <- list.files(path=folder) 
file_list



# loop that was useful in troubleshooting
# for (i in 1:length(file_list)) {
#   print(i)
# a <- read_excel(paste(folder, "//", file_list[i], sep=''), sheet = 2, skip=0, 
#                 col_names = FALSE)
# print(head(a, 10))
# }


# try one file first
#a <- read_csv(paste0(folder,"/", "108396627_T_T100D_MARKET_US_CARRIER_ONLY_2016.csv"), col_names = TRUE)

# read in each file in file_list and rbind them into a data frame called data 
# used this as a model
#http://reed.edu/data-at-reed/resources/R/read_and_summarize_multiple_txt.html
data <- NULL
data <- 
  do.call("rbind", 
          lapply(file_list, 
                 function(x) 
                   read_csv(paste0(folder, "/", x), skip=0, 
                              col_names = TRUE))) 

colnames(data) <- tolower(colnames(data))


data <- data %>%
  # drop any columns that are all na
  Filter(function(x)!all(is.na(x)), .) %>%
  # convert to data frame tbl (better printing on screen)
  tbl_df()

print(data)
summary(data)

t100d_uscar <- data

save(t100d_uscar, file="output_data/t100d_uscar.Rdata")

