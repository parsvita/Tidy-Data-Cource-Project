##
#       General Plan:
#       1) Read the Data files, Activities dictionary, Features Dictionaries, Subject (ids only)
#       2) Shrink the data, take only columns wich is needed
#       3) merge the data with Activities and Subjects
#       4) make the means of each Features for each Subject*Activity 
##

library(dplyr)

##check if the files already exists in the working dir. If not => download and unzip it.
ZipFileName <- "getdata_dataset2.zip"
if (!file.exists(ZipFileName)){
        download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                      destfile=ZipFileName,
                      method="auto") 
}  
##check the folder
if (!file.exists("UCI HAR Dataset")) { 
        unzip(ZipFileName, overwrite = T) 
}

##Set the local Path to the files with data
dataPath <- "UCI HAR Dataset"



##Read and Merge the Data

# read features, don't convert text labels to factors
FeatureNames <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)



##Read Subjects (first training data, then test data)
Subject <- rbind(
                read.table(file.path(dataPath, "train", "subject_train.txt")),
                read.table(file.path(dataPath, "test", "subject_test.txt"))
        )
colnames(Subject) <- "Subject" ##Assign the column name

##Read Activity (first training data, then test data)
Activity <- rbind(
                read.table(file.path(dataPath, "train", "y_train.txt")),
                read.table(file.path(dataPath, "test", "y_test.txt"))
        
        )
colnames(Activity) <- "Id" ##Assign the column name

# read activity labels
ActivityLabels <- read.table(file.path(dataPath, "activity_labels.txt"))
colnames(ActivityLabels) <- c("Id", "Label")
ActivityLabels$Label <- gsub("_","",ActivityLabels$Label)


#expand the Activity ids with Activity Names
Activity <- plyr::join(Activity,ActivityLabels,by = "Id")
#Make Actyvity names instead of the Actyvity Ids
Activity <- Activity[,2]



##Read Data(first training data, then test data)
Data <- rbind(
                read.table(file.path(dataPath, "train", "X_train.txt")),
                read.table(file.path(dataPath, "test", "X_test.txt"))
        )

############################

##create the logical vector which wil be used for the obtaining just needed columns 
##(Mean and Standad Deviation values of the features)
DataColVector <- grepl("std|mean",FeatureNames[,2])

Data <- Data[,DataColVector]
##make the same with the Features
FeatureNames <- FeatureNames[DataColVector,]


##Make the Names of the Futures a bit better
FeatureNames <- FeatureNames[,2]  ##truncate first collumn
FeatureNames <- gsub("[\\(\\)-]", "", FeatureNames) ## remove unwanted symbols


FeatureNames <- gsub("^f", "FrequencyDomain", 
                gsub("^t", "TimeDomain", 
                gsub("Acc", "Accelerometer", 
                gsub("Gyro", "Gyroscope", 
                gsub("Mag", "Magnitude", 
                gsub("Freq", "Frequency", 
                gsub("mean", "Mean", 
                gsub("std", "StandardDeviation", FeatureNames))))))))
        
colnames(Data) <-  FeatureNames       



##Make one table from Data, Subjects and Activity
Data <- cbind(Subject,Activity,Data)


##Make the Means of each Feature for the Subject per Activity
TidyData <- group_by(Data,Subject,Activity) %>%
            summarize_each(funs(mean)) %>% 
            ungroup


##Save the file
write.table(TidyData, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)

########################## END




