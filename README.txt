==================================================================
Summary of Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
SWSRN (my "name" and address)

Thanks to, for the original dataset:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

Modified from the READ_ME.txt of the original data set:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

 (ADDITIONAL FILES IN "INTERTIAL SIGNALS" SUBDIRECTORIES ARE NOT USED BY THIS SCRIPT.)
 
- 'means.txt': the resulting set of means of means and standard deviation features.
 
 Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws


FOR THIS SCRIPT, THE NEW META-SUMMARY DATA IS SUMMARIZED BY LIMITING CONSIDERATION TO
=====================================================================================
- For input: the first 7 data files given above containing preliminary analysis and supporting files.

- The non-measurement variables are those identifying the activity and the subject. 

- Only those measurement variables containing "mean" and "std" are used.

- The new dataset 'means.txt' which 
	* for each subset of feature measurements with the same subject and same activity.
	  (no distinction was made for training vs. test.)
	* calculate the mean of this subset for every variables containing "mean" and "std".
	

