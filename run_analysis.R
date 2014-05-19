## First assuming that the original Samsung data is in the current
## directory as this R script, and this is the current working
## directory. 
## For this script to work, need to change the working directory 
## to be inside the unzipped folder
unzip("getdata_projectfiles_UCI HAR Dataset.zip")
setwd("UCI HAR Dataset")

## 1. Merge the training and the test sets to create one data set.
## Merged according to this image posted by community TA on forums
## https://coursera-forum-screenshots.s3.amazonaws.com/d3/2e01f0dc7c11e390ad71b4be1de5b8/Slide2.png
xtrain <- read.table("train/X_train.txt")
xtest <- read.table("test/X_test.txt")

data <- rbind(xtrain, xtest)

subjecttrain <- read.table("train/subject_train.txt")
subjecttest <- read.table("test/subject_test.txt")

subjectdata <- rbind(subjecttrain, subjecttest)

data <- cbind(data,subjectdata)

ytrain <- read.table("train/y_train.txt")
ytest <- read.table("test/y_test.txt")

ydata <- rbind(ytrain,ytest)

data <- cbind(data,ydata)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## First will choose features from features.txt that correspond
## to mean and std data
features <- read.table("features.txt")

## The following code selects the features with mean and std
## I have included all features with the words "mean" and "std", regardless of case
## I have included the "angle(... gravityMean)" features too as they involve means.
meanandstd <- features[grepl("mean", features$V2, ignore.case=TRUE)
                       | grepl("std", features$V2, ignore.case=TRUE),]

## Now to subset data with only the required features
## But need to keep the last two columns which correspond to
## Subject and Activity data
data <- cbind(data[meanandstd$V1],data[,(dim(data)[2]-1):dim(data)[2]])


## 3. Uses descriptive activity names to name the activities in the data set
## Again, will continue with Step 1, after this is done.
labels <- read.table("activity_labels.txt")

## "ydata" is a number from 1-6. Each has a corresponding activity label
## Using the factor function can create value labels (of type Factor)
## Factor done on the last column of data, the column of Activities
## Factor levels and labels taken from corresponding columns in labels object
data[,dim(data)[2]] <- factor(data[,dim(data)[2]], levels=labels$V1, labels=labels$V2)


## 4. Appropriately labels the data set with descriptive activity names. 
## Use features list from Step 2. Make appropriate label names
## First remove "(", ")" and "-". Then change "," to an underscore "_"
meanandstd <- gsub("\\(","",meanandstd$V2)
## Note the above command changed meanandstd to a vector

meanandstd <- gsub("\\)","",meanandstd)
meanandstd <- gsub("-","",meanandstd)

## change the "angleA,B" to be more clear
## so "angletBodyAccMean,gravity" will be "angleOftBodyAccMeanandgravity"
meanandstd <- gsub("angle","angleOf",meanandstd)
meanandstd <- gsub(",","And",meanandstd)

## will use camelCase, so changing lowercase to uppercase
meanandstd <- gsub("mean","Mean",meanandstd)
meanandstd <- gsub("std","Std",meanandstd)
meanandstd <- gsub("gravity","Gravity",meanandstd)


## Will use the meanandstd variable for column names
## But first will add names for the Subject and Activity columns
meanandstd <- c(meanandstd, "subjectID", "activity")

## Now to change the column names
colnames(data) <- meanandstd


## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidy <- aggregate(data[,1:(dim(data)[2]-2)], by=list(data$subjectID, data$activity), FUN=mean)

## Note this had moved the subjectID and activity columns of the original data
## to rows 1 and 2, and renamed the columns to Group.1 and Group.2
## The following code changes their names back to "subjectID" and "activity"
colnames(tidy)[1] = "subjectID"
colnames(tidy)[2] = "activity"

## Lastly, the following code exports the tidy table to a text file
## with tab separation, so it can be uploaded to coursera
write.table(tidy, "tidy.txt", sep="\t")

