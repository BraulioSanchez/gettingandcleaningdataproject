## Steps
1. Download the dataset if it does not already exist in the working directory.
2. Load the activity and feature info.
3. Loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation.
4. Loads the activity and subject data for each dataset, and merges those columns with the dataset.
5. Merges both datasets, the training and test.
6. Converts the `activity` and `subject` columns into factors.
7. Creates a tidy dataset that consists of the average of each variable for each activity and each subject.
8. Write those tidy dataset in the file `data_mean.txt`.
