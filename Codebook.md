# Coursera Getting and Cleaning Data

This document describes the variables, the data, and any transformations or work that was performed to clean up the data. 

The data was gotten from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. It is a data set from the Human Activity Recognition Using Smartphones Data Set site - https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. This assignment summarizes the data represented in the zip files.

## Input

From the zip file, the following files were used to form the base data of the transformations:

* "activity_labels.txt" - lists all six activities and corresponding numerical values
* "features.txt" - list of features
* In the **test** directory
  * "subject_test.txt" - subject IDs for all test data
  * "X_test.txt" - readings for all test feature data
  * "y_test.txt" - readings for all test activity data
* In the **train** directory
  * "subject_train.txt" - subject IDs for all training data
  * "X_train.txt" - readings for all training feature data
  * "y_train.txt" - readings for all training activity data
Data in the **Inertial Signals** directory was ignored for this assignment.

## Variables

The activity labels are 
* Subject ID 
* Activity labels
* All the standard deviation and mean feature data 
  * grep for "mean" and "std" from "features.txt" to find the related feature columns. E.g. "tBodyAcc-mean()-X" or "tBodyAcc-std()-Z").

## Steps to transform the data

1. The data from "features.txt" and was read in
  1. The data was cleaned up to change invalid column name characters to valid ones - parenthesis, commas, and dashes
2. All the **test** directory data was read into a 'test' data frame - IDs, feature data, and activity data
3. All the **train** directory data was read into a 'train' data frame - IDs, feature data, and activity data
4. Both data frames were merged into one
5. The mean and standard deviation data was extracted and put into on dataframe with columns for ID and activity name
6. The activity numerical values were changed to their string counterparts
7. The whole data frame was grouped by subject and activity
8. The mean for each activity in all subject and activity combinations was computed.



  
