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
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

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

* installed packages: data.table, reshape2, plyr and dplyr

## Read data

In this case we use *data.table* package to handle the data set.

      library(data.table)
      library(plyr)
      library(dplyr)
      library(reshape2)
      
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

## 1. Merges the training and the test sets to create one data set

### Concatenate tables

Now we have all data in tables, which we like to concatenate as own tables

      table_subject_all <- rbind(table_subject_train, table_subject_test)
      table_activity_all <- rbind(table_activity_train, table_activity_test)
      table_data_all <- rbind(table_data_train, table_data_test)
      
      
### Names of columns

Set up names to columns. First get the list of features from the file

      path_features <- file.path(wd, directory, "features.txt")
      table_features <- fread(path_features)
      
Create variables *old_names* and *new_names*, which have values from tables      
      
      old_names <- names(table_data_all)
      new_names <- table_features$V2
      
Set names to tables

      setnames(table_data_all, old_names, new_names)
      setnames(table_subject_all, "V1", "Subject")
      setnames(table_activity_all, "V1", "Activity"")

### Merge columns and descriptive names
      
Then merge columns subject and activity to data with two phases

      table_subject_all <- cbind(table_subject_all, table_activity_all)
      table_data_all <- cbind(table_data_all, table_subject_all)
      
Now we have all in one table and columns have names

## 2. Extracts only the measurements on the mean and standard deviation for each measurement

### Extract mean and strandard deviation

Netx step is extract only the measurements on the mean and standard deviation for each measurement.

First get the mean values

      v_means <- grep("mean()", names(table_data_all))
      table_means <- table_data_all[, v_means, with = FALSE]
      
Then get the standrad deviation values

      v_stds <- grep("std()", names(table_data_all))
      table_stds <- table_data_all[, v_stds, with = FALSE]
      
Combine this and we have table for measurements on the mean and standard deviation for each measurement and descriptive names to columns

      table_extracted <- cbind(table_subject_all, table_means, table_stds)

## 3. Uses descriptive activity names to name the activities in the data set

Get activity names

      path_labels <- file.path(wd, directory, "activity_labels.txt")
      table_activity_labels <- fread(path_labels)
 
Change values in *table_extracted* 

      table_extracted$Activity[table_extracted$Activity == 1] <- table_activity_labels$V2[1]
      table_extracted$Activity[table_extracted$Activity == 2] <- table_activity_labels$V2[2]
      table_extracted$Activity[table_extracted$Activity == 3] <- table_activity_labels$V2[3]
      table_extracted$Activity[table_extracted$Activity == 4] <- table_activity_labels$V2[4]
      table_extracted$Activity[table_extracted$Activity == 5] <- table_activity_labels$V2[5]
      table_extracted$Activity[table_extracted$Activity == 6] <- table_activity_labels$V2[6]
      

Now activity names are readable in the Activity column

## 4. Appropriately labels the data set with descriptive variable names 

      # Change the code of the subject to the descriptive values:
      # By README.txt -file of the original data set, there was group of 30 volunteers
      
      table_extracted$Subject[table_extracted$Subject == 1] <- "Person 1"
      table_extracted$Subject[table_extracted$Subject == 2] <- "Person 2"
      table_extracted$Subject[table_extracted$Subject == 3] <- "Person 3"
      table_extracted$Subject[table_extracted$Subject == 4] <- "Person 4"
      table_extracted$Subject[table_extracted$Subject == 5] <- "Person 5"
      table_extracted$Subject[table_extracted$Subject == 6] <- "Person 6"
      table_extracted$Subject[table_extracted$Subject == 7] <- "Person 7"
      table_extracted$Subject[table_extracted$Subject == 8] <- "Person 8"
      table_extracted$Subject[table_extracted$Subject == 9] <- "Person 9"
      table_extracted$Subject[table_extracted$Subject == 10] <- "Person 10"
      table_extracted$Subject[table_extracted$Subject == 11] <- "Person 11"
      table_extracted$Subject[table_extracted$Subject == 12] <- "Person 12"
      table_extracted$Subject[table_extracted$Subject == 13] <- "Person 13"
      table_extracted$Subject[table_extracted$Subject == 14] <- "Person 14"
      table_extracted$Subject[table_extracted$Subject == 15] <- "Person 15"
      table_extracted$Subject[table_extracted$Subject == 16] <- "Person 16"
      table_extracted$Subject[table_extracted$Subject == 17] <- "Person 17"
      table_extracted$Subject[table_extracted$Subject == 18] <- "Person 18"
      table_extracted$Subject[table_extracted$Subject == 19] <- "Person 19"
      table_extracted$Subject[table_extracted$Subject == 20] <- "Person 20"
      table_extracted$Subject[table_extracted$Subject == 21] <- "Person 21"
      table_extracted$Subject[table_extracted$Subject == 22] <- "Person 22"
      table_extracted$Subject[table_extracted$Subject == 23] <- "Person 23"
      table_extracted$Subject[table_extracted$Subject == 24] <- "Person 24"
      table_extracted$Subject[table_extracted$Subject == 25] <- "Person 25"
      table_extracted$Subject[table_extracted$Subject == 26] <- "Person 26"
      table_extracted$Subject[table_extracted$Subject == 27] <- "Person 27"
      table_extracted$Subject[table_extracted$Subject == 28] <- "Person 28"
      table_extracted$Subject[table_extracted$Subject == 29] <- "Person 29"
      table_extracted$Subject[table_extracted$Subject == 30] <- "Person 30"

Then we make some other parts of variablenames better readable

      names(table_extracted)<-gsub("^t", "time", names(table_extracted))
      names(table_extracted)<-gsub("^f", "frequency", names(table_extracted))
      names(table_extracted)<-gsub("Acc", "Accelerometer", names(table_extracted))
      names(table_extracted)<-gsub("Gyro", "Gyroscope", names(table_extracted))
      names(table_extracted)<-gsub("Mag", "Magnitude", names(table_extracted))
      names(table_extracted)<-gsub("BodyBody", "Body", names(table_extracted))
      
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

Create the tidy data set

      table_melted <- melt(table_extracted, id=c("Subject","Activity"))
      table_tidy <- dcast(table_melted, Subject+Activity ~ variable, mean)

Writing it to the working directory

      write.table(table_tidy, file="TidyDataSet.txt", sep="\t", row.name = FALSE)


# Acknowledgment and licence

Original data: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

# End note

For Data Science Specialition course Getting and Cleanind Data created by vtenhunen.
