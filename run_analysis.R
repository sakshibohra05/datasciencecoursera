#required library

library(dplyr)
#extracting data into variables
feature <- read.table("features.txt", col.names = c("number","features"))
activities <- read.table("activity_labels.txt", col.names = c("num", "activity"))


#testing data 
subject_test <- read.table("test/subject_test.txt", col.names = "subject")
x_test <- read.table("test/X_test.txt", col.names = feature$features)
y_test <- read.table("test/Y_test.txt", col.names = "num")
y_test_label <- left_join(y_test, activities, by = "num")

tidy_test <- cbind(subject_test, y_test_label, x_test)
tidy_test <- select(tidy_test, -label)


#training data
subject_train <- read.table("train/subject_train.txt", col.names = "subject")
x_train <- read.table("train/X_train.txt", col.names = feature$features)
y_train <- read.table("train/Y_train.txt", col.names = "num")
y_train_label <- left_join(y_train, activities, by = "num")

tidy_train <- cbind(subject_train, y_train_label, x_train)
tidy_train <- select(tidy_train, -label)


# combine test and train data set
tidy_set <- rbind(tidy_test, tidy_train)

# Extract mean and standard deviation
tidy_mean_std <- select(tidy_set, contains("mean"), contains("std"))

# Averanging all variable by each subject each activity
tidy_mean_std$subject <- as.factor(tidy_set$subject)
tidy_mean_std$activity <- as.factor(tidy_set$activity)

tidy_avg <- tidy_mean_std %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))
#creating a file to sotre tidy data
write.table(tidy_avg, "tidydata.txt", row.name=FALSE)
