library(dplyr)
library(data.table)
library(tidyverse)
rm(list=ls())
setwd("/Users/megan/Documents/UCI HAR Dataset/")

#####################################################################

###  1. Merges the training and the test sets to create one data set.

#####################################################################

#import test files
data_test = read.table("test/X_test.txt")
labels_test = read.table("test/Y_test.txt")
subject_test = read.table("test/subject_test.txt")

#import train files
data_train = read.table("train/X_train.txt")
labels_train = read.table("train/Y_train.txt")
subject_train = read.table("train/subject_train.txt")

#combine test and train into one dataset
data = rbind(data_test, data_train)
activity = rbind(labels_test, labels_train)
subject = rbind(subject_test,subject_train)

#set names of subject and activity columns and merge into one column
names(subject) = c("subject")
names(activity)= c("activity")
subj_active = cbind(subject,activity)


##############################################################################

###  2. Extracts only the measurements on the mean and sd for each measurement.

##############################################################################

#import data variable names and set them as the names of the data columns
features = read.table("features.txt")
names(data) = features$V2

#extract only mean and std columns
data_mean_std = data[,grepl("mean|std",names(data))]

#merge mean and std data with the subject and activity columns
data_merge = cbind(subj_active,data_mean_std)


##############################################################################

### 3. Use descriptive activity names to name the activities in the data set

##############################################################################

#import activity labels
activity_labels = read.table("activity_labels.txt")

#rename column one 
names(activity_labels)= c("activity", "activity_name")

#merge data with activity label names
data_labeled = full_join(data_merge,activity_labels) %>% 
  select(subject,activity,activity_name, everything())  #reorder the columns

##############################################################################

### 4. Appropriately labels the data set with descriptive variable names. 

##############################################################################

names(data_labeled)<-gsub("^t", "time", names(data_labeled))
names(data_labeled)<-gsub("^f", "frequency", names(data_labeled))
names(data_labeled)<-gsub("Acc", "Accelerometer", names(data_labeled))
names(data_labeled)<-gsub("Gyro", "Gyroscope", names(data_labeled))
names(data_labeled)<-gsub("Mag", "Magnitude", names(data_labeled))
names(data_labeled)<-gsub("BodyBody", "Body", names(data_labeled))

colnames(data_labeled)

##############################################################################

### 5. Average of each variable for each activity and each subject.

##############################################################################

data_summary = data_labeled %>% 
  select(-activity) %>% 
  group_by(subject, activity_name) %>% 
  dplyr::summarise_all(funs(mean))

write.table(data_summary, "run_analysis_final.txt", row.names = FALSE)
