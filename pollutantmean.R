pollutantmean <- function(directory, pollutant, id = 1:332){
## 'pollutantmean' combines multiple csv files into one data frame and calculates the mean of the declared pollutant

        ## 'directory' is a character vector of length 1 indicating the location of the CSV files
        ## TIP: If you set the working directory to the parent directory where the CSV files are saved, 
        ## then you need only declare the directory name

        ## 'pollutant' is a character vector of length 1 indicating the name of the pollutant
        ## 'for which we will be calculating the mean; either 'sulfate' or 'nitrate'

        ## 'id' is an integer vector indicating the monitor ID numbers to be used
        
        ## !!IMPORTANT!! -- Required packages will be installed; 
        ## this may take several minutes the first time this is run
        packages <- c("readr","dplyr")
        package.check <- lapply(packages, FUN = function(x) {
                if (!require(x, character.only = TRUE)) {
                        install.packages(x, dependencies = TRUE)
                        library(x, character.only = TRUE)
                }
        })
        
        ## Create the data frame...
        df <- paste0(directory, "/", sprintf("%03d",id),".csv") %>%
                lapply(read_csv, col_types = "Dddi") %>%
                bind_rows
        
        ## Get the mean of the pollutant...
        mean(df[[pollutant]], na.rm = TRUE)
        
}