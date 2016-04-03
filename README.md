run_analysis script documentation

This script will create a tidy dataset summarizing the data found in the Samsung phone analysis decribed below: 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 


For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.
- 

********* High level summary of process:
1.	Tidy the “train” data with descriptive column names and adding a column to identify the activity 
2.	Tidy the “test” data with descriptive column names and adding a column to identify the activity
3.	Combine the two datasets into one dataset
4.	Create a dataset with only the pertinent columns of subject, activity, and any column containing “mean” or “std”
5.	Group the data by subject and activity
6.	Summarize by the means for all the columns in the dataset
7.	Write the data to a text file: run_analysis.txt 
********* Script Algorithm
This script works follows the following process (all code with comments can be found in run_analysis.R)
1.	Sets the working directly to ensure that the files can be found and saved in correct place.
2.	Loads “dplyr” library to be used for data manipulations
3.	Loads the file, x_train.txt, which contains the raw data for the readings described above.
4.	Creates a dataset called “id” which will be used as a unique identifier for each observation
5.	Loades the file, features.txt which contains the names of the columns for the x_train dataset
6.	Creates a dataset, xtrain, which is the x_train data with the correct column names from features and has a unique “id” for each observation
7.	Loads the file, y_train.txt, which contains the vector with all the coded activity for each observation
8.	Creates a dataset, ytrain, which is the y_train data with a column heading changed to “activity_code” and a unique “id”.
9.	Loads the file, activity_labels.txt, which are the descriptions for the activity codes that are referenced in step 8.
10.	Creates a dataset, ytrainact, which is a dataset containing the training activities codes and the description.
11.	Loads the file, sub_train.txt, which is a vector containing the number of the subject who participated in the study.
12.	Creates a dataset called subtrain which is a file with the column named to “subject” and a unique “id” for each observation.
13.	Creates a dataset, trainsubact, combining datasets, subtrain and ytrainact which contain the subject number and the activities with descriptions.
14.	Creates a dataset, trainall,  combining dataset, trainsubact and xtrain which contains all pertinent data for the train analysis. 
15.	Loads the file, x_test.txt, which contains the raw data for the readings described above.
16.	Creates a dataset called “id” which will be used as a unique identifier for each observation
17.	Loades the file, features.txt which contains the names of the columns for the x_test dataset
18.	Creates a dataset, xtest, which is the x_test data with the correct column names from features and has a unique “id” for each observation
19.	Loads the file, y_test.txt, which contains the vector with all the coded activity for each observation
20.	Creates a dataset, ytest, which is the y_test data with a column heading changed to “activity_code” and a unique “id”.
21.	Loads the file, activity_labels.txt, which are the descriptions for the activity codes that are referenced in step 8.
22.	Creates a dataset, ytestact, which is a dataset containing the testing activities codes and the description.
23.	Loads the file, sub_test.txt, which is a vector containing the number of the subject who participated in the study.
24.	Creates a dataset called subtest which is a file with the column named to “subject” and a unique “id” for each observation.
25.	Creates a dataset, testsubact, combining datasets, subtest and ytestact which contain the subject number and the activities with descriptions.
26.	Creates a dataset, testall,  combining dataset, testsubact and xtest which contains all pertinent data for the test analysis. 
27.	Creates a dataset, combined_data, which is both the train and test data in combined to one file
28.	Creates a dataset, finaldata, by selecting only the fields for the analysis which are those columns with mean or std in them, including the subject and activity.
29.	Creates a dataset, analyzedata, which does a group by subject and activity for the final tidy dataset
30.	Creates a dataset, run_analysis, by summarizing the data in step 20
31.	Exports the dataset to a text file: run_analysis.txt
The datasets used include the following files:
=========================================
-	'features_info.txt': Shows information about the variables used on the feature vector.
-	'features.txt': List of all features.
-	'activity_labels.txt': Links the class labels with their activity name.
-	'train/X_train.txt': Training set.
-	'train/y_train.txt': Training labels.
-	'test/X_test.txt': Test set.
-	'test/y_test.txt': Test labels.
-	'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
-	'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
-	'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
-	'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.
