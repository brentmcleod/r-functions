corr <- function(directory, threshold = 0){
## 'corr' returns a numeric vector showing the results of the 'cor' function... 
## ...applied to all csv files in the declared directory that have complete cases above the declared threshold
        
        ## 'directory' is a character vector of length 1 indicating the location of the CSV files
        
        ## 'threshold' is a numeric vector of length 1 indicating the number of complete observations
        ## (on all variables) required to compute the correlation between nitrate and sulfate;
        ## default is 0
        
        ## !!IMPORTANT!! -- Required packages will be installed; 
        ## this may take several minutes the first time this is run
        packages <- c("readr","dplyr", "magrittr")
        package.check <- lapply(packages, FUN = function(x) {
                if (!require(x, character.only = TRUE)) {
                        install.packages(x, dependencies = TRUE)
                        library(x, character.only = TRUE)
                }
        })
        
        ## Create a list of complete cases for all csv files in the directory above the threshold...
        idat <- complete(directory) %>%
                filter(nobs > threshold) %>%
                .[["id"]]
        
        ## Check that at least 1 or more files were above the threshold...
        if(length(idat) > 0){
                ## Read the csv files, run the 'cor' function and summarize in a numeric vector...
                paste0(directory, "/", sprintf("%03d",idat),".csv") %>%
                        lapply(read_csv, col_types = "Dddi") %>%
                        sapply( . %$% cor(sulfate, nitrate, use = "complete.obs"))
        }
        
        
}