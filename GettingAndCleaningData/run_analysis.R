# Author: Breno W. Carvalho

run_analysis <- function(){
    #read the test and train files
    test <-  read.csv("UCI HAR Dataset/test/X_test.txt",   header=FALSE, sep = "");
    train <- read.csv("UCI HAR Dataset/train/X_train.txt", header=FALSE, sep = "");

   # add column label to the datasets
    testY  <- read.csv("UCI HAR Dataset/test/y_test.txt",   header=FALSE, sep = "");
    trainY <- read.csv("UCI HAR Dataset/train/y_train.txt", header=FALSE, sep = "");

    # add column subject to the datasets
    testSubjects  <- read.csv("UCI HAR Dataset/test/subject_test.txt",   header=FALSE, sep = "");
    trainSubjects <- read.csv("UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep = "");

    test <- cbind(test,  testSubjects, testY);
    train<- cbind(train, trainSubjects, trainY);

    # merge the test and the train files
    data <- rbind(test,train);

    #select the means and standard deviation of the measures
    select_features <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201,202,
                         214, 215, 227,228, 240,241, 266,267, 345:350,
                         424:429,  452:454, 503,504, 542,543);
    num_features <- length(select_features)
    tidyData <-  data[, c(select_features, length(names(data)) + -1:0)];
   
    #rename the columns
    n <- read.csv("UCI HAR Dataset/features.txt", header=FALSE, sep = "");
    n <- c(paste(n[select_features, 2]), "subject", "Y");
    names(tidyData)  <- n;

    # aggregation step
    clusters<- list(tidyData$subject, tidyData$Y)
    aggData <- aggregate(data[, 1:num_features], clusters, mean);
   
    write.csv(tidyData, "HAR_Tidy.txt", row.names=FALSE);
    write.csv(aggData, "Aggregated_HAR_Tidy.txt", row.names=FALSE);

     tidyData
}