

## Coursera Project

setwd("C:/Users/Bill/Documents/Coursera/Course 3 Data Cleansing/Project") # set directory with sources files

library(dplyr) # loads the dply library for easier data minipulation

## The study data is broken into 2 groups 70% in the Training group and 30% in the Test group
## This script will tidy both groups into one tidy dataset with 


##Creates a data table called xtrain that has unique id and column names
x_train <-read.table("train/X_train.txt") #Contains the raw data with DIM 7352 rows and 561 colums
##setting up a unique "id" to preserve the order of the data in the datesets.
## This will be used to ensure that the correct columns will be alinged with the correct rows in merges
id <-as.numeric(rownames(x_train))

features <-read.table("features.txt")#Contains the column names for the 561 columns in the "X" files :)
colnames(x_train) <-features [,2] #Adds column names for the x_train table
xtrain <-cbind(id, x_train)

##Creates a data table called ytrain that has unique id and column names for the activity 
y_train <-read.table("train/Y_train.txt") #Identifies what activity was being used 1-6 numbers.
colnames(y_train) <- ("activity_code") #renames column to activity_code
ytrain <-cbind(id, y_train) #adds unique id number

##Creates a data table to put actual description for the activity
activity_labels <-read.table("activity_labels.txt")# Contains the activity description for the 6 coded activities 
activity_labels <-rename(activity_labels, activity_code = V1, activity = V2)#changes the name of the column from V2 to activity.
ytrainact <-merge(ytrain, activity_labels, by = ("activity_code"))#creates table with activity name column


##Creates a data table with the person in the training who is identified by a number called subject
sub_train <-read.table("train/subject_train.txt") #Identifies the subject number of the participant
colnames(sub_train) <-("subject") #renames column to subject
subtrain <-cbind(id, sub_train)#adds unique "id"


trainsubact <-merge(subtrain, ytrainact, by = ("id"))#Creates a data table with id, subject number, activity code, and activity

trainall <-merge(trainsubact, xtrain, by = ("id"))#Creates a tidy data table with all data for the "train" group 

#############    THIS WILL PREPARE DATA FOR TEST GROUP   

##Creates a data table called xtest that has unique id and column names
x_test <-read.table("test/X_test.txt") #Contains the raw data 
#setting up a unique "id" to preserve the order of the data in the datesets.
## This will be used to ensure that the correct columns will be alinged with the correct rows in merges
idprep <-as.numeric(rownames(x_test)) #automatically gets how many rows in x_test
id <-idprep + 10000 #increments by 10,000 so the "id" do not overlap with the train id's
features <-read.table("features.txt")#Contains the column names for the 561 columns in the "X" files :)
colnames(x_test) <-features [,2] #Adds column names for the x_test table
xtest <-cbind(id, x_test)

##Creates a data table called ytest that has unique id and column names for the activity 
y_test <-read.table("test/Y_test.txt") #Identifies what activity was being used 1-6 numbers.
colnames(y_test) <- ("activity_code") #renames column to activity_code
ytest <-cbind(id, y_test) #adds unique id number

##
activity_labels <-read.table("activity_labels.txt")# Contains the activity description for the 6 coded activities 
activity_labels <-rename(activity_labels, activity_code = V1, activity = V2)#changes the name of the column from V2 to activity.
ytestact <-merge(ytest, activity_labels, by = ("activity_code"))

##Creates a data table with the person in the test who is identified by a number called subject
sub_test <-read.table("test/subject_test.txt") #Identifies the subject number of the 30 participants
colnames(sub_test) <-("subject") #renames column to subject
subtest <-cbind(id, sub_test)


testsubact <-merge(subtest, ytestact, by = ("id"))#Creates a data table with id, subject number, activity code, and activity

testall <-merge(testsubact, xtest, by = ("id"))#Creates a tidy data table with all data for the "test" group 


##########      THIS WILL COMBINE THE 2 DATASETS TRAIN AND TEST INTO 1 with only required columns

combinded_data <-merge(trainall, testall, all=TRUE) #Combines data sets

finaldata <-select(combinded_data, subject, activity, contains("mean"), contains("std")) #creates a dataset with only the required fields of those contarining mean or std

##########      THIS WILL create a Tidy data table with summarized data    

analyzedata <-group_by(finaldata, subject, activity)#Creates dataset to be able to summarize the data by the subject and activity

run_analysis <-(analyzedata %>% summarize_each(funs(mean)))#Creates Tidy dataset with averages of each variable

write.table(run_analysis, file='run_analysis.txt', row.name=FALSE)






