library(dplyr)
library(data.table)

setwd("/Users/megan/Documents/UCI HAR Dataset/")

#import test files
X_test = read.table("test/X_test.txt")
Y_test = read.table("test/Y_test.txt")
subject_test = read.table("test/subject_test.txt")

#import train files
X_train = read.table("train/X_train.txt")
Y_train = read.table("train/Y_train.txt")
subject_train = read.table("train/subject_train.txt")



