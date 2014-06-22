# Getting and Cleaning Data
# Project script by mseale
# run_analysis.R

# IMPORTANT--This script should be placed in the directory that contains
# the "test" and "train" sub-folders. That directory should then be set
# as the working directory in R.

# IMPORTANT--The following libraries must be installed in R.

# Import libraries
library(reshape2)
library(plyr)

# Set the file names according to the current working directory.
subjTrainFile <- ".\\train\\subject_train.txt"
xTrainFile <- ".\\train\\X_train.txt"
yTrainFile <- ".\\train\\y_train.txt"
subjTestFile <- ".\\test\\subject_test.txt"
xTestFile <- ".\\test\\X_test.txt"
yTestFile <- ".\\test\\y_test.txt"
featureNamesFile <- ".\\features.txt"
activityLabelsFile <- ".\\activity_labels.txt"

# Read in the feature names and activity labels files,
# setting descriptive column names for each.
featureNames <- read.table(featureNamesFile, col.names = c("ColNum", "Feature"))
activityLabels <- read.table(activityLabelsFile, col.names = c("Activity.Code", "Activity.Name"))


# Read in the three testing files, 
# setting descriptive column names for each.
subjTestData <- read.table(subjTestFile, col.names = c("Subject.ID"))
xTestData <- read.table(xTestFile, col.names = featureNames$Feature)
yTestData <- read.table(yTestFile, col.names = c("Activity.Code"))


# Read in the three training files, 
# setting descriptive column names for each,
# that match the names for the testing data files.
subjTrainData <- read.table(subjTrainFile, col.names = c("Subject.ID"))
xTrainData <-  read.table(xTrainFile, col.names = featureNames$Feature)
yTrainData <- read.table(yTrainFile, col.names = c("Activity.Code"))


# Associate the activity codes in the Y datasets with the descriptive names
# from the activity labels data for both the training and testing data.
yTrainDataNames <- join(yTrainData, activityLabels)
yTrainDataNames <- data.frame(Activity.Name = yTrainDataNames[,"Activity.Name"])

yTestDataNames <- join(yTestData, activityLabels)
yTestDataNames <- data.frame(Activity.Name = yTestDataNames[,"Activity.Name"])


# Combine the training and testing datasets into one each by binding columns
totalTrainData <- cbind(subjTrainData, 
                        yTrainDataNames, xTrainData)
totalTestData <- cbind(subjTestData, 
                        yTestDataNames, xTestData)


# Now, combine the two training and testing datasets into one by binding rows
totalData <- rbind(totalTrainData, totalTestData)
# End of merging data files

# Save the merged data to a file for possible future use.
write.table(totalData, file = ".\\totalData.txt")

# End of first dataset.

#--------------------------------------------
# Begin creation of final tidy dataset.

# Extract only the mean and standard deviation columns for the measurement values.
# Selection is based on the substrings "mean" and "std" occurring in
# any part of the feature name.
stdMeanData <- totalData[, grepl("*mean*", colnames(totalData), 
                                 ignore.case = TRUE) |
                                 grepl("*std*", colnames(totalData), 
                                       ignore.case = TRUE)]

# Re-join the features with the subject ID and activity columns.
tidyDataOne <- cbind(stdMeanData, subset(totalData, 
                                         select = c(Subject.ID, Activity.Name)))

# Group data by subject and activity and compute
# the mean over the feature columns (1:86 of 88--not including
# the subject ID and activity columns).
finalTidy <- ddply(tidyDataOne, .(Subject.ID, Activity.Name),
             colwise(mean, .cols = c(1:86)))

# Clean up feature column names.
# First, remove extra periods in original names.
cleanNames <- gsub("\\.{2,3}", "\\.", colnames(finalTidy)[3:88])

# Remove any trailing periods
cleanNames <- gsub("\\.$", "", cleanNames)

# Replace "t" and "f" with more descriptive "time." and "freq.".
cleanNames <- gsub("^t", "time\\.", cleanNames)
cleanNames <- gsub("^f", "freq\\.", cleanNames)

# Add ".GRPMEAN" at end of each column name to indicate 
# the values are the grouped means.
cleanNames <- gsub("$", "\\.GRPMEAN", cleanNames)

# Replace the original column names with the new ones,
# and add back in the subject ID and activity names.
colnames(finalTidy) <- c(colnames(finalTidy)[1:2], cleanNames)

# Write the final tidy data set.
write.table(finalTidy, file = ".\\finalTidyData.txt")
