The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. 

submission: 
1. a tidy data set, 
2. a link to a Github repository with your script for performing the analysis
3. a code book (CodeBook.md) that describes the variables, the data, and any transformations or work that you performed to clean the data. 
4. a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

The data is from a Human Activity Research project. Teh "Codebook" in this directory contains links.

HAR_tidy.txt was generated from R on a 32-bit Windows device. Line feeds are not generated, so "notepad" renders it as a long text, but still recognizable. Each variable had already been normalized in the original data set to be in {-1, +1}.  The final column, "source," refers to whether the data was delivered in the training set (source = 1) or test set (source = 0) before merging. The sets were defined by subject.