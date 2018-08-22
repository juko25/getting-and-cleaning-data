library(dplyr)

#################################
#Step 1 - Download and Read Files
#################################

#Download Files

zipURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipName <- "UCI HAR Dataset.zip"
dirName <- "UCI HAR Dataset"

if(!file.exists(zipName)){
  download.file(zipURL,zipName, method="curl")
}

if(!file.exists(dirName)){
  unzip(zipName)
}

#Read Files -- Train Data
trainValues <- read.table(file.path(dirName, "train", "X_train.txt"))
trainActivity <- read.table(file.path(dirName, "train", "Y_train.txt"))
trainSubjects <- read.table(file.path(dirName, "train", "subject_train.txt"))

#Read Files -- Test Data
testValues <- read.table(file.path(dirName, "test", "X_test.txt"))
testActivity <- read.table(file.path(dirName, "test", "Y_test.txt"))
testSubjects <- read.table(file.path(dirName, "test", "subject_test.txt"))

#Read Files -- Activity Names
activityLabels <- read.table(file.path(dirName,"activity_labels.txt"))
colnames(activityLabels) <- c("activityID", "activityDescription")

#Read Files -- Features
features <- read.table(file.path(dirName, "features.txt"))
colnames(features) <- c("featureID", "feature")

#################################
#Step 2 - Merge Files
#################################

#Combine train and test data
dataSubjects <- rbind(trainSubjects, testSubjects)
dataActivity <- rbind(trainActivity, testActivity)
dataValues <- rbind(trainValues, testValues)

#Column Names
colnames(dataSubjects) <- c("Subject")
colnames(dataActivity) <- c("Activity")
colnames(dataValues) <- features$feature

#Merge dataSubjects, dataActivity, dataValues
data <- cbind(dataSubjects, dataActivity, dataValues)

#################################
#Step 3 - Extract Columns
#################################

data <- data[grepl("Subject|Activity|mean()|std()",colnames(data))]

#################################
#Step 4 - Descriptive Activity Names
#################################

data$Activity <- factor(data$Activity, levels = activityLabels$activityID, labels = activityLabels$activityDescription)

#################################
#Step 5 - Descriptive Variable Names
#################################

names(data) <- gsub("^t","Time",names(data))
names(data) <- gsub("^f","Frequency",names(data))
names(data) <- gsub("Gyro","Gyroscope",names(data))
names(data) <- gsub("Acc","Accelerometer",names(data))
names(data) <- gsub("Mag","Magnitude",names(data))
names(data) <- gsub("BodyBody","Body",names(data))

#################################
#Step 6 - Variable Averages by 
# Activity and Subject
#################################

#Compute
dataAverages <- aggregate(.~Subject+Activity,data=data, FUN = mean)

#Output
write.table(dataAverages, "tidyData.txt", row.names = FALSE)