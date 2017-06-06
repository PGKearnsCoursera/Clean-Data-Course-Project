# Clean-Data-Course-Project
Course project for the Getting and Cleaning Data Course Project

As per the instructions there is only one script for this assignment.

run_analysis.R does the complete analysis and creates the file Tidy_Data_Set.csv
It does so in the following steps:
  1. Gather labels from the feature.txt, and labels from activity_labels.txt
    -done using the read.delim file
  
  2. Then the script combines test and training data.
    -it does this in 3 pieces
    -combine x data
    -combine y data
    -combine the subject data
    
  3. Then it finds the means and std that are requested to be stored in the data
    
  4. It starts to fill in non useful data, with the gathered labels.

  

NOTE  : This script uses the dplyr package so this needs to be installed prior to running
