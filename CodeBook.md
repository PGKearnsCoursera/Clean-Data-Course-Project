There are several comments in my code describing different functionallity but the process is as follows

First i collect all necesary data.

Next i compile this into easy to work with sets according to the requirments 
	(This includes selecting out the mean and STD variables)
	
After i have my data i go about merging the data
	This is done mostly using dplyr functionality
	
Data is renamed for acuracy and finally printed to a output file


Variables

labels - list of the activities (WALKING, WALKING_UP, ect)
features - features of the actual data (STD, MEAN, of many diferent variables)

trainCat
testCat   - These 2 variables contain the activities of the tests

trainData
testData  - These 2 variables contain the worklog of activity of the tests

trainSubject 
testSubject  - These 2 variables contain the subjects of the tests

categories - a combined variable of the TrainCat and testCat sets

movementData - a combined variable of the trainData and testData sets

movementSubject - a combined variable of the trainSubject and testSubject data sets

labeledMovement - dat is labled with the types of activity

individualData - is all of the variables we care about on a specific person

summaryOfData - is a temporary home of sorted data

collapsed_data - the final variable that individuals are added to