run_analysis <- function() {
##Step 0.1: Configure working directory

        #Check for UCI directory
        if (!dir.exists("UCI HAR Dataset")) {
                stop('UCI HAR Dataset not found')
        }

        #Save Paths
        testDir  <- paste0(getwd(), "/UCI HAR Dataset/test")
        trainDir <- paste0(getwd(), "/UCI HAR Dataset/train")

##Step 0.2: Load in the "train" and the "test" data sets

        #Returns names of Inertial folder files
        getInertialPaths <- function(dir) {
                paths <- dir(paste0(dir, "/Inertial Signals"),
                             pattern = "\\.txt", full.names = TRUE)

                #Remove ".txt" from names
                splitNames <- strsplit(basename(paths), "\\.")
                names(paths) <- sapply(splitNames, function(x){x[[1]]})
                paths
        }

        #Handling files outside of Inertial folder
        getFixedVars <- function(dir) {


                paths <- dir(dir, pattern = "\\.txt", full.names = TRUE)

                #Remove time and frequency domain variables
                paths <- paths[-grep("^[X]", basename(paths))]

                #Read in remaining files
                data <- sapply(paths, read.table)

                rawFixed <- data.frame(subject_id = data[[1]],
                                       activity_id = data[[2]])

                #Create a row for each type of inertial observation
                inertialObservationNames <- names(getInertialPaths(dir))

                library(dplyr)
                compiledFixed <- slice(rawFixed,
                                   rep(1:nrow(rawFixed),
                                       times = length(inertialObservationNames)))

                #Return data.frame of variables
                data.frame(compiledFixed,
                           observation_type = rep(inertialObservationNames,
                                                  each = nrow(rawFixed)))

        }

        #Handling files in Inertial folder
        getMeasuredVars <- function(dir) {

                paths <- getInertialPaths(dir)

                getObservation <- function(rownum) {
                        sapply(paths, read.table,
                               skip = (rownum - 1), nrows = 1)
                }


                # library(plyr)
                data <- ldply(paths, read.table, stringsAsFactors = FALSE)
                data[,2:length(data[1,])]

        }


        #Build data.frames with prior functions for test & train
        testData <-  data.frame(getFixedVars(testDir),
                               getMeasuredVars(testDir))

        trainData <- data.frame(getFixedVars(trainDir),
                                getMeasuredVars(trainDir))


##Step 1: Merge the training and the test sets to create one data set.


##Step 2: Extract only the measurements on the mean and
##              standard deviation for each measurement.


##Step 3: Use descriptive activity names to name the activities in the data set


##Step 4: Appropriately label the data set with descriptive variable names.


##Step 5: From the data set in step 4, create a second,
##              independent tidy data set with the average of each variable
##              for each activity and each subject.

}

boi <- run_analysis()
