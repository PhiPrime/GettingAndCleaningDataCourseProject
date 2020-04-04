run_analysis <- function() {
##Step 0.1: Check for UCI directory & create path names

        #Check for UCI directory
        if (!dir.exists("UCI HAR Dataset")) {
                stop('UCI HAR Dataset not found')
        }

        #Save Paths
        testDir  <- paste0(getwd(), "/UCI HAR Dataset/test")
        trainDir <- paste0(getwd(), "/UCI HAR Dataset/train")

##Step 0.2: Load plyr & dplyr packages
        library(plyr)
        library(dplyr)

##Step 0.3: Load in the "train" and the "test" data sets

        #This function returns the names of Inertial folder files
        getInertialPaths <- function(dir) {
                paths <- dir(paste0(dir, "/Inertial Signals"),
                             pattern = "\\.txt", full.names = TRUE)

                #Remove ".txt" from names
                splitNames <- strsplit(basename(paths), "\\.")
                names(paths) <- sapply(splitNames, function(x){x[[1]]})
                paths
        }

        #This function handles files outside of Inertial folder
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

                compiledFixed <- slice(rawFixed,
                                   rep(1:nrow(rawFixed),
                                       times = length(inertialObservationNames)))

                observation_type <-  rep(inertialObservationNames,
                                       each = nrow(rawFixed))

                #split variable for observation and test/train group
                splitNames <- strsplit(sub("_[t]", ".t", observation_type)
                                       , "\\.")

                observation_type <- sapply(splitNames, function(x){x[[1]]})
                group <- sapply(splitNames, function(x){x[[2]]})

                #Return data.frame of variables
                data.frame(group,
                           compiledFixed,
                           observation_type)

        }

        #This function handles files in Inertial folder
        getMeasuredVars <- function(dir) {

                paths <- getInertialPaths(dir)
                data <- ldply(paths, read.table, stringsAsFactors = FALSE)

                #Remove filename label since getFixedVars() includes it
                data[,2:length(data[1,])]
        }


        #Build data.frames with prior functions for test & train
        testData <-  data.frame(getFixedVars(testDir),
                               getMeasuredVars(testDir))

        trainData <- data.frame(getFixedVars(trainDir),
                                getMeasuredVars(trainDir))


##Step 1: Merge the training and the test sets to create one data set.

        mergedData <- arrange(rbind(testData,trainData),
                              subject_id, activity_id)
        mergedData


##Step 2: Extract only the measurements on the mean and
##              standard deviation for each measurement.

        means <-  sapply(1:length(mergedData[,1]),
                         function(x){mean(
                                 as.numeric(as.character(
                                         mergedData[x,5:length(mergedData[1,])]
                                         )))})
        stdDevs <- sapply(1:length(mergedData[,1]),
                          function(x){sd(
                                  as.numeric(as.character(
                                          mergedData[x,5:length(mergedData[1,])]
                                  )))})
        consolidatedData <- data.frame(mergedData[,1:4], #1:4 are the fixed vars
                                       mean = means,
                                       standard_deviation = stdDevs)


##Step 3: Use descriptive activity names to name the activities in the data set

        #Uses activity_labels file for descriptions of activity_id
        activityDir <- paste0(getwd(), "/UCI HAR Dataset/activity_labels.txt")
        activityLabels <- read.table(activityDir)
        consolidatedData <- mutate(consolidatedData,
                             activity_id = activityLabels[activity_id,2])


##Step 4: Appropriately label the data set with descriptive variable names.

        ##consolidatedData currently has colNames:
        ##      group, subject_id, activity_id, observation_type, mean,
        ##                                      & standard_deviation
        ##Since activity_id is now the name of an activity that's the
        ##only one that needs renamed

        consolidatedData <- rename(consolidatedData, c("activity_id" = "activity"))


##Step 5: From the data set in step 4, create a second,
##              independent tidy data set with the average of each variable
##              for each activity and each subject.

        summary <- consolidatedData %>%
                ddply(.(group, subject_id, activity, observation_type),
                      summarize,
                      mean = mean(mean), mean_of_sd = mean(standard_deviation))

        write.table(summary, "./UCI_HAR_Dataset_Summary.txt", row.names = FALSE)
}
run_analysis()
