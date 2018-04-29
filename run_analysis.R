
source("downloadFile.R")
library(dplyr)
library(tidyr)
library(reshape2)

fileList <- c("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
outFileList <- paste0("./data/",basename(fileList))
# Download zip file
downloadFile(fileList)

# Unzip file if not already done 
root <- "./UCI HAR Dataset"
if(!file.exists(root)) {
    print("Unzipping contents")
    unzip(outFileList)
}

# Read in feature names, test an train processed data and subject indentifiers
features <- read.table(paste0(root,"/features.txt"),as.is = TRUE)
activities <- read.table(paste0(root,"/activity_labels.txt"))
activities <- factor(activities$V1,activities$V2,ordered = TRUE)

if(!exists("testsubactx")) {
    print("reading in and combining test data")
    testx <- read.table(paste0(root,"/test/X_test.txt"))
    testsub <- read.table(paste0(root,"/test/subject_test.txt"))
    testact <- read.table(paste0(root,"/test/y_test.txt"),colClasses = "factor")
    testsubactx <- cbind(testsub,testact,testx)
    rm("testx","testsub","testact")
}
if(!exists("trainsubactx")) {
    print("reading in and combining training data")
    trainx <- read.table(paste0(root,"/train/X_train.txt"))
    trainsub <- read.table(paste0(root,"/train/subject_train.txt"))
    trainact <- read.table(paste0(root,"/train/y_train.txt"),colClasses = "factor")
    trainsubactx <- cbind(trainsub,trainact,trainx)
    rm("trainx","trainsub","trainact")
}

# Assign column names
names(testsubactx) <- c("subject","activity",features$V2)
names(trainsubactx) <- c("subject","activity",features$V2)

# remove duplicates (whihc here are not the data we dont need)
testsubactx2 <- testsubactx[,!duplicated(names(testsubactx)),drop=TRUE]
trainsubactx2 <- trainsubactx[,!duplicated(names(trainsubactx)),drop=TRUE]

## Merge test and training data to my_data
mydata <- tbl_df(rbind(trainsubactx2, testsubactx2))

# assign levels to activity
levels(mydata$activity)<-levels(activities)

# select subject, activity, and proceesed data means and stddevs
# transform activity to chr of activitiy 
mydata %>%
    select(subject,activity,contains("mean()"),contains("std()")) %>%
    mutate(activity=levels(mydata$activity)[as.numeric(mydata$activity)]) ->
    mydata
    
# mydata_summary <- mydata %>%
#     group_by(subject,activity) %>%
#     summarise(mean(c(`tBodyAcc-mean()-X`,`tBodyAcc-mean()-Y`))) %>%
#     print()
    
tidy <- recast(mydata, subject+activity ~ variable, mean, id.var = c("subject", "activity"))

# id_var <- c("subject","activity")
# melted <- melt(mydata, id=id_var)
# tidy <- dcast(melted, subject+activity ~ variable, mean)
