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
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.  


### Cleaned data





## Variables



## Transformations



## Other work to clean up the data



## Author

vtenhunen