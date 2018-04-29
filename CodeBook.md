## Code Book

# Processing steps
The original test and tranining datasets were merged with their respective subject and activity tables
column names from features.txt were assigned to each data.frame
duplicate variables were removed
the train and test datasets were merged to a new data.frame 'mydata'
the variable mean and standard deviation values retained while all others were excluded
the activity column values were replaced with their character descriptions
finally a tidy data.frame is created that contains the mean of each varibles mean and standard deviation grouped by subject and activitiy

# mydata contains:
subject: subject ids - 1:30
activity: activities - "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"
followed by the mean and standard deviation values for:
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

Note, where -XYZ is writen these are in separate columns.

# tidy has teh same column headings as mydata
