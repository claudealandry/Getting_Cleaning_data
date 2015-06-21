---
title: "CodeBook"
author: "Claude Landry"
date: "Saturday, June 20, 2015"
output: html_document
---
Subject_ID :Anonymous identifier of the subjectwho carried out the experiment, label from 1 to 30

Activities :Description of the different activity monitored
        1 Walking
        2 Walking_Upstairs
        3 Walking_Downstairs
        4 Sitting
        5 Standing
        6 Laying



The data is from  experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

From the original 561-feature vector with time and frequency domain variables, we only kept 66-feature vector with time and frequency domain variables that are either a mean or a standard deviation of a measurement.

To obtain this data set we needed to perform certain transformation.The objective of the exercice was to create one data set that merge the training and the test data sets into one data set. First we needed to load the 2 data sets. Secong, we merge all the data into one. Third, we extracted the columns names through the feature file and had to make sure to convert into legal column names.Fourth, we assigned the descriptive column names to the data set.Fifth, we retrieved the subject_ID and the activity label for both data set and merge them then combine them with the full data set created earlier. Sixth, we identify each activity with a descriptive name. And finally, we extracted the measurements that were either a mean or a standard deviation. The scripts is below and also in the Reads me file.

```{r}
#The objective is to create one dataset that merge the training and the test sets into one dataset
#Loading the required packages to manipulate the data
library(dplyr)
library(reshape)
library(utils)
```

```{r}
#Reading the train dataset
setwd("~/a_MOOC/Coursera classes/Getting and cleaning data/Samsung_data")
mydata <- read.table("X_train.txt")

```

```{r}
#Reading the test dataset
mydata2 <- read.table("X_test.txt")

```

```{r}
#Merging both dataset with bind_rows
mydata3 <- bind_rows(mydata, mydata2)

```

```{r}
#Reading the features to extract the column names
features <- read.table("features.txt")
features2 <- make.names(features[, 2]) #use make.names to create legal names for the columns

list.names <- as.character(t(features2))
for (i in seq_along(list.names)){
    names(mydata3)[i] <- list.names[i]
}
#assigning column names to each column

```

```{r}
#Reading activity and subjects id from training data set
activity.id.train <- read.table("y_train.txt")
subject.id.train <- read.table("subject_train.txt")

```

```{r}
#Reading activity and subjects id test data set
activity.id.test <- read.table("y_test.txt")
subject.id.test <- read.table("subject_test.txt")
```

```{r}
#Merging both activity and subjects id dataset
activity.id.combo <- bind_rows(activity.id.train, activity.id.test)
names(activity.id.combo) <- "Activities"  
subject.id.combo <- bind_rows(subject.id.train, subject.id.test)
names(subject.id.combo) <- "Subject_ID"
#Merging these two new columns to all the data
mydata.combo <- bind_cols(activity.id.combo, mydata3)
mydata.combo <- bind_cols(subject.id.combo, mydata.combo)

```

```{r}
#assigning descriptive activities names through the creation of factor that convert the numerical values into factors
mydata.combo$Activities <- factor(mydata.combo$Activities, levels = c(1, 2, 3, 4, 5, 6), 
                            labels = c("Walking", "Walking_Upstairs", "Walking_Downstairs", "Sitting", 
                                       "Standing", "Laying"))

```

```{r}
#Extracting measurement on the mean and standard deviation the hard way!!!
mydata.combo1 <- mydata.combo[, c(1:8, 43:48, 83:88, 123:128, 163:168, 203:204, 216:217, 229:230, 242:243, 255:256, 268:273, 347:352, 426:431, 505:506, 518:519, 531:532, 544:545)]

#END OF PART ONE

```

```{r}
#New tidy data set that measure the average of each variable by activity and by Subject
mydata.combo2 <- arrange(mydata.combo1, Subject_ID, Activities) #Arrange the data by Subject ID, then by activity
by.ID <- group_by(mydata.combo2, Subject_ID, Activities) #Group them by Subject ID, then by activity
avg <- summarise_each(by.ID, funs(mean)) #Calculate the mean for each variable by Subject, then by activity

```

```{r}


```
