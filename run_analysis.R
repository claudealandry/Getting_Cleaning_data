#Download the file from the url and saving it on the computer
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("Samsung_data")) {
    dir.create("Samsung_data")
}
setInternet2(TRUE)
download.file(fileUrl, destfile = ("~./Samsung_data/Samsung_dataset.zip"))
#Setting up a working directory by using dirname that eliminate any trailing file separators
dirname(file.path("Samsung_data"))
#Creating the working directory
setwd( "./Samsung_data")
\#Unzipping the file
unzip("Samsung_dataset.zip")

#Now the manipulation of the data
#The objective is to create one dataset that merge the training and the test sets into one dataset
#Loading the required packages to manipulate the data
library(dplyr)
library(reshape)
library(utils)
#Reading the train dataset
setwd("~/Samsung_data/UCI HAR Dataset/train")
mydata <- read.table("X_train.txt")

#Reading the test dataset
setwd("~/Samsung_data/UCI HAR Dataset/test")
mydata2 <- read.table("X_test.txt")

#Merging both dataset with bind_rows
mydata3 <- bind_rows(mydata, mydata2)

#Reading the features to extract the column names
setwd("~/Samsung_data/UCI HAR Dataset")
features <- read.table("features.txt")
features2 <- make.names(features[, 2]) #use make.names to create legal names for the columns

list.names <- as.character(t(features2))
for (i in seq_along(list.names)){
    names(mydata3)[i] <- list.names[i]
}
list.files("UCI HAR Dataset")
#assigning column names to each column

#Reading activity and subjects id train
setwd("~/Samsung_data/UCI HAR Dataset/train")
activity.id.train <- read.table("y_train.txt")
subject.id.train <- read.table("subject_train.txt")

#Reading activity and subjects id test
setwd("~/Samsung_data/UCI HAR Dataset/test")
activity.id.test <- read.table("y_test.txt")
subject.id.test <- read.table("subject_test.txt")

#Merging both activity and subjects id dataset
activity.id.combo <- bind_rows(activity.id.train, activity.id.test)
names(activity.id.combo) <- "Activities"  
subject.id.combo <- bind_rows(subject.id.train, subject.id.test)
names(subject.id.combo) <- "Subject_ID"
mydata.combo <- bind_cols(activity.id.combo, mydata3)
mydata.combo <- bind_cols(subject.id.combo, mydata.combo)

#assigning descriptive activities names through the creation of factor that convert the numerical values into factors
mydata.combo$Activities <- factor(mydata.combo$Activities, levels = c(1, 2, 3, 4, 5, 6), 
                                  labels = c("Walking", "Walking_Upstairs", "Walking_Downstairs", "Sitting", 
                                             "Standing", "Laying"))

#Extracting measurement on the mean and standard deviation
mydata.combo1 <- mydata.combo[, c(1:8, 43:48, 83:88, 123:128, 163:168, 203:204, 216:217, 229:230, 242:243, 255:256, 268:273, 347:352, 426:431, 505:506, 518:519, 531:532, 544:545)]

#END OF PART ONE

#New tidy data set that measure the average of each variable by activity and by Subject
mydata.combo2 <- arrange(mydata.combo1, Subject_ID, Activities) #Arrange the data by Subject ID then by activity
by.ID <- group_by(mydata.combo2, Subject_ID, Activities) #Group them by Subject ID then by activity
avg <- summarise_each(by.ID, funs(mean)) #Calculate the mean for each variable by Subject then by activity

#write.table(avg, "average_tidy_data_set.txt", row.names = FALSE)
