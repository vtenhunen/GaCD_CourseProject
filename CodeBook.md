# Code book 

## General overview

This document describes the variables, the data, and any transformations or work that you performed to clean up the data for the JHU's Data Science Specialization course *Getting and Cleaning Data* (getdata-032).


## The data

### Raw data and it's description

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

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

Paths to the subject files

      path_subject_train <- file.path(wd,directory,"train","subject_train.txt")
      path_subject_test <- file.path(wd,directory,"test","subject_test.txt")

Paths to the activity files

      path_activity_train <- file.path(wd,directory,"train","y_train.txt")
      path_activity_test <- file.path(wd,directory,"test","y_test.txt")
      
Paths to the data files

      path_activity_data <- file.path(wd,directory,"train","X_train.txt")
      path_activity_data <- file.path(wd,directory,"test","X_test.txt")      

Read data to tables

      table_subject_train <- fread(path_subject_train)
      table_subject_test <- fread(path_subject_test)
      table_activity_train <- fread(path_activity_train)
      table_activity_test <- fread(path_activity_test)
      
Some reason freads of data files goes to overflow, so use read.table and data.table

      table_data_train <- data.table(read.table(path_data_train))
      table_data_test <- data.table(read.table(path_data_test)) 

Now we have all data in tables, which we like to concatenate as own tables

      table_subject_all <- rbind(table_subject_train, table_subject_test)
      table_activity_all <- rbind(table_activity_train, table_activity_test)
      table_data_all <- rbind(table_data_train, table_data_test)
      
Set up names to columns. First get the list of features from the file

      path_features <- file.path(wd, directory, "features.txt")
      table_features <- fread(path_features)
      
Create variables old_names and new_names, which have values from tables      
      
      old_names <- names(table_data_all)
      new_names <- table_features$V2
      
Set names to tables

      setnames(table_data_all, old_names, new_names)
      setnames(table_subject_all, "V1", "Subjects")
      setnames(table_activity_all, "V1", "ActivityNumbers")
      
Then merge columns subject and activity to data with two phases

      table_subject_all <- cbind(table_subject_all, table_activity_all)
      table_data_all <- cbind(table_data_all, table_subject_all)
      
Now we have all in one table and columns have descriptive names









## Variables



## Transformations



## Other work to clean up the data


## Credits

Original data is made by

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.   
Smartlab - Non Linear Complex Systems Laboratory  
DITEN - Universitá degli Studi di Genova.  
Via Opera Pia 11A, I-16145, Genoa, Italy.  
activityrecognition@smartlab.ws  
www.smartlab.ws  




## Author

vtenhunen