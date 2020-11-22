library(readr)
library(dplyr)

####Reading the data in tabular form in R;
####Read along with the original column names for convenience

cNamedf <- read.table("features.txt")
cNames <- cNamedf$V2

x_train <- read.table("./train/X_train.txt", header = FALSE, sep = "",
                       dec = ".",
                       skip = 0,
                       strip.white = FALSE)
names(x_train) <- cNames
x_train_sub <- read.table("./train/subject_train.txt", col.names = "subID")
x_train_labels <- read.table("./train/y_train.txt", col.names = "actLabel")

train_data0 <- cbind(x_train_sub, x_train_labels)
train_data <- cbind(train_data0, x_train)


x_test <- read.table("./test/X_test.txt", header = FALSE, sep = "",
                      dec = ".",
                      skip = 0,
                      strip.white = FALSE)
names(x_test) <- cNames
x_test_sub <- read.table("./test/subject_test.txt", col.names = "subID")
x_test_labels <- read.table("./test/y_test.txt", col.names = "actLabel")

test_data0 <- cbind(x_test_sub, x_test_labels)
test_data <- cbind(test_data0, x_test)

####Task-1: Merges the train and test datasets into one data frame
#### Joined horizontally as column numbers for both are equal (=563) 
#### returns 561 measurement variables and 10299 observations

bData <- rbind(train_data, test_data)


####Task-2: Extracts only columns with measurements for 
#### mean and standard deviation for each record
#### returns 66 measurement variables

colUse <- grep("\\bmean\\b|std", names(bData))
bDataUse <- bData[,c(1:2, colUse)]

####Task-3: Rewrites activity labels with descriptive activity names
#### uses activity names from the text file as lookup vector
#### indexes lookup vector with actLabel column with numbers

actLabels <- read.table("activity_labels.txt")
actLabelV <- actLabels$V2
bDataActivity <- actLabelV[bDataUse[,2]]
bDataUse[["actLabel"]] <- bDataActivity

####Task-4: Labels data set with descriptive variable names
#### step-by-step capitalizes and removes special characters
#### it is unnecessarily lengthy, sorry!

colNames <- gsub("BodyBody", "Body", names(bDataUse))
colnames(bDataUse) <- colNames
colNames <- gsub("-", "", names(bDataUse))
colnames(bDataUse) <- colNames
colNames <- gsub("\\(\\)", "", names(bDataUse))
colnames(bDataUse) <- colNames
colNames <- gsub("mean()", "Mean", names(bDataUse))
colnames(bDataUse) <- colNames
colNames <- gsub("std()", "Std", names(bDataUse))
colnames(bDataUse) <- colNames

####Task-5: tidy data set with the average of each variable 
#### for each activity and each subject
#### returns total 68 variables and (30*6=) 180 observations

tidydata <- bDataUse %>%
  group_by(subID, actLabel) %>%
  summarise_each(funs(mean))

### writes into a .txt file

write.table(tidydata, "tidydata.txt", row.names = FALSE)
  