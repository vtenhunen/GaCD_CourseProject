run_analysis <- function (directory="UCI HAR Dataset") {
      
      # This function does the following. 
      #
      # 1. Merges the training and the test sets to create one data set.
      # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
      # 3. Uses descriptive activity names to name the activities in the data set
      # 4. Appropriately labels the data set with descriptive variable names. 
      # 5. From the data set in step 4, creates a second, independent tidy data set with the 
      #    average of each variable for each activity and each subject.
      
      ### 1. Merges the training and the test sets to create one data set.
      
      # get the working directory path to the variable
      wd <- getwd()
      
      # Load packages
      library(data.table)
      library(plyr)
      library(dplyr)
      library(reshape2)
      
      ## Paths to files
      # Subject files
      path_subject_train <- file.path(wd,directory,"train","subject_train.txt")
      path_subject_test <- file.path(wd,directory,"test","subject_test.txt")
      
      # Activity files
      path_activity_train <- file.path(wd,directory,"train","y_train.txt")
      path_activity_test <- file.path(wd,directory,"test","y_test.txt")
      
      # Data files
      path_data_train <- file.path(wd,directory,"train","X_train.txt")
      path_data_test <- file.path(wd,directory,"test","X_test.txt")
      
      ## Read data to tables from files
      table_subject_train <- fread(path_subject_train)
      table_subject_test <- fread(path_subject_test)
      table_activity_train <- fread(path_activity_train)
      table_activity_test <- fread(path_activity_test)
      
      ## Somehow these freads goes to overflow, so use read.table

      table_data_train <- data.table(read.table(path_data_train))
      table_data_test <- data.table(read.table(path_data_test))      

      ## Cat *subject*, *activity* and *data* tables
      table_subject_all <- rbind(table_subject_train, table_subject_test)
      table_activity_all <- rbind(table_activity_train, table_activity_test)
      table_data_all <- rbind(table_data_train, table_data_test)
      
      # Because later we have to use descriptive names of features, it easier to give names now. Otherwise they both got name "V1" 

      path_features <- file.path(wd, directory, "features.txt")
      table_features <- fread(path_features)
      
      old_names <- names(table_data_all)
      new_names <- table_features$V2
      setnames(table_data_all, old_names, new_names)
      
      setnames(table_subject_all, "V1", "Subject")
      setnames(table_activity_all, "V1", "Activity")
      
      # Then merge columns subject and activity to data with two phases
      table_subject_all <- cbind(table_subject_all, table_activity_all)
      table_data_all <- cbind(table_subject_all, table_data_all)
      
      # Now we have all for this project in one table

      ### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
      # The next step is to extract measurements on the mean and standard deviation for each measurement      
 
      # first get the mean values
      v_means <- grep("mean()", names(table_data_all))
      table_means <- table_data_all[, v_means, with = FALSE]
      
      # then get the standrad deviation values
      v_stds <- grep("std()", names(table_data_all))
      table_stds <- table_data_all[, v_stds, with = FALSE]
      
      # Combine this and we have table for measurements on the mean and standard deviation for each measurement
      # and descriptive names to columns. Also subject and activity added. 

      table_extracted <- cbind(table_subject_all, table_means, table_stds)

      
      ### 3. Uses descriptive activity names to name the activities in the data set

      # Get activity names
      
      path_labels <- file.path(wd, directory, "activity_labels.txt")
      table_activity_labels <- fread(path_labels)
 
      #Change values in table_data_all 

      table_extracted$Activity[table_extracted$Activity == 1] <- table_activity_labels$V2[1]
      table_extracted$Activity[table_extracted$Activity == 2] <- table_activity_labels$V2[2]
      table_extracted$Activity[table_extracted$Activity == 3] <- table_activity_labels$V2[3]
      table_extracted$Activity[table_extracted$Activity == 4] <- table_activity_labels$V2[4]
      table_extracted$Activity[table_extracted$Activity == 5] <- table_activity_labels$V2[5]
      table_extracted$Activity[table_extracted$Activity == 6] <- table_activity_labels$V2[6]
      
      # Now activity names are readable in the Activity column

      # 4. Appropriately labels the data set with descriptive variable names. 

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

      # Then we make some other parts of variable names better readable
      
      names(table_extracted)<-gsub("^t", "time", names(table_extracted))
      names(table_extracted)<-gsub("^f", "frequency", names(table_extracted))
      names(table_extracted)<-gsub("Acc", "Accelerometer", names(table_extracted))
      names(table_extracted)<-gsub("Gyro", "Gyroscope", names(table_extracted))
      names(table_extracted)<-gsub("Mag", "Magnitude", names(table_extracted))
      names(table_extracted)<-gsub("BodyBody", "Body", names(table_extracted))
      
      # 5. From the data set in step 4, creates a second, independent tidy data set with the 
      #    average of each variable for each activity and each subject.
      
      # Create the tidy data set and clean NAs
      table_melted <- melt(table_extracted, id=c("Subject","Activity"))
      table_tidy <- dcast(table_melted, Subject+Activity ~ variable, mean)

      #writing it to the working directory
      write.table(table_tidy, file="TidyDataSet.txt", sep="\t", row.name = FALSE)
      
}