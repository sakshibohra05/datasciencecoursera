library(dplyr)
#extracting data into variables

features <- read.table("C:/Users/sakshi/Documents/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("C:/Users/sakshi/Documents/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("C:/Users/sakshi/Documents/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("C:/Users/sakshi/Documents/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("C:/Users/sakshi/Documents/UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("C:/Users/sakshi/Documents/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("C:/Users/sakshi/Documents/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("C:/Users/sakshi/Documents/UCI HAR Dataset/train/y_train.txt", col.names = "code")

#merging data 

x1 <- rbind(x_train, x_test)
y1 <- rbind(y_train, y_test)
Subject_merge <- rbind(subject_train, subject_test)
Merged <- cbind(Subject_merge, y1, x1)

#extracting required set of data

tidy_set <- Merged %>% select(subject, code, contains("mean"), contains("std"))

