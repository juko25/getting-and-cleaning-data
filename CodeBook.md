## Original Data

### Overview:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' 

For each record, the following is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### Features:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  

'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domin signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

[Source](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Script Goal
A tidy data set containing the averages of selected variables by subject and activity. 

## Script Walkthrough
**Step 1: Download and Read Files**

The files in the original data set are downloaded and the following files are read in:

* features.txt *(name: features)*
* activity_labels.txt *(name: activityLabels)*
* X_train.txt *(name: trainValues)*
* Y_train.txt *(name: trainActivity)*
* subject_train.txt *(name: trainSubjects)*
* X_test.txt *(name: testValues)*
* Y_test.txt *(name: testActivity)*
* subject_test.txt *(name: testSubjects)*

_For this script, the other data files were disregarded._

The *Subject_* files denote the subject for the experiment, the *Y_*  files denote the activity done, and the *X_* files contain data for 561 variables. 

**Step 2: Merge Files**

In the original experiment, the 30 participants were randomly partitioned to generate a "test" cohort and a "training" cohort. This part of the script combines both sets into one file with data on all participants. 

**Step 3: Extract Columns**

From the merged data set, only the measurements containing a *mean* or *std* were collected. This includes *meanFreq()* measurements as well. 

**Step 4: Descriptive Activity Names**

The values in the "Activity" column were replaced with the corresponding Activity Label as follows:

1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

**Step 5: Descriptive Variable Names**

The measurement variable were renamed for readability in the following manner:

* *t* prefix replaced with *time*
* *f* prefix replaced with *frequency*
* *gyro* replaced with *gyroscope*
* *acc* replaced with *accelerometer*
* *mag* replaced with *magnitude*
* *bodybody* replaced with *body*

**Step 6: Variable Averages by Activity and Subject**

A new, tidy data set is created by computing the average of each variable by subject and activity. This new data set is then written to a file called "tidyData.txt"

## Output Data

The output data set contains 81 variables:

_Subject_

_Activity_

79 measurements:

   * TimeBodyAccelerometer.mean (X,Y, and Z)
   * TimeBodyAccelerometer.std (X,Y, and Z)
   * TimeGravityAccelerometer.mean (X,Y and Z)
   * TimeGravityAccelerometer.std (X,Y, and Z)
   * TimeBodyAccelerometerJerk.mean (X,Y, and Z)
   * TimeBodyAccelerometerJerk.std (X,Y, and Z)
   * TimeBodyGyroscope.mean (X,Y, and Z)
   * TimeBodyGryoscope.std (X,Y, and Z)
   * TimeBodyAccelerometerMagnitude.mean
   * TimeBodyAccelerometerMagnitude.std
   * TimeGravityAccelerometerMagnitude.mean
   * TimeGravityAccelerometerMagnitude.std
   * TimeBodyAccelerometerJerkMagnitude.mean
   * TimeBodyAccelerometerJerkMagnitude.std
   * TimeBodyGyroscopeMagnitude.mean
   * TimeBodyGyroscopeMagnitude.std
   * TimeBodyGyroscopeJerkMagnitude.mean
   * TimeBodyGyroscopeJerkMagnitude.std
   * FrequencyBodyAccelerometer.mean (X,Y, and Z)
   * FrequencyBodyAccelerometer.std (X,Y, and Z)
   * FrequencyBodyAccelerometer.meanFreq (X,Y, and Z)
   * FrequencyBodyAccelerometerJerk.mean (X, Y, and Z)
   * FrequencyBodyAccelerometerJerk.std (X, Y, and Z)
   * FrequencyBodyAccelerometerJerk.meanFreq (X, Y, and Z)
   * FrequencyBodyGyroscope.mean (X,Y, and Z)
   * FrequencyBodyGyroscope.std (X,Y, and Z)
   * FrequencyBodyGyroscope.meanFreq (X, Y, and Z)
   * FrequencyBodyAccelerometerMagnitude.mean
   * FrequencyBodyAccelerometerMagnitude.std
   * FrequencyBodyAccelerometerMagnitude.meanFreq
   * FrequencyBodyAccelerometerJerkMagnitude.mean
   * FrequencyBodyAccelerometerJerkMagnitude.std
   * FrequencyBodyAccelerometerJerkMagnitude.meanFreq
   * FrequencyBodyGyroscopeMagnitude.mean
   * FrequencyBodyGyroscopeMagnitude.std
   * FrequencyBodyGyroscopeMagnitude.meanFreq
   * FrequencyBodyGyroscopeJerkMagnitude.mean
   * FrequencyBodyGyroscopeJerkMagnitude.std
   * FrequencyBodyGyroscopeJerkMagnitude.meanFreq

