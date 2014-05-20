CodeBook
===============

The data used in this dataset comes from readings from a Samsung Galaxy S II smartphone worn at the waist by 30 volunteers.

The data has been separated into two subsets, 70% of the volunteers were in the training set, and the remaining in the test set.

Of the Samsung dataset, only 8 files were used.

* features.txt

They are the features.txt file which contains a list of the features recorded by each subject. This includes info such as body acceleration and body jerk.

* y_test.txt and y_train.txt

These files list the activities performed when the data was collected, such as sitting or standing. This is coded as a number from 1-6.

* activity_labels.txt

This file translates the code of the activities performed in y_test.txt and y_train.txt, it is a list from 1-6 with the corresponding name for the activity.

* subject_test.txt and subject_train.txt

These files are a list showing which subject the corresponding data in x_test.txt and y_test.txt are from. It is a number from 1-30

* x_test.txt and y_test.txt

These files contain the readings collected for each feature in features.txt, with rows for each subject and activity

## Data not used

Overall, the inertial signals data found in the "Inertial Signals" folder within both the "test" and "train" folders were not used. 

This data is more detailed data about total acceleration, body accerlation and gyroscope readings.

## Units

The units of the measurements have all been normalized. They are unitless.

## Summary Choices

Of the 561 features. Only 86 have been examined. These 86 correspond to means and standard deviations obsserved in the Samsung readings.
This data includes all means, including angles of means. There are 6 angle measurements which find the angles between summarized data. I believe these should be included when examining the data about means, and so I have included them in the summary.

Furthermore, in the tidy dataset, these readings were averaged by Subject ID and Activity to summarize the data even further.

## Work Done to Clean Up Data

The steps in the Course Project assignment were followed to clean up the data. This involved:

* Merging the relevant data sources described above.

*Subsetting the data to only find mean and standard deviation related measurements.

* Replacing the Activity column numerical codes with text descriptions

* Changing the labels to remove special punctuations and converting to camelCase

* Averaging the data by Subject and Activity