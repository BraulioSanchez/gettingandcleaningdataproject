filename = "getdata_projectfiles.zip"
if (!file.exists(filename)){
  fileURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, destfile=filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

activities = read.table("./UCI HAR Dataset/activity_labels.txt", colClasses=c("integer", "character"))

features = read.table("./UCI HAR Dataset/features.txt", colClasses=c("integer", "character"))[,2]
#https://regex101.com/r/lAjXTl/3/
features.curated = grep("(.*mean.*|.*std.*)", features)
features.curated.names = features[features.curated]
#https://regex101.com/r/tcftUs/1
features.curated.names = gsub("-mean\\w*\\(\\)","MEAN", gsub("-std\\w*\\(\\)","STD", features[features.curated]))

train = read.table("./UCI HAR Dataset/train/X_train.txt")[,features.curated]
train.activities = read.table("./UCI HAR Dataset/train/y_train.txt")
train.subjects = read.table("./UCI HAR Dataset/train/subject_train.txt")
train = cbind(train.activities, train.subjects, train)

test = read.table("./UCI HAR Dataset/test/X_test.txt")[,features.curated]
test.activities = read.table("./UCI HAR Dataset/test/y_test.txt")
test.subjects = read.table("./UCI HAR Dataset/test/subject_test.txt")
test = cbind(test.activities, test.subjects, test)

data = rbind(train, test)
colnames(data) = c("activity", "subject", features.curated.names)

data$activity = factor(data$activity, levels=activities[,1], labels=activities[,2])
data$subject = as.factor(data$subject)

library(reshape2)

data.melted = melt(data, id=c("activity", "subject"))
data.mean = dcast(data.melted, activity + subject ~ variable, mean)

write.table(data.mean, "data_mean.txt", row.names=F)
