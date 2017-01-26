# Getting and Cleaning Data Assignment

## Introduction
The purpose of this project is to prepare a tidy data set from accelerometer data from the <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">UCI Center for Machine Learning and Intelligent Systems</a>.

The repository contains the following files:

* README.md - this file.
* CodeBook.md - a code book to describe the variables of the data set and the processing carried out
* run_analysis.R - script to load and tidy the raw data and write the output to tidyAvg.txt
* tidyAvg.txt - a subset of the tidy data set consisting of average values for each subject and activity

## Tidy Data
The data is tidied by:

* adding descriptive column names
* coverting activity codes into desciptive labels
* removing special symbols from column names (parentheses and dashes)
* capitalizing letters to make column names more readable
* columns containing mean(), meanFreq() and std() are extracted into a smaller tidy data set. (The assignment instructions to extract the means is open to interpretation and so meanFreq variables were also included.)