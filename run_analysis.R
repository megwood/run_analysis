library(dplyr)
library(data.table)
library(tidyverse)
rm(list=ls())
setwd("/Users/megan/Documents/UCI HAR Dataset/")

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

#set names of subject and activity columns
names(subject) = c("subject")
names(labels)= c("activity")

#import data variable names and set them as the names of the data columns
features = read.table("features.txt")
names(data) = features$V2

#import activity labels
activity_labels = read.table("activity_labels.txt")

#merge 
subj_active = cbind(subject,activity)
data_merge = cbind(subj_active,data)
