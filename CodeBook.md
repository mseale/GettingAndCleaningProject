Code Book for Getting and Cleaning Data Project
========================================================
## Samsung accelerometer data
### Author:  mseale

## Study Design
This project produces a tidy data set from accelerometer data collected from the Samsung Galaxy S smartphone.

*The tidy data set is produced by the run_analysis.R script available from https://github.com/mseale/GettingAndCleaningProject*.

Data input files were downloaded manually from 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

and unzipped. The files from the data set used for this project, along with their original descriptions are:

* **from main folder**
    * activity_labels.txt: Links the class labels with their activity name.
    * features.txt:  List of all features.
* **from "test" folder**
    * subject_test.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
    * X_test.txt:  Test set.
    * Y_test.txt:  Test labels.
* **from "train" folder**
    * subject_train.txt:  Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
    * X_train.txt:  Training set.
    * Y_train.txt:  Training labels.
    
Descriptions for the original data files can be found at 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The subject\_test.txt and subject\_train.txt files contain one column of IDs for each of the study participants. These files were read into two separate data tables with a column name of "Subject.ID".

The features.txt file contains two columns, one representing the column ID for the actual data sets, and another with the associated feature name. The feature name column was read in with the name of "Feature" and was used as the column names for the X\_ data sets.

The activity\_labels.txt file contains the activity names for each of the codes, 1-6, used in the data sets. This file was read in and the activity code was used as the basis for a join with the Y\_ data sets, which contain a single column of values containing the coded activities. 

At this point, each of the training and testing datasets (subject\_, X\_ and Y\_) were united with a column bind operation to yield a single data set for each, consisting of the subject ID, the activity labels (codes were removed), and the 561 columns of feature data collected. The two data sets were then combined into a single data set by joining the rows together. This intermediate dataset is written out as ".\\totalData.txt" for potential future use.

From this intermediate data set, the feature columns related to mean and standard deviation values were extracted by using a regular expression to match "\*mean\*" and "\*std\*" in the column names. These selected columns were re-joined with the subject ID and activity name columns, which were excluded by the selection criteria. 

The mean for each activity and each subject is then computed. The column names are cleaned by removing extra periods, and are made more descriptive by replacing the original "t" with "time." and "f" with "freq." The feature column names also have ",GRPMEAN" added to each name to indicate the values now represent the averages over subject ID and activity.

*Please refer to the README.md file for details regarding system requirements and instructions for running the run_analysis.R script to produce the tidy data set described here.*

Details of each data variable in the tidy data set produced can be found in the **Code Book** section below.

## Code Book
The final tidy data set is saved in the user's working directory as finalTidyData.txt. It contains 180 rows and 88 columns of data. It can be read with the following R command (for a Windows platform):
```{r}
read.table(".\\finalTidyData.txt", header = TRUE)
```

A complete list of variable names by column number of the tidy data set is provided below.
### Variable Names
[1] Subject.ID         
    Identifies subject who performed the activity for each window sample; ranges from 1-30.
    
[2] Activity.Name  
     Identifies activity performed. Values are WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.

Each column of feature data (3:88) represents the mean value of the original variable, computed over subject and activity; this is indicated by each variable name ending in .GRPMEAN, to distinguish these values from the original input values. Details for the calculation/derivation of the original values can be found in the features_info.txt file of the data set available at the link provided in the **Study Design** section above.

Given that the original features were normalized and bounded between [-1, 1], the resulting means for the tidy data set also fall within this range.

For the feature variables in columns 3-88, the name components signify the following:
* **time**  -->features from the time domain
* **freq**  --> features from the frequency domain
* **angle** --> angle between two vectors
* **Body** --> body signals
* **Gravity** and **gravity**--> gravity signals
* **Acc** --> acceleration signals
* **Jerk** --> jerk signals obtained by deriving linear acceleration (for Acc) or angular velocity (for Gyro) signals in time
* **Gyro** --> angular velocity signals
* **Mag** --> the magnitude of 3-dimensional signals using the Euclidean norm
* **std** --> standard deviation
* **mean** --> mean value
* **meanfreq** --> weighted average of the frequency components to obtain a mean frequency
* **gravityMean** --> average of gravity signals in a window sample
* **X** --> signal in the X direction
* **Y** --> signal in the Y direction
* **Z** --> signal in the Z direction

    
 [3] time.BodyAcc.mean.X.GRPMEAN                
 [4] time.BodyAcc.mean.Y.GRPMEAN                
 [5] time.BodyAcc.mean.Z.GRPMEAN                
 [6] time.BodyAcc.std.X.GRPMEAN                 
 [7] time.BodyAcc.std.Y.GRPMEAN                 
 [8] time.BodyAcc.std.Z.GRPMEAN                 
 [9] time.GravityAcc.mean.X.GRPMEAN             
[10] time.GravityAcc.mean.Y.GRPMEAN             
[11] time.GravityAcc.mean.Z.GRPMEAN             
[12] time..std.X.GRPMEAN              
[13] time.GravityAcc.std.Y.GRPMEAN              
[14] time.GravityAcc.std.Z.GRPMEAN              
[15] time.BodyAccJerk.mean.X.GRPMEAN            
[16] time.BodyAccJerk.mean.Y.GRPMEAN            
[17] time.BodyAccJerk.mean.Z.GRPMEAN            
[18] time.BodyAccJerk.std.X.GRPMEAN             
[19] time.BodyAccJerk.std.Y.GRPMEAN             
[20] time.BodyAccJerk.std.Z.GRPMEAN             
[21] time.BodyGyro.mean.X.GRPMEAN               
[22] time.BodyGyro.mean.Y.GRPMEAN               
[23] time.BodyGyro.mean.Z.GRPMEAN               
[24] time.BodyGyro.std.X.GRPMEAN                
[25] time.BodyGyro.std.Y.GRPMEAN                
[26] time.BodyGyro.std.Z.GRPMEAN                
[27] time.BodyGyroJerk.mean.X.GRPMEAN           
[28] time.BodyGyroJerk.mean.Y.GRPMEAN           
[29] time.BodyGyroJerk.mean.Z.GRPMEAN           
[30] time.BodyGyroJerk.std.X.GRPMEAN            
[31] time.BodyGyroJerk.std.Y.GRPMEAN            
[32] time.BodyGyroJerk.std.Z.GRPMEAN            
[33] time.BodyAccMag.mean.GRPMEAN               
[34] time.BodyAccMag.std.GRPMEAN                
[35] time.GravityAccMag.mean.GRPMEAN            
[36] time.GravityAccMag.std.GRPMEAN             
[37] time.BodyAccJerkMag.mean.GRPMEAN           
[38] time.BodyAccJerkMag.std.GRPMEAN            
[39] time.BodyGyroMag.mean.GRPMEAN              
[40] time.BodyGyroMag.std.GRPMEAN               
[41] time.BodyGyroJerkMag.mean.GRPMEAN          
[42] time.BodyGyroJerkMag.std.GRPMEAN           
[43] freq.BodyAcc.mean.X.GRPMEAN                
[44] freq.BodyAcc.mean.Y.GRPMEAN                
[45] freq.BodyAcc.mean.Z.GRPMEAN                
[46] freq.BodyAcc.std.X.GRPMEAN                 
[47] freq.BodyAcc.std.Y.GRPMEAN                 
[48] freq.BodyAcc.std.Z.GRPMEAN                 
[49] freq.BodyAcc.meanFreq.X.GRPMEAN            
[50] freq.BodyAcc.meanFreq.Y.GRPMEAN            
[51] freq.BodyAcc.meanFreq.Z.GRPMEAN            
[52] freq.BodyAccJerk.mean.X.GRPMEAN            
[53] freq.BodyAccJerk.mean.Y.GRPMEAN            
[54] freq.BodyAccJerk.mean.Z.GRPMEAN            
[55] freq.BodyAccJerk.std.X.GRPMEAN             
[56] freq.BodyAccJerk.std.Y.GRPMEAN             
[57] freq.BodyAccJerk.std.Z.GRPMEAN             
[58] freq.BodyAccJerk.meanFreq.X.GRPMEAN        
[59] freq.BodyAccJerk.meanFreq.Y.GRPMEAN        
[60] freq.BodyAccJerk.meanFreq.Z.GRPMEAN        
[61] freq.BodyGyro.mean.X.GRPMEAN               
[62] freq.BodyGyro.mean.Y.GRPMEAN               
[63] freq.BodyGyro.mean.Z.GRPMEAN               
[64] freq.BodyGyro.std.X.GRPMEAN                
[65] freq.BodyGyro.std.Y.GRPMEAN                
[66] freq.BodyGyro.std.Z.GRPMEAN                
[67] freq.BodyGyro.meanFreq.X.GRPMEAN           
[68] freq.BodyGyro.meanFreq.Y.GRPMEAN           
[69] freq.BodyGyro.meanFreq.Z.GRPMEAN           
[70] freq.BodyAccMag.mean.GRPMEAN               
[71] freq.BodyAccMag.std.GRPMEAN                
[72] freq.BodyAccMag.meanFreq.GRPMEAN           
[73] freq.BodyBodyAccJerkMag.mean.GRPMEAN       
[74] freq.BodyBodyAccJerkMag.std.GRPMEAN        
[75] freq.BodyBodyAccJerkMag.meanFreq.GRPMEAN   
[76] freq.BodyBodyGyroMag.mean.GRPMEAN          
[77] freq.BodyBodyGyroMag.std.GRPMEAN           
[78] freq.BodyBodyGyroMag.meanFreq.GRPMEAN      
[79] freq.BodyBodyGyroJerkMag.mean.GRPMEAN      
[80] freq.BodyBodyGyroJerkMag.std.GRPMEAN       
[81] freq.BodyBodyGyroJerkMag.meanFreq.GRPMEAN  
[82] angle.tBodyAccMean.gravity.GRPMEAN         
[83] angle.tBodyAccJerkMean.gravityMean.GRPMEAN 

    [84] angle.tBodyGyroMean.gravityMean.GRPMEAN    
[85] angle.tBodyGyroJerkMean.gravityMean.GRPMEAN

    [86] angle.X.gravityMean.GRPMEAN                
[87] angle.Y.gravityMean.GRPMEAN                
[88] angle.Z.gravityMean.GRPMEAN 




