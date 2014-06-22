README.md
========================================================
## run_analysis.R 
### Author:  mseale
## Description
This R script reads accelerometer data files collected from the Samsung Galaxy S smartphone. The separate files for training and testing data are merged into a single file, and columns related to the mean and standard deviation values are extracted. These values are averaged for activity and subject, and the resulting averages, along with the subject IDs and activity labels, are written to a tidy data file.The tidy data set is then ready for custom analysis by the user.

This script was written to satisfy the following requirements:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## System and Software Requirements
 This script was written for R 3.1.0, and was developed on a Windows 8.1 platform. If run on a non-Windows system, path assignments for files may need to be modified accordingly.

The following R packages are required: 
 * reshape2
 * plyr
 
These packages can be installed with the following R commands:
```{r}
install.packages("reshape2")
install.packages("plyr")
```
 
The input data files for the script are available from:

  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 
and are described here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

## Instructions
The zipped data file should be downloaded from the link given above to the desired local directory and unzipped.

After the files have been unzipped, place the run_analysis.R script in the same directory that contains the two subdirectories, "test" and "train". This directory should be set as the current working directory in R before running the script.
  
After setting the working directory, run the script by using:
```{r}
source("run_analysis.R")
```
Both the full, merged data file, totalData.txt, and the final tidy data output file, finalTidyData.txt, will be written to the current working directory.

*Please refer to the CodeBook.md file for details on the study design and variable descriptions for the tidy data set.*
## Program Details

The activity names are read from the activity_labels.txt file, and the feature names are read from the features.txt file. Next, the three data files for both the training set and test set are read in. Activity codes are replaced by the activity names. The three files for the test set are merged into one (totalTestData) and the three files for the training set are merged into one (totalTrainData). The combined test and training files are then merged into one complete file (totalData) and written to the working directory as totalData.txt for any possible future need. This merged data set contains 10,299 rows and 563 columns of data.

Next, all the columns related to mean and standard deviation values are selected by using a regular expression that matches with "mean" or "std" anywhere in a column name. The columns are then grouped by both subject ID and activity, and the mean for each of the other columns is computed.

Column names then undergo further processing to produce relevant, meaningful names. Processing performed includes
* removing extra periods in original names
* replacing "t" and "f" with the more meaningful "time." and "freq."
* adding ".GRPMEAN" to the ends of column names to denote that columns contain the group mean values.

This final tidy data set is then written to the working directory with the name, "finalTidyData.txt". This file contains 88 columns and 180 rows. The first row contains the column headers. The file can be read using the following statement (on a Windows platform):

```{r}
read.table(".\\finalTidyData.txt", header = TRUE)
```
Comments within the script explain each step of the process, should further clarification be needed.

## Source Repository
The code for run_analysis.R is available from https://github.com/mseale/GettingAndCleaningProject .

