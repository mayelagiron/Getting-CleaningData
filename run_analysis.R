library(plyr)

# Step 1
# Create 1 data set by merging training and test set of data
#////////////////////////////////////////////////////////////////////////////////

xTrain <- read.table("train/xTrain.txt")
yTrain <- read.table("train/yTrain.txt")
subjectTrain <- read.table("train/subjectTrain.txt")

xTest <- read.table("test/xTest.txt")
yTest <- read.table("test/yTest.txt")
subjectTest <- read.table("test/subjectTest.txt")

# ///create 'X' ////////
xData <- rbind(xTrain, xTest)

# ///create 'Y' ////////
yData <- rbind(yTrain, yTest)

# ///create 'SUBJECT' //////
subjectData <- rbind(subjectTrain, subjectTest)

# Step 2
# Select from data the ones which have mean and std deviation
#////////////////////////////////////////////////////////////////////////////////

features <- read.table("features.txt")

mean_std_fts <- grep("-(mean|std)\\(\\)", features[, 2])

xData <- xData[, mean_std_fts]

names(xData) <- features[mean_std_fts, 2]

# Step 3
# Change the activities names 
#////////////////////////////////////////////////////////////////////////////////

activities <- read.table("activity_labels.txt")

# update with correct activity names
yData[, 1] <- activities[yData[, 1], 2]

# correct column name
names(yData) <- "activity"

# Step 4
# Change the labels of the data set with descriptive variable names
#////////////////////////////////////////////////////////////////////////////////

names(subjectData) <- "subject"

allData <- cbind(xData, yData, subjectData)

# Step 5
# Generate the output with the tidy dataset
#////////////////////////////////////////////////////////////////////////////////

averageData <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averageData, "averageData.txt", row.name=FALSE)