TidyDataCoursera
================

Getting and Cleaning a dataset | Coursera | Tidy Data 

The program run_analysis.R reads in the data from the UCI HAR dataset and manipulates the data to present a human readable format of the data.

The Dataset
===========
The UCI HAR dataset contains the measurements for experiments performed on a group of people aged 19-48. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. It is divided into a test and training set based on a 30%-70% random split. The dataset is also accompanied by 4 text (.txt) files. The files are:
activity_labels.txt (to identify the type of activity)
features.txt (to identify the features used in the activity)
features_info.txt (to define the meaning of each feature)
Readme.txt (gives more detailed explanation about the dataset, it is recommended to read this file)

The training and test set contains the measurements in the x and y directions. It also contains the subject's activity measurement for each experiment.

PLEASE NOTE:: For this program, the files in the folder (Inertial Signals) was not used.

The Program
===========
run_analysis.R is the main R program. It is to be executed by placing the UCI HAR dataset in the folder which is to follow the directory structure below:
{R Home Directory}/Coursera/UCI HAR Dataset/(Unzip your dataset file here)

Please do not alter the structure of the dataset zip file after unzipping it.

The inputs to this program are the following .txt files:
activity_labels.txt
features.txt
X_test.txt
X_train.txt
y_test.txt
y_train.txt
subject_test.txt
subject_train.txt

Code Logic
==========
The program reads in the train and test files. Then it appends them to form a large dataset with 563 columns and 10299 rows.

From this large dataset it subsets a smaller dataset which contains only those columns (variables) which have a _mean or an _std measurement. This gives a dataset with 66 columns. (22 for each axis, X,Y and Z).

Then we add in the subject and subject activity to give it 68 columns in total.

PLEASE NOTE:: The Codebook.md gives a more detailed explanation of each variable.

Then we use the reshape2 package to melt and cast this dataset to give an aggregated dataset where each subject activity has an aggregated value for each of the 66 columns.

This gives a final result of 180 rows and 67 columns. Each row represents an aggregation of all values for each Subject and Activity.
