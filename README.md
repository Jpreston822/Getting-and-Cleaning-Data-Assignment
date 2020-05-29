# Getting-and-Cleaning-Data-Assignment

## Explanation of Getting and Cleaning Data Assignment

First, download the files and unzip them.
Next, save the files to your R working directory on your computer.
Next, download the R run_analysis.R script into your working directory.
Run the R script in order to produce a tidy data set.

## Description of Data

The x data represents signals that were measured on the subjects while performing certain activities and the y data represents the activity that was done while the data was collected.  There were a total of 30 subjects that completed the 6 activities.  The 6 activities were Walking, Walking Up Stairs, Walking Down Stairs, Sitting, Standing, and Laying.

## Description of R Script

The run_analysis.R script first sets the working directory to match where the files are downloaded.  Then it loads the dplyr library that will be needed later.  Then, it reads in to R all of the data that will be needed and assigns them variables.  

### Part 1 of assignment (Merge training and test sets):
The script first uses cbind to create the test and train tables which adds a column for the corresponding Activity and Subject to the test and train tables.  Then rbind is used to combine the test and train tables.

### Part 2 of assignment (Extracts only mean and sd for each measurement): 
The script first defines a vector of the column numbers that are wanted in the full table.  The columns that are wanted are only ones that are for mean() and sd().  The table is then subsetted to produce the table that is wanted only showing the mean() and sd() columns.

### Part 3 of assignment (Uses descriptive activity names for activities in data set):
The script first changes column 1 of the table to a factor.  Then it uses levels() and gsub() to change the numbers in the first column to their corresponding activities.

### Part 4 of assignment (Labels data set with descriptive variable names):
The script first defines a vector of the row numbers that are wanted in the features table.  The features table is then subsetted by the row numbers that are wanted.  The second column of the subsetted features table is then changed to characters.  Using names() the column headers are changed to “Activity”, “Subject”, and then columns 3-68 are assigned the names from the subsetted features table.

### Part 5 of assignment (Creates a tidy data set with average of each variable for each activity and subject):
The script uses the dplyr library for this part of the assignment to create the tidy data set.  It uses group_by() and summarize_each() to create a tidy data set with the average of each variable for each activity and subject together.

Finally, the tidy data set is written to a file called “tidy_data_set.txt” using write.table() and stored in the working directory.  In order to review the tidy data set, use read.table(file_path, header = TRUE).
