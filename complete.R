complete <- function(directory, id = 1:332){
## 'complete' returns a dataframe summarising the number of complete observations in each of the declared csv files
        
        ## 'directory' is a character vector of length 1 indicating the location of the CSV files
        ## TIP: If you set the working directory to the parent directory where the CSV files are saved, 
        ## then you need only declare the directory name
        
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
        
        ## Sum the number of complete observations in each CSV file...
        paste0(directory, "/", sprintf("%03d",id),".csv") %>%
        lapply(read_csv, col_types = "Dddi") %>%
        lapply(complete.cases) %>%
        sapply(sum) %>%
        data.frame("id" = id, "nobs" = .)
        
}