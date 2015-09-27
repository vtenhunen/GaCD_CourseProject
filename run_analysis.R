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
      
      # Load data.table package
      library(data.table)
      
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
      #table_data_train <- fread(path_data_train)
      #table_data_test <- fread(path_data_test)

      table_data_train <- data.table(read.table(path_data_train))
      table_data_test <- data.table(read.table(path_data_test))      
      
      ## Cat *subject*, *activity* and *data* tables
      table_subject_all <- rbind(table_subject_train, table_subject_test)
      table_activity_all <- rbind(table_activity_train, table_activity_test)
      table_data_all <- rbind(table_data_train, table_data_test)
      
      # Because later we have to use descriptive names of features, it easier to give names now. Otherwise they both got name "V1" 
      # see task no. 3

      path_features <- file.path(wd, directory, "features.txt")
      table_features <- fread(path_features)
      
      old_names <- names(table_data_all)
      new_names <- table_features$V2
      setnames(table_data_all, old_names, new_names)
      
      setnames(table_subject_all, "V1", "Subjects")
      setnames(table_activity_all, "V1", "ActivityNumbers")
      
      # Then merge columns subject and activity to data with two phases
      table_subject_all <- cbind(table_subject_all, table_activity_all)
      table_data_all <- cbind(table_data_all, table_subject_all)
      
      # Now we have all in one table

      # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
      # The next step is to extract measurements on the mean and standard deviation for each measurement      
      
      
      
      
      ## 3. Descitptive names and extraction of means and std deviations
      # 4. Appropriately labels the data set with descriptive variable names. 
      # 5. From the data set in step 4, creates a second, independent tidy data set with the 
      #    average of each variable for each activity and each subject.
      
           

      
}