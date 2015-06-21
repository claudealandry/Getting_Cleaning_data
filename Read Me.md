---
title: "READ ME"
author: "Claude Landry"
date: "Saturday, June 20, 2015"
output: html_document
---


To obtain this data set we needed to perform certain transformation.

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
