## source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## - 'features_info.txt': Shows information about the variables used on the feature vector.
## - 'features.txt': List of all features.
## - 'activity_labels.txt': Links the class labels with their activity name.
## - 'train/X_train.txt': Training set.
## - 'train/y_train.txt': Training labels.
## - 'test/X_test.txt': Test set.
## - 'test/y_test.txt': Test labels.

## Download complete dataset and Unzip
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
unzip(temp,exdir="projectData")
unlink(temp)


## Merges the training and the test sets to create one data set.
## read data from each table
xtrainData <- read.table("projectData/UCI HAR Dataset/train/X_train.txt")
ytrainData <- read.table("projectData/UCI HAR Dataset/train/y_train.txt", col.names="activity")
subjecttrainData <- read.table("projectData/UCI HAR Dataset/train/subject_train.txt", col.names="subject")
xtestData <- read.table("projectData/UCI HAR Dataset/test/X_test.txt")
ytestData <- read.table("projectData/UCI HAR Dataset/test/y_test.txt", col.names="activity")
subjecttestData <- read.table("projectData/UCI HAR Dataset/test/subject_test.txt", col.names="subject")
## Join x tain and test tables, join y train and test tables and join subject test and train tables
xjoinData <- rbind(xtrainData, xtestData)
yjoinData <- rbind(ytrainData, ytestData)
subjectjoinData <- rbind(subjecttrainData, subjecttestData)


## Extracts only the measurements on the mean and standard deviation for each measurement. 
## read the features table in
features <- read.table("projectData/UCI HAR Dataset/features.txt")

## from the features_info.txt file
## mean(): Mean value
## std(): Standard deviation
## meanData <- grep("mean()", features[, 2])
## stdData <- grep("std()", features[,2])
meanstdData <- grep("mean|std", features[,2])
## only the rows we want
features2<- features[meanstdData,]
## subjectjoinData <- cbind(subjectjoinData[, ], features)


## Uses descriptive activity names to name the activities in the data set
activityData<-read.table("projectData/UCI HAR Dataset/activity_labels.txt")
activityData[,2]<-gsub("_", " ", activityData[, 2])
yjoinData[, 1] <- activityData[yjoinData[, 1], 2]


##Appropriately labels the data set with descriptive variable names. 
othrNames <- features2[,2]
othrNames = gsub('-mean', 'Mean', othrNames)
othrNames = gsub('-std', 'Std', othrNames)
othrNames = gsub('[-()]', '', othrNames)
xjoinData<- xjoinData[, meanstdData]
colnames(xjoinData) <- othrNames
finalData<- cbind( yjoinData, subjectjoinData, xjoinData)


## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
newData <- aggregate(finalData[,-(1:2)], by=list(activity=finalData$activity, subject=finalData$subject), mean)
write.table(newData, "newData.txt", row.names=FALSE, sep="\t")
