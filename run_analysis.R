
library(data.table)

## read in the test data
## X_test.txt contains the actual data
## y_test.txt contians the activity labels for the data 
## subject_train.txt contains the subjects - people participating per observation
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
test_label <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
## read in the training data
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
train_label <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
## read in the features that contains all the variables being measured
features <- read.table("UCI HAR Dataset/features.txt")
## read in the activity labels
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

## merge the test and training data
all_data <- rbind(test_data,train_data)
## merge the labels (activity columns)
all_labels <- rbind(test_label,train_label)
## merge the subjects
all_subjects <- rbind(test_subject,train_subject)

## name the combined dataset
features[,2] <- as.character(features[,2])
names(all_data) <- features[,2]

## remove the unnecessary columns - note we only keep the mean and sd vars
features_mean_sd <- grep("mean|std",features[,2],value = TRUE)
mean_sd_data <- all_data[,features_mean_sd]

## update the activities to be descriptive (remove underscores)
activities$V2 <- gsub("_"," ",activities$V2)
activities_factored <- factor(all_labels$V1,levels = activities[,1],labels = activities[,2])

## Now add the subject and activity data to the dataset
complete_data <- cbind(all_subjects,activities_factored,mean_sd_data)
## update the name of the activity column
colnames(complete_data)[2] <- "activity"
## name the subject column
colnames(complete_data)[1] <- "subject"

## create a data table for better subsetting using "by"
table_complete_data <- data.table(complete_data)

## calculate the mean (average) for each subject per activity
mean_table_complete_data <- table_complete_data[, lapply(.SD, mean), by=c("subject", "activity")]

## save this data set to a file
write.table(mean_table_complete_data, "tidy_data.txt")
