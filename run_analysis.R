setwd("~/Desktop/R notes/Course 3/Week 4/Assignment") ##First set working directory
library(dplyr) ##load library that will be needed

## Import all the data from my working directory
xtest <- read.table("X_test.txt")
ytest <- read.table("y_test.txt")
xtrain <- read.table("X_train.txt")
ytrain <- read.table("y_train.txt")
sub_test <- read.table("subjet_test.txt")
sub_train <- read.table("subject_train.txt")
features <- read.table("features.txt")

## combine test and train datasets together by combining the columns of activity (y), then subject (sub), then data (x)
test <- cbind(ytest, sub_test, xtest)
train <- cbind(ytrain, sub_train, xtrain)

## merge combined test and train tables into one table
test_train <- rbind(test,train)

## subset the columns that are wanted with mean and sd
## first create vector of column numbers wanted using features (+2 one each number due to extra columns added in front of data for activity and subject)
col_num_wanted <- c(1:8,43:48,83:88,123:128,163:168,203,204,216,217,229,230,242,243,255,256,268:273,347:352,426:431,505,506,518,519,531,532,544,545)
## then subset table
test_train_meansdcol <- test_train[, col_num_wanted]

## change the activity numbers into descriptive activity names
## first make column 1 a factor
test_train_meansdcol$V1 <- as.factor(test_train_meansdcol$V1)
## then use gsub to change the factors to the descriptive names
levels(test_train_meansdcol$V1) <- gsub("1","WALKING", levels(test_train_meansdcol$V1))
levels(test_train_meansdcol$V1) <- gsub("2","WALKING_UPSTAIRS", levels(test_train_meansdcol$V1))
levels(test_train_meansdcol$V1) <- gsub("3","WALKING_DOWNSTAIRS", levels(test_train_meansdcol$V1))
levels(test_train_meansdcol$V1) <- gsub("4","SITTING", levels(test_train_meansdcol$V1))
levels(test_train_meansdcol$V1) <- gsub("5","STANDING", levels(test_train_meansdcol$V1))
levels(test_train_meansdcol$V1) <- gsub("6","LAYING", levels(test_train_meansdcol$V1))

## change the variables in column headers to the actual names from the features document
## first make a vector of the row numbers wanted in the features file
row_num_wanted <- c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,240,241,253,254,266:271,345:350,424:429,503,504,516,517,529,530,542,543)
## create a subset of the variable names from the features file
features_meansd <- features[row_num_wanted,]
## create a list of variable names
var_names <- as.character(features_meansd$V2)
## rename column headers, first the two columns that were added and then the data columns 3 to 68
names(test_train_meansdcol)[1] <- "Activity"
names(test_train_meansdcol)[2] <- "Subject"
names(test_train_meansdcol)[3:68] <- var_names[1:66]

## create a table that is tidy with the means combined over activity and subject
test_train_meansdcol_combmean <- test_train_meansdcol %>% group_by(Activity, Subject) %>% summarize_each(funs = mean) 
## write table to txt file that is saved in working directory
write.table(test_train_meansdcol_combmean, file = "tidy_data_set.txt", row.names = FALSE, col.names = TRUE)


