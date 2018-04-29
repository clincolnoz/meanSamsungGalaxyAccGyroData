# meanSamsungGalaxyAccGyroData
script to get, clean and mean data from Samsung Galaxy accelerometer and gyroscope

an assignment for Johns Hopkins univeristy - data science course.

citation for original dataset is:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## packages
dplyr
tidyr
reshape2

## scripts
downloadFile.R - is called by run_analysis and downloads the zip file to subdirectory ./data
run_analysis.R - calls downloadFile.R, unzips file, reads in features.txt, activity_label.txt, test_xxx.txt, and train_xxx.txt, where xxx = X, subject and y. Merges data, assigns column names, removes duplicates and calcualtes mean of each variable grouped by subject and activity. 


