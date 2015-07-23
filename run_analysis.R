#*******************************************************************
#     Data Cleaning Project 
#     Stu Pollack   7/23/2015
#*******************************************************************
options(warn=-1)
nwarnings = 0
#*******************************************************************
#************   Load packages  *************************************
 library(plyr)
 library(dplyr)
 library(data.table)
 #*********** Set the test data directory **************************
 getwd()
 setwd("~/Desktop/Data Cleaning/Class project/UCI HAR Dataset/test")
 list.files()
 #******************************************************************
 
 #*****************read the measurement test data*******************
 load_test_x <- read.table( "X_test.txt")
 test_x = data.table(load_test_x)
 #******************************************************************
 
 #****************reads subject id test data************************
 load_subject <- read.table( "subject_test.txt")
 subject_test = data.table(load_subject)
 names(subject_test)[1] <- "subject_id"
 #******************************************************************
 
 #************reads the activity test data**************************
 load_test_y <- read.table( "y_test.txt")
 test_y = data.table(load_test_y)
 names(test_y)[1] <- "activity"
 #******************************************************************
 
 #**********reads the activity label transformation data************* 
 activity_lables <- read.table( "activity_labels.txt")
 head(activity_lables)
 names(activity_lables)[1] <- "activity"
 head(activity_lables)
 #******************************************************************
 
 #************joins the activity with their lables******************
 test_y <- join(test_y, activity_lables) 
 names(test_y)[2] <- "label"
 head(test_y)
#*******************************************************************

#***column binds the subject ids, activivity and test data**********
dat_test <- cbind(subject_test, test_y, test_x)
data_test2 <- select(dat_test, subject_id, label, V1:V561)
names(data_test2)[2] <- "activity"
head(data_test2)

#************sets the training data directory***********************
setwd("~/Desktop/Data Cleaning/Class project/UCI HAR Dataset/train")
getwd()
list.files() 
#*******************************************************************

#********read the measurement test data*****************************
load_train_x <- read.table( "X_train.txt")
train_x = data.table(load_train_x)
#*******************************************************************

#****************reads subject id train data************************
load_subject <- read.table( "subject_train.txt")
subject_train = data.table(load_subject)
names(subject_train)[1] <- "subject_id"
#*******************************************************************

#************reads the activity train data**************************
load_train_y <- read.table( "y_train.txt")
train_y = data.table(load_train_y)
names(train_y)[1] <- "activity"
#*******************************************************************

#************joins the activity with their lables*******************
train_y <- join(train_y, activity_lables) 
names(train_y)[2] <- "label"
head(train_y) 
#*******************************************************************

#*****binds the subject ids, activivity and measuremnts together****
dat_train <- cbind(subject_train, train_y, train_x)
data_train2 <- select(dat_train, subject_id, label, V1:V561)
names(data_train2)[2] <- "activity"
head(data_train2)
#********************************************************************

#************stacks the two datasets*********************************
total <- rbind(data_test2, data_train2)
#********************************************************************

#*************add descriptive column names***************************
load_feature    <- read.table( "features.txt")
column_names    <- as.matrix(select(load_feature, V2))
all_data        <- select(total, subject_id, activity, V1:V561)

for (i in 1:dim(column_names))
{names(all_data)[i + 2] <-  column_names[i]} 

names(all_data)
#**********************************************************************

#**keep varibles with mean(), std() at end of variable  name *********
select_mean <- select(all_data, subject_id, activity, contains("-mean()"))
select_std  <- select(all_data, subject_id, activity, contains("-std()"))
final_detail_dataset <- cbind(select_mean, select_std)

#***********check final dataset *******************************************
distinct(final_detail_dataset, subject_id) #subjects all 30 are in the file 
distinct(final_detail_dataset, activity)   #activities all 6 are in the file 
#***************************************************************************

#********summarises the data by subject and activity*********************

summary_dataset <- group_by(final_detail_dataset, subject_id, activity) %>%
                   summarise_each(funs(mean)) %>%
                   arrange(subject_id)

View(summary_dataset)
dim(summary_dataset)
names(summary_dataset)

#******write the summary dataset as a text file********************************
summary_output <- write.table(summary_dataset, file = "summary.txt" ,row.name = FALSE)
list.files()
#++++++++++++++++++++++end-program+++++++++++++++++++++++++++++++++++++++++
