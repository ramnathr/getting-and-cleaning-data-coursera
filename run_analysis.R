library(dplyr)

setwd("UCI HAR Dataset/")

# Read in column labels
f <- read.table("features.txt")

# Clean up the feature names
f.1 <- gsub("\\()", "Fct", f$V2)
f.1 <- gsub(",", "_To_", f.1)
f.1 <- gsub("-", "_", f.1)
f.1[555] <- "angleOf_tBodyAccMean_And_gravity"
f.1[556] <- "angleOf_tBodyAccJerkMean_And_gravityMean"
f.1[557] <- "angleOf_tBodyGyroMean_And_gravityMean"
f.1[558] <- "angleOf_tBodyGyroJerkMean_And_gravityMean"
f.1[559] <- "angleOf_X_And_gravityMean"
f.1[560] <- "angleOf_Y_And_gravityMean"
f.1[561] <- "angleOf_Z_And_gravityMean"

# Read in test data set
setwd("test/")
s <- read.table("subject_test.txt")
colnames(s) <- "SubjectID"
x <- read.table("X_test.txt")
colnames(x) <- f.1
y <- read.table("y_test.txt")
colnames(y) <- "ActivityID"

testData <- data.frame(c(s,y,x))

# Read in training data set
setwd("../train/")
s <- read.table("subject_train.txt")
colnames(s) <- "SubjectID"
x <- read.table("X_train.txt")
colnames(x) <- f.1
y <- read.table("y_train.txt")
colnames(y) <- "ActivityID"

trainData <- data.frame(c(s,y,x))

totalData <- rbind(testData, trainData)

# Extract the required standard deviation and mean data
meanTotalData <- totalData[,grep('mean', names(totalData))]
stdTotalData <- totalData[,grep('std', names(totalData))]
stdMeanData <- cbind(totalData$SubjectID, totalData$ActivityID, meanTotalData, stdTotalData)
colnames(stdMeanData)[1] <- "SubjectID"
colnames(stdMeanData)[2] <- "ActivityName"


# Rename the activity IDs to activity names
stdMeanData$ActivityName <- gsub("1", "WALKING", stdMeanData$ActivityName)
stdMeanData$ActivityName <- gsub("2", "WALKING_UPSTAIRS", stdMeanData$ActivityName)
stdMeanData$ActivityName <- gsub("3", "WALKING_DOWNSTAIRS", stdMeanData$ActivityName)
stdMeanData$ActivityName <- gsub("4", "SITTING", stdMeanData$ActivityName)
stdMeanData$ActivityName <- gsub("5", "STANDING", stdMeanData$ActivityName)
stdMeanData$ActivityName <- gsub("6", "LAYING", stdMeanData$ActivityName)

# Compute mean for each subject and activity
tmp <- group_by(stdMeanData, SubjectID, ActivityName)
summarizedData <- summarise_each(tmp, funs(mean))
