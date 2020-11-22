# Getting-and-Cleaning-Data

## Description
The run analysis.R script operates on two datasets: "X_train.txt" and "X_test.txt" within sub-folders 'train' and 'test' of "UCI HAR Dataset", respectively and produces one tidy data set.

## Version
R v4.0.3

### Packages
1) readr
2) dplyr

## Prerequisites
set working directory to "UCI HAR Dataset" using setwd() function
or, Topbar > Session > Set Working Directory > Choose Directory... > "UCI HAR Dataset"

## Walkthrough the script

1) Column names of 561 Variables within X_train.txt and X_test.txt are loaded in using read.table() function as 'cNamedf' and further stripped as character string as 'cNames'

2) X_train and X_test dataset are loaded in using read.table() function as 'x_train' and 'x_test', column names are rewritten to 'cNames' using names() function.

3) Subject IDs within "subject_train.txt" and "subject_train.txt"; activity labels within "y_train.txt" and "y_test.txt" read using read.table() and are vertically joined with 'x_train' and 'x_test' data frames using cbind() function, respectively.

4) Resulting 'train_data' and 'test_data' dataframes are horizontally joined using rbind() function to produce a single data frame 'bData'

5) Columns with mean() and std() measures are selected using grep() functions and stored in 'colUse'; these selected columns along with the first two columns are extracted from 'bData' to create 'bDataUse'

6) Activity labels (activity names: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING") are read in order into 'actLabels', stripped into char strings as 'actLabelV' and indexed by the actLabel column in 'bDataUse' and stored in 'bDataActivity'; the specified column is then replaced with these indexed values producing descriptive activity names.

7) Column names in 'bDataUse' are edited using gsubs(), names() and colnames() functions, creating an intermediate variable 'colNames' for each substitution of special characters and duplications.

8) Edited data frame 'bDataUse' is then grouped by the columns "subID" and "actLabel" using group_by() and summarized using summarize_each() functions to calculate mean value of each activity performed by a single subject. This produces a tidydata set containing unique subject-activity pairs.

9) Finally, the tidy data frame is written as "tidydata.txt" using write.table() function.

## Link to tidydata file
https://github.com/ninsquid/Getting-and-Cleaning-Data/blob/main/tidydata.txt

## Data Source
Human Activity Recognition Using Smartphones Data Set
URL: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.
