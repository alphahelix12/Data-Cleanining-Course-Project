---
title: "ReadMe.md"
author: "Stu Pollack"
date: "July 22, 2015"
output: pdf_document
---

This document contains information about the run_analysis.R script. 

The programs requires the following packages beside base R to run.

library(plyr)
library(dplyr)
library(data.table)

and was developed and tested using RStudio running on a 
Mac Pro (Late 2013) OS X Yosemite Version 10.10.4

Location of the test and training data files:
"~/Desktop/Data Cleaning/Class project/UCI HAR Dataset/test"
"~/Desktop/Data Cleaning/Class project/UCI HAR Dataset/train"

The input files to this program includes:
=========================+++++++++++++++=++++++++++++++++++++++++++++++++++====
- 'subject_test.txt' : Each row identifies the subject who performed the activity in the  test dataset.
- 'X_test.txt': Test dataset of accelerometer measurements.
- 'y_test.txt': Test activity labels.
- 'subject_train.txt': Each row identifies the subject who performed the activity in the training dataset.
- 'X_train.txt': Training dataset of accelerometer measurements.
- 'y_train.txt': Training activity labels.
- 'activity_labels.txt': Links the class labels with their activity.
- 'features.txt': Shows descriptive column names for the variables used on the feature vector.

===================================================================================================

Notes: 
======
- The units are radians/second and are normalized and bounded within [-1,1]. 

Output:
======
The program produces one output file called summary.txt

This text file should read into R and viewed with the following code.

test <- read.table("summary.txt", header = TRUE)
View(test)

