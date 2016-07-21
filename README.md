# Getting and Cleaning Data - Assignment
Coursera Data Cleaning Assignment from Week4

## Installation Instructions
1. Download the dataset (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzip to your working directory.
2. Copy the file run_analysis.R to the working directory.

## Explanation of run_analysis.R
1. The data is first read in using read.table. Training and test data are read in separately into the following R tables:
  * test_data - all the 561 feature measurements for the test data set.
  * test_label - the activity label for each observation e.g. sitting,standing etc. for people participating in the test data collection.
  * test_subject - the person or subject partcipating in the test measurements.
  * train_data - all the 561 feature measurements for the training data set.
  * train_label - the activity label for each observation e.g. sitting,standing etc. for people participating in the training data collection.
  * train_subject - the person or subject partcipating in the test measurements.
  * features - contains the names of all 561 features that are measured.
  * activities - contains the labels for the 6 activities that the participants were asked to do e.g. sitting, standing, walking etc.
2. The test and training data is then merged by binding the rows of the measurements, activity labels and subjects separately.
3. The names are added to the merged measurements from the variable called "features".
4. Next the columns, that are not mean or standard deviation measurements, are removed from the merged measurements.
5. The merged subject and activity data is then added to the merged measurement data as columns to form the complete data set.
6. A data table is created with the complete data for the final step which requires calculating the mean for each measurement by subject and activity. This is achieved by subsetting the data table and using the lapply function.
7. Finally the table of average values as per the required tidy format is outputted to a text file called "tidy_data.txt"
 
## Submitted files
* run_analysis.R - the R analysis file that produces the tidy data in the required format.
* README.md - file that explains how the R script works.
* CodeBook.md - indicates all the variables and summaries calculated.
* tidy_data.txt - the output of running "run_analysis.R" (the tidy data in the required format)
