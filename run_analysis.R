#The first thing i do is gather lables for everything that needs a lable
labels=read.delim("data/week4PRoject/UCI HAR Dataset/activity_labels.txt", header = FALSE,sep = " ")
features=read.delim("data/week4PRoject/UCI HAR Dataset/features.txt", header = FALSE,sep = " ")
features = as.array(features[c(1:3,4:6,41:46,81:86,121:126,161:166,201,202,214:215,227:228,240,241,253,254,266:271,345:350,424:429,503,504,516,517,529,530,542,543),2])

#the next step is to merge the sets of 2 seperate files into 1 using the rbind function
trainCat=read.delim("data/week4PRoject/UCI HAR Dataset/train/y_train.txt", header = FALSE)
testCat=read.delim("data/week4PRoject/UCI HAR Dataset/test/y_test.txt", header = FALSE)
categories = rbind(testCat,trainCat)

trainData = read.delim("data/week4PRoject/UCI HAR Dataset/train/X_train.txt", header = FALSE,sep = "",skipNul = TRUE)
testData = read.delim("data/week4PRoject/UCI HAR Dataset/test/X_test.txt", header = FALSE,sep = "",skipNul = TRUE)
movementData = rbind(testData,trainData)
movementData = movementData[,c(1:3,4:6,41:46,81:86,121:126,161:166,201,202,214:215,227:228,240,241,253,254,266:271,345:350,424:429,503,504,516,517,529,530,542,543)]

trainSubject = read.delim("data/week4PRoject/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
testSubject = read.delim("data/week4PRoject/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
movementSubject = rbind(testSubject,trainSubject)

#this first for loop replaces all lable numbers with thier matching activity.
for (i in 1:nrow(labels)){
  if (i == 1){
    #to avoid unnecesary coersion first case is handled specificaly
    categories = gsub(labels[i,1],labels[i,2],categories[,1])
  }
  else{
    #remaining cases handled the same
    categories = gsub(labels[i,1],labels[i,2],categories[])
  }
}

#now we combine our labels and our actual data
labeledMovement = data.frame(movementSubject,categories,movementData)
colnames(labeledMovement) = c("Subject", "Movement Type",as.character(features))

#The next step is to colapse the data set to turn the long data set into a concise one
#I am not sure if i did this as efficiently as possible but with my programming background this made sense
#Most of this is done using the dplyr package


IndividualData = labeledMovement[labeledMovement$Subject == 1, -(1)]
summaryOfData = group_by(IndividualData, as.factor(IndividualData$`Movement Type`))
summaryOfData
colapsed_data = summarize(summaryOfData, tBody_Mean = mean(summaryOfData$"tBodyAcc-mean()-X"), tBody_STD = mean(summaryOfData$"tBodyAcc-std()-X"), tGravity_Mean = mean(summaryOfData$"tBodyAcc-std()-Z"), tGravity_STD = mean(summaryOfData$"tGravityAcc-std()-X"), tBodyAccJerk_Mean = mean(summaryOfData$"tBodyAccJerk-mean()-X"), tBodyAccJerk_STD = mean(summaryOfData$"tBodyAccJerk-std()-X"), tBodyGyro_Mean = mean(summaryOfData$"tBodyGyro-mean()-X"), tBodyGyro_STD = mean(summaryOfData$"tBodyGyro-std()-X"), tBodyAccMag_Mean = mean(summaryOfData$"tBodyAccMag-mean()-X"), tBodyAccMag_STD = mean(summaryOfData$"tBodyAccMag-std()-X"))
colapsed_data$Subject <-1


for(i in 2:30){
  IndividualData = labeledMovement[labeledMovement$Subject == i, -(1)]
  summaryOfData = group_by(IndividualData, as.factor(IndividualData$`Movement Type`))
  summaryOfData
  hold = summarize(summaryOfData, tBody_Mean = mean(summaryOfData$"tBodyAcc-mean()-X"), tBody_STD = mean(summaryOfData$"tBodyAcc-std()-X"), tGravity_Mean = mean(summaryOfData$"tBodyAcc-std()-Z"), tGravity_STD = mean(summaryOfData$"tGravityAcc-std()-X"), tBodyAccJerk_Mean = mean(summaryOfData$"tBodyAccJerk-mean()-X"), tBodyAccJerk_STD = mean(summaryOfData$"tBodyAccJerk-std()-X"), tBodyGyro_Mean = mean(summaryOfData$"tBodyGyro-mean()-X"), tBodyGyro_STD = mean(summaryOfData$"tBodyGyro-std()-X"), tBodyAccMag_Mean = mean(summaryOfData$"tBodyAccMag-mean()-X"), tBodyAccMag_STD = mean(summaryOfData$"tBodyAccMag-std()-X"))
  hold$Subject <-i
  rbind(colapsed_data,hold)
}
write.csv(colapsed_data, file = "Tidy_Data_Set.csv")