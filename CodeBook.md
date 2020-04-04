# Code Book 
## PhiPrime/GettingAndCleaningDataCourseProject

* *group* - Indicates what experiment group the subject participated in  
        + test  
        + train  
        
* *subject_id* - a number to identify the subject  
        + Range of 1 to 30  
        
* *activity* - indicates which activity the subject performed  
        + LAYING  
        + SITTING  
        + STANDING  
        + WALKING  
        + WALKING_DOWNSTAIRS  
        + WALKING_UPSTAIRS  
        
* *observation_type* - indicates the type of measurement separated by axis  
        + body_acc - The body acceleration signal obtained by subtracting 
                the gravity from the total acceleration.  
                * body_acc_x  
                * body_acc_y  
                * body_acc_z  
        + body_gyro - The angular velocity vector measured by the gyroscope 
                for each window sample. The units are radians/second.        
                * body_gyro_x  
                * body_gyro_y  
                * body_gyro_z  
        + total_acc - The acceleration signal from the smartphone accelerometer      
                * total_acc_x  
                * total_acc_y  
                * total_acc_z  
                
* *mean* -      mean of all observations of same 
                subject_id, activity, and observation_type
                
* *mean_of_sd* - mean of standard deviations of each observation 
                        per 128 measurement readings
