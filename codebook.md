---
title: "CodeBook for Getting and cleaning Data Project"
author: "SWD"
date: "Sunday, November 23, 2014"
output: html_document
---
This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.

Source for Data:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R script performs the following steps to clean the data:
Downloads the data into temp variable
Read X_train.txt, y_train.txt, subject_train.txt, X_test.txt, y_test.txt and subject_test.txt and stores them in xtrainData, ytrainData, subjecttrainData, xtestData, ytestData and subjecttestData
rbind xtrainData and xtestData to variable xjoinData
rbind ytrainData and ytestData to variable yjoinData
rbind subjecttrainData and subjecttestData to variable subjectjoinData
Read the features.txt file and store in features variable. we estract only the mean and std variables and store row numbers in variable meanstdData and content in features2
read the activity name from activity_labels.txt into activityData and replace the "_" with " "
create a variable othrNames and extract 2nd column from features2 into it. 
clean othrNames by removing non-characters
update xjoinData by extracting only the columns matching meanstdData
update column names of xjoinData to reflect othrNames
concatenate yjoinData, subjectjoinData and xjoinData into variavle finalData
create a new table variable newData, eliminating the 1st 2 columns, grouping by activity and subject and calculating the mean for each. 
write new table to a document called newData.txt