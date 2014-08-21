## Loads data from dataset downloaded to my working directory from
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Create table linking class labels with their activity name
activity_labels <- read.table("./proj_dataset/activity_labels.txt", colClasses = "character")
## Create table with list of all 561 features
features <- read.table("./proj_dataset/features.txt", colClasses = "character")

## Creates a table linking all the test subjects to the "test" set
subject_test <- read.table("./proj_dataset/test/subject_test.txt")
## Creates a table linking all the activities to the "test" set
y_test <- read.table("./proj_dataset/test/y_test.txt")
## Creates a table of all the test results in the "test" set
x_test <- read.table("./proj_dataset/test/X_test.txt")
                
## Creates a table linking all the test subjects to the "trial" set
subject_train <- read.table("./proj_dataset/train/subject_train.txt")
## Creates a table linking all the activities to the "trial" set
y_train <- read.table("./proj_dataset/train/y_train.txt")
## Creates a table of all the test results in the "trial" set
x_train <- read.table("./proj_dataset/train/X_train.txt")

## Merges all "test" tables together and deletes intermediate "test" tables
test_table <- cbind(subject_test, y_test, x_test)
subject_test <- NULL
y_test <- NULL
x_test <- NULL
## Merges all "train" tables together and deletes intermediate "train" tables
train_table <- cbind(subject_train, y_train, x_train)
subject_train <- NULL
y_train <- NULL
x_train <- NULL

## Creates master data table of "test" and "train" data
## and deletes intermediate "test" and "train" tables
master_data <- rbind(test_table, train_table)
test_table <- NULL
train_table <- NULL
## Creates descriptive variable names and delete feature table
colnames(master_data) <- c("Subject", "Activity", features[,2])
features <- NULL

## Keep only 'mean' and 'std deviation' measurements
mean_data <- master_data[,grep("mean()", colnames(master_data))]
std_data <- master_data[,grep("std()", colnames(master_data))]

## Create first tidy data set of all std and mean measurements
## and delete "master", "mean" and "std" tables
tidy_data1 <- cbind(mean_data, std_data)
tidy_data1 <- cbind(master_data[,1:2], tidy_data1)
master_data <- NULL
mean_data <- NULL
std_data <- NULL
## Create descriptive activity names and delete activity table
for (i in 1:nrow(tidy_data1)) {
        activity <- tidy_data1[i,2]
        tidy_data1[i,2] <- activity_labels[activity,2]
}
activity_labels <- NULL


## Create second tidy data set with the average of each variable
## for each activity and each subject and write it to a text file
tidy_data2 <- aggregate(tidy_data1[,3:81], by=tidy_data1[c("Subject", "Activity")],
        FUN=mean)
write.table(tidy_data2, file="tidy_data2.txt", sep=",", row.name=FALSE)