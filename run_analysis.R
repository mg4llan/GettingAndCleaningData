#The purpose of this script is to load and tidy accelerometer data from smart phones

#Load test data
testData <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="")
testLabels <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, sep="")
testSubjects <-read.table("./UCI HAR Dataset/test/subject_test.txt")

#Load training data
trainData <- read.csv("./UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="")
trainLabels <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, sep="")
trainSubjects <-read.table("./UCI HAR Dataset/train/subject_train.txt")

#Load features file
features <- read.table("./UCI HAR Dataset/features.txt")

#Merge data sets
mergedData <- rbind(testData, trainData)
mergedLabels <- rbind(testLabels, trainLabels)
mergedSubjects <- rbind(testSubjects, trainSubjects)

#Apply column names
names(mergedData) <- features[,2]
names(mergedLabels) <- "Activity"
names(mergedSubjects) <- "SubjectId"

#Combine data with labels and subjects
mergedData <- cbind(mergedSubjects, mergedData)
mergedData <- cbind(mergedLabels, mergedData)

#Apply activity labels
mergedData[,1] <- cut(mergedData[,1], 6,
                      labels=c("Walking", "Walking Upstairs",
                               "Walking Downstairs", "Sitting",
                               "Standing", "Laying"))

#Extract only measurements for mean and standard deviation
tidyData <- mergedData[, c(1, 2, grep("mean()|meanFreq()|std()", names(mergedData)))]

#Tidy up column names by capitalizing, removing dashes and parentheses
names(tidyData) <- gsub("mean", "Mean", names(tidyData))
names(tidyData) <- gsub("std", "Std", names(tidyData))
names(tidyData) <- gsub("\\(", "", names(tidyData))
names(tidyData) <- gsub("\\)", "", names(tidyData))
names(tidyData) <- gsub("-", "", names(tidyData))

#Create dataset of averages for each variable grouped by activity and subject
tidyAvg <- aggregate(tidyData[,3:(ncol(tidyData)-2)], by=list(activity=tidyData$Activity, 
                                       subjectId=tidyData$SubjectId), 
                     FUN=mean)

#Write the tidy averages to a file
write.table(tidyAvg, "tidyAvg.txt", row.names = FALSE)