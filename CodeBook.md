---
title: "CodeBook"
author: "Claude Landry"
date: "Saturday, June 20, 2015"
output: html_document
---
Data Code Book

Subject_ID :Anonymous identifier of the subjectwho carried out the experiment, label from 1 to 30

Activities :Description of the different activity monitored
        1 Walking
        2 Walking_Upstairs
        3 Walking_Downstairs
        4 Sitting
        5 Standing
        6 Laying

The DATA: From the original 561-feature vector with time and frequency domain variables, we only kept 66-feature vector with time and frequency domain variables that are either a mean or a standard deviation of a measurement.

The data is from  experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

MANIPULATION AND TRANSFORMATION EXECUTED ON THE DATA: To obtain this data set we needed to perform certain transformation.The objective of the exercice was to create one data set that merge the training and the test data sets into one data set. 
First, we needed to load the 2 data sets. 
Second, we merge all the data into one. 
Third, we extracted the columns names through the feature file and had to make sure to convert into legal column names.
Fourth, we assigned the descriptive column names to the data set.
Fifth, we retrieved the subject_ID and the activity label for both data set and merge them, then combine them with the full data set created earlier. 
Sixth, we identify each activity with a descriptive name. And, we extracted the measurements that were either a mean or a standard deviation. 
And finally, we calculated the average of each variable for each activity and each subject. 
The scripts is explained in the Read me file.
