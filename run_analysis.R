## Collect, work with, and clean a data set. 
## The goal is to prepare "tidy data"
 
## Data Source
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Tasklist: 
## 1) Merges the training and the test sets to create one data set.
## 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3) Uses descriptive activity names
## 4) Appropriately label the data set with descriptive variable names. 
## 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
## 
 
## Since this gets posted publicly, I'll put a variable in the environement
## separate from the analysis file to  manage my local file structure

if (! exists(LOCAL_DATA, inherits = TRUE)) {
  #try to go to internet
  classUrl <- url("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
## other direct download refresh, create LOCAL_DATA
  } 

## based on directory structure
dataDir   <- dir(LOCAL_DATA)
testName  <- paste(LOCAL_DATA, "test/", sep = "")
testDir   <- dir(testName)
trainName <- paste(LOCAL_DATA, "train/", sep = "")
trainDir  <- dir(trainName)

Activities <- read.table(paste(LOCAL_DATA, dataDir[1], sep =""))[,2]
Measurements <-  read.table(paste(LOCAL_DATA, dataDir[2], sep =""))[,2]  
Subject.0 <- read.table(paste( testName,  testDir[2], sep =""))
Subject.1 <- read.table(paste(trainName, trainDir[2], sep =""))

      X.0 <- read.table(paste( testName,   testDir[3], sep =""))
      X.1 <- read.table(paste(trainName,  trainDir[3], sep =""))
      Y.0 <- read.table(paste( testName,   testDir[4], sep =""))
      Y.1 <- read.table(paste(trainName,  trainDir[4], sep =""))

## Let's pretty up the variable names from "Measurements"
## Rules: ^t = time domain
##        ^f = Fourier transform
##         Parentheses are not needed
##         Dashes are ok
##         Commas are right out.
## I find mixed case (camelCase) easier to read than all lower.
## We will assume that the files are in the correct order
## This is task #3
## make the prefixes nicer
   m.1 <- sub("^t", "time_", sub("^f", "fft_", Measurements))
## Parens. first remove "()" as it means nothing. Then (is helpful
## to indicate a variation. The end parenthesis is useless
##              
   m.2 <- sub("\\(", "_Of_", sub( ")", "", sub("\\()", "", m.1)))
##              ^ double slashes to escape the open parenthesis
## All together, and an extra look for")" to cover [556]
MeasureColNames <- sub(")", "", sub(",", "-", m.2))

rm(m.2)
rm(m.1)
   gc()
## Cleanup on aisle 1
## we add a column to track to source, just in case 
## Subject some from Subject.{0,1}, and we make factors readable 
## from the Y.N

Activity.0 <- factor(Y.0[,1], label=Activities)
Activity.1 <- factor(Y.1[,1], label=Activities)

data.f0 <- data.frame(cbind(Subject.0, Activity.0, X.0, 0))
data.f1 <- data.frame(cbind(Subject.1, Activity.1, X.1, 1))
## This is task 4
Names <- c("Subject", "Activity", MeasureColNames, "source")
names(data.f0) <- Names
names(data.f1) <- Names

## Now, Task #1. It would be more memory efficient to have removed
## unneeded columns first, but I wanted to maintain the set as long
##as possible, so no mismatch would be likely

HAR_tidyALL.df <- rbind(data.f0, data.f1)

## Now, we do task #2, focus on only the columns with "mean" or "std" 
## in the name. Also, keep the first two, and the last one = 564
keepColumns <- c( 1, 2, 
                  sort(c(grep("Mean", MeasureColNames), 
                      grep("mean", MeasureColNames), 
                      grep("std", MeasureColNames))
                    ) +2, 564)
HAR_tidy.df <- HAR_tidyALL.df[,keepColumns]
##
## Final cleanup (putting this into a function would 
##                make this go away.)
rm(HAR_tidyALL.df)
rmlist <- list("Subject.0", "Subject.1", "MeasureColNames")
rm("keepColumns", list = rmlist)
gc()

write.table(HAR_tidy.df, "HAR_tidy.txt", row.names=FALSE)
return(HAR_tidy.df)




