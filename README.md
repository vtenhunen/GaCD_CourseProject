# Readme

## General overview

This in material for the Course Project of the JHU's Data Science Specialization course *Getting and Cleaning Data* (getdata-032).

This project submit: 

1. a tidy data set as described below,
2. a link to a Github repository with your script for performing the analysis, and 
3. a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

Project include also this README.md document. This document explains how all of the scripts work and how they are connected.

## Tidy data set

In this project has created one R script called *run_analysis.R* that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Data

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Scripts and their connections

### Getting data

Base for all files and folders is working directory called *GaCD_CourseProject*.

Getting the data:

A full description of the data is on web page end therefore it is good idea to use browser to read it.

Data is in the zip-file. Getting and opening the zip-file.

      fileUrl1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileUrl1, destfile="./UCI_HAR_Dataset.zip")
      unzip("UCI_HAR_Dataset.zip")

This creates folder called *UCI HAR Dataset* where all data files are. 

Files and explanation of files by README.txt of the data set:
* README.txt
* features_info.txt: Shows information about the variables used on the feature vector.
* features.txt: List of all features.
* activity_labels.txt: Links the class labels with their activity name.
* train/X_train.txt: Training set.
* train/y_train.txt: Training labels.  

## Prerequisites

* installed packages: data.table



## Read data

In this case we use *data.table* package to handle the data set.

      library(data.table)

Working directory path is in the variable *wd*

      wd <- getwd()

Paths to the subject files

      path_subject_train <- file.path(wd,directory,"train","subject_train.txt")
      path_subject_test <- file.path(wd,directory,"test","subject_test.txt")

Paths to the activity files

      path_activity_train <- file.path(wd,directory,"train","y_train.txt")
      path_activity_test <- file.path(wd,directory,"test","y_test.txt")
      
Paths to the data files

      path_data_train <- file.path(wd,directory,"train","X_train.txt")
      path_data_test <- file.path(wd,directory,"test","X_test.txt")

Read data to tables

      table_subject_train <- fread(path_subject_train)
      table_subject_test <- fread(path_subject_test)
      table_activity_train <- fread(path_activity_train)
      table_activity_test <- fread(path_activity_test)
      
Some reason freads of data files goes to overflow, so use read.table and data.table

      table_data_train <- data.table(read.table(path_data_train))
      table_data_test <- data.table(read.table(path_data_test)) 


## Concatenate tables

Now we have all data in tables, which we like to concatenate as own tables

      table_subject_all <- rbind(table_subject_train, table_subject_test)
      table_activity_all <- rbind(table_activity_train, table_activity_test)
      table_data_all <- rbind(table_data_train, table_data_test)
      
      
## Names of columns

Set up names to columns. First get the list of features from the file

      path_features <- file.path(wd, directory, "features.txt")
      table_features <- fread(path_features)
      
Create variables *old_names* and *new_names*, which have values from tables      
      
      old_names <- names(table_data_all)
      new_names <- table_features$V2
      
Set names to tables

      setnames(table_data_all, old_names, new_names)
      setnames(table_subject_all, "V1", "Subjects")
      setnames(table_activity_all, "V1", "ActivityNumbers")

## Merge columns and descriptive names
      
Then merge columns subject and activity to data with two phases

      table_subject_all <- cbind(table_subject_all, table_activity_all)
      table_data_all <- cbind(table_data_all, table_subject_all)
      
Now we have all in one table and columns have descriptive names

## Extract mean and strandard deviation

Netx step is extract only the measurements on the mean and standard deviation for each measurement.

First get the mean values

      v_means <- grep("mean()", names(table_data_all))
      table_means <- table_data_all[, v_means, with = FALSE]
      
Then get the standrad deviation values

      v_stds <- grep("std()", names(table_data_all))
      table_stds <- table_data_all[, v_stds, with = FALSE]
      
Combine this and we have table for measurements on the mean and standard deviation for each measurement and descriptive names to columns (3. Descritptive names and extraction of means and std deviations)

      table_extracted <- cbind(table_means, table_stds)










Labels




## Credits

Original data is made by

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.   
Smartlab - Non Linear Complex Systems Laboratory  
DITEN - Universitá degli Studi di Genova.  
Via Opera Pia 11A, I-16145, Genoa, Italy.  
activityrecognition@smartlab.ws  
www.smartlab.ws  


## End note

For Data Science Specialition course Getting and Cleanind Data created by vtenhunen.

