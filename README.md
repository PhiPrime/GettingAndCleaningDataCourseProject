# GettingAndCleaningDataCourseProject
## Luke Coughlin

The purpose of this project is to demonstrate my ability to collect, work with, 
and clean a data set. This is done with the *Human Activity Recognition* 
*Using Smartphones Dataset*.

More info on source dataset: 
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

This project includes:
* *UCI HAR Dataset* - Directory that is the source of data that is analyzed  
* *CodeBook.md* - A Codebook describing the variables that are in the output 
                        file, *UCI_HAR_Dataset_Summary.csv*.  
* *LICENSE* - A standard MIT License for this project  
* *README.md* - this document  
* *UCI_HAR_Dataset_Summary.txt* - the output when *run_analysis.R* is executed  
* *run_analysis.R* - performs the following steps:
        0) 
                * Check for UCI directory & create path names
                * Load plyr & dplyr packages
                * Load in the "train" and the "test" data sets  
                
        1) Merge the training and the test sets to create one data set.  
        2) Extract only the measurements on the mean and standard deviation 
                for each measurement.  
        3) Use descriptive activity names to name the activities in the data set  
        4) Appropriately label the data set with descriptive variable names.  
        5) From the data set in step 4, create a second, 
                independent tidy data set with the average of each variable
                for each activity and each subject.

Reference for dataset:
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass
Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
