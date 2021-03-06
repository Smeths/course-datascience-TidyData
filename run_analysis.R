library(stringr)

# 1, Merges the training and the test sets to create one data set

# reading in train data sets
X_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")
# reading in test data sets
X_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")
# merging data sets
train_data <- cbind(subject_train,y_train,X_train)
test_data <- cbind(subject_test,y_test,X_test)
train_test_data <- rbind(train_data,test_data)

# 2, Extracts only the measurements on the mean and standard deviation for each measurement

colnames <- read.table("info/features.txt")
colindex <- grep("(mean|std)",colnames$V2)

mean_std_data <- c(1:2,colindex+2)

train_test_data <- train_test_data[,mean_std_data]

#4, Appropriately labels the data set with descriptive variable names

names <- c("Subject","Activity",colnames$V2[colindex])

colnames(train_test_data) <- names

#3, Uses descriptive activity names to name the activities in the data set

# Reading activity names table

activity_labels <- read.table("activity_labels.txt")
activity_labels[,2] <- as.character(activity_labels[,2])

# Cyclying through activities and changing numbers to activity description

for(i in 1:length(activity_labels[,1])) {
  activity_logic <- train_test_data$Activity==i
  train_test_data[activity_logic,]["Activity"] <- rep(as.character(activity_labels[i,2]),sum(activity_logic))
}

#5, Creates a second, independent tidy data set with the average of each variable for each activity and each subject

# Intialise average vector

averages <- data.frame(matrix(ncol = dim(train_test_data)[2], nrow = 180))

names <- c("Subject","Activity",paste("Average",colnames$V2[colindex]))

colnames(averages) <- names

#loop over the training and test data and find averages

count <- 1

for(i in 1:30) {
  for(j in 1:6) {
    averages[count,1] <- i
    averages[count,2] <- activity_labels[j,2]
    sub_act_logic <- train_test_data$Subject == i & train_test_data$Activity == activity_labels[j,2]
    averages[count,3:dim(train_test_data)[2]] <- apply(train_test_data[sub_act_logic,3:dim(train_test_data)[2]],2,mean)
    count <- count + 1
  }
}

#Writing output file

write.table(averages,file = "average.txt", row.name=FALSE)
