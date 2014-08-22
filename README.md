getting_and_cleaning_data
=========================

Coursera - Getting and Cleaning Data - Project

The script file "run_analysis.R" takes data located in a R working directory 
(originally from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
and does the following:

1. Loads the measurement data into seperate tables (test and training).
2. Merges the measurement data tables into one large table.
3. Retains only mean and standard deviation measurements - tidy_data1.
4. Creates a 2nd table containing the average for each measurement with respect to every
activity and subject - tidy_data2.
5. Writes the tidy_data2 table to a text file called "tidy_data2.txt".
6. Deletes all the intermediary data tables to save RAM space.

The resulting text file can be read back into R using the command:
read.table("tidy_data2.txt", header=TRUE, sep=",")
