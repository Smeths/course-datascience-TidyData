The r script run_analysis.R will take data in from the following files

* activity_labels.txt
* subject_test.txt
* subject_train.txt
* X_test.txt
* X_train.txt
* y_test.txt
* y_train.txt
* info/features.txt

The script performs the following tasks

1. Merges the training and test data
2. Extracts the mean accelerations and the standard deviation data
3. Calculates averages of this data per subject and per activity
4. Outputs these averages to activiy.txt



