---
output: html_document
---
#Data Cleaning  

A course project for Coursera "Getting and Cleaning Data" from Johns Hopkins, as part of tha Data Scientist suite

****

## Raw Data

### Source
For more information about this dataset contact: activityrecognition@smartlab.ws

The Coursera source for this is
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The permanent repository is at UC Irvine Machine learning:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphone

### Structure
The .tar file expands to four files and two subfolders, test and train. Under each is a directory "Intertial Signals" which we will ignore.

* 'README.txt'
* 'features_info.txt': Summary information about the variables 
* 'features.txt': List of all features.
* 'activity_labels.txt': factors (in our usage) for activity.

#### In the directories

* 'X_{dir}.txt': Data
* 'y_{dir}.txt': Labels
* 'subject_{dir}.txt': Each row identifies the particpant (from 1to 30). 

The test and train datasets were distinguished by participant

### License
> Use of this dataset in publications must be acknowledged by 
> referencing the following publication:

> Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and
> Jorge L. Reyes-Ortiz. 
> *Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.*
> International Workshop of Ambient Assisted Living (**IWAAL 2012**).  Vitoria-Gasteiz, Spain. Dec 2012

> *This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.*

*Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.*


## Variables and Values

The original measurements (X.txt) were presented as 561 normalized (i.e. unitless) values, combining events (time) and frequencies (fft, Fast Fourier Transform). From these, 86 were extracted based on the name (features.txt), declaring them to be mean and standard deviations of the measurements, by participant (Y.txt). 
The oringial files are not readable from a Windows 32-bit "notepad" application, but are straightforwardly handled by the R "read.table."

## Narrative of run_analyses.R

This version of "run_analyses" assumes that you have downloaded and unpacked the source archive from either site above. The name of the directory containing the README is placed in the environment as "LOCAL_DATA."  The files are read in to intermediate values.  

A series of name substitutions are made on the variable names, removing parentheses, commas, and other punctuation.  To reiterate the twostyles of measurements, the "t" and "f" prefixes are expanded out. There is an extraneous ")" at the 556th member of the list, which needed explicit removal.

To better manage memory, explicit intermediate removal and garbage collection are invoked. If memeory was strongly an issues, column selection could be done before building a data frame.  
Factors are associated from the activity definitions into each test and train preliminary frame, and subject IDs injected in. Just in case some analysis reconstruction may be needed to extract train v test sets, the final column "source" codes this as a numerical factor.

The merged data set is created combining both sets.

Desired measurements are identified by name construction (mean, Mean, and std being indicators) and the "keep" list of columns is generated.  The final tidy set is then this subset.





