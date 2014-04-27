# ==================================================================================================
#    run_analysis.r
#    :purpose: To create one R script called run_analysis.R that does the following. 
#              Merges the training and the test sets to create one data set.
#             Extracts only the measurements on the mean and standard deviation for each measurement. 
#             Uses descriptive activity names to name the activities in the data set
#             Appropriately labels the data set with descriptive activity names. 
#             Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#    :author: Krithika Ramanarayanan
#    :date: 17 April 2014
#    :note: This uses the dataset downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# ==================================================================================================

### preload required packages
install.packages(data.table)
library(stringr)
library(data.table)
library(reshape2)
library(Hmisc)

### Locations
proj <- str_c("~/Coursera/UCI HAR Dataset/")
dirs <- c(str_c(proj,'test/'),str_c(proj,'train/'))
names(dirs) <- c("test","train")

### Read in the labels
labels <- read.table(str_c(proj,'activity_labels.txt'), sep = "")
activityLabels <- as.character(labels$V2)
feat <- read.table(str_c(proj,'features.txt'), sep = "")
featureNames <- feat$V2

### Read in training and test sets for X and Y axes
X_train <- read.table(str_c(dirs['train'],'X_train.txt'), sep = "")
names(X_train) <- featureNames

X_test <- read.table(str_c(dirs['test'],'X_test.txt'), sep = "")
names(X_test) <- featureNames

Y_train <- read.table(str_c(dirs['train'],'y_train.txt'), sep = "")
names(Y_train) <- "SubjectAct"
Y_train$SubjectAct <- as.factor(Y_train$SubjectAct)
levels(Y_train$SubjectAct) <- activityLabels

Y_test <- read.table(str_c(dirs['test'],'y_test.txt'), sep = "")
names(Y_test) <- "SubjectAct"
Y_test$SubjectAct <- as.factor(Y_test$SubjectAct)
levels(Y_test$SubjectAct) <- activityLabels

### Read in training and test sets for subject data
Sub_train <- read.table(str_c(dirs['train'],'subject_train.txt'), sep = "")
names(Sub_train) <- "Subject"
Sub_train$subject <- as.factor(Sub_train$Subject)

Sub_test <- read.table(str_c(dirs['test'],'subject_test.txt'), sep = "")
names(Sub_test) <- "Subject"
Sub_test$subject <- as.factor(Sub_test$Subject)

### Append X, Y and subject data for training and test sets
train_set <- cbind(X_train, Sub_train, Y_train)
test_set <- cbind(X_test, Sub_test, Y_test)

### Merge training and test set
merged_set <- rbind(train_set, test_set)

## gcdata checklist, regex cols , reshape pkg, finish document & github
### Extract only mean and std deviation measurements

outColMean <- grep("\\-mean\\(\\)(\\-)*",names(merged_set))
outColStd <- grep("\\-std\\(\\)(\\-)*",names(merged_set))
outcol <- cbind(outColMean, outColStd)
merged_set <- data.table(merged_set)
extracted_set <- merged_set[, outcol, with=FALSE]

b <- grep("Subject*",names(merged_set))
agg_set <- merged_set[, b, with=FALSE]

agg_set <- cbind(agg_set,extracted_set)

md <- melt(agg_set, id=(c("Subject","SubjectAct")))
final_set <- dcast(md, Subject + SubjectAct ~variable,mean)

write.table(final_set, str_c(proj,'final_tidy_result.txt'), sep = ",")
