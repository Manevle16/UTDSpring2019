### Neural Net Project

# We'll use the Bank Authentication Data Set from the UCI repository.

# The data consists of 5 columns:
  
# variance of Wavelet Transformed image (continuous)
# skewness of Wavelet Transformed image (continuous)
# curtosis of Wavelet Transformed image (continuous)
# entropy of image (continuous)
# class (integer)
# Where class indicates whether or not a Bank Note was authentic.

# Get the Data
# Use read.csv to read the bank_note_data.csv file.
df <- read.csv('bank_note_data.csv')
# Check the head of the data frame and its structure.
head(df)

# EDA
# Create whatever visualizations you are interested in. 
# the data isn't easily interpretable since its just statistical info on images.
pairs(df)

# Train Test Split
# Use the caTools library to split the data into training and testing sets.
library(caTools)
library(dplyr)

split = sample.split(df$variance, SplitRatio = 0.70)

train = subset(df, split == TRUE)
test = subset(df, split == FALSE)

# Check the structure of the train data and note that Class is still an 
# int data type. We won't convert it to a factor for now because the neural 
# net requires all numeric information.

# Building the Neural Net
# Call the neuralnet library
library(neuralnet)
# Browse through the documentation of neuralnet
help("neuralnet")
# Use the neuralnet function to train a neural net, set linear.output=FALSe and choose 
# 10 hidden neurons (hidden=10)
n <- names(train)
n
# Paste together
f <- as.formula(paste("class ~", paste(n[!n %in% "class"], collapse = " + ")))
f

net <- neuralnet(f, data=train, hidden=10, linear.output = FALSE)
# Predictions
# Use compute() to grab predictions useing your nn model on the test set. 
predictions <- compute(net, test[1:4])

# Check the head of the predicted values. You should notice that they are still probabilities.
head(predictions)
str(predictions)
predictions <- predictions[2]
predictions <- data.frame(predictions)
dim(predictions)
# Apply the round function to the predicted values so you only 0s and 1s as your predicted classes.
predictions <- apply(predictions, 1, round)

# Use table() to create a confusion matrix of your predictions versus the real values
table(predictions, test$class)

# Comparing Models
# Call the randomForest library
library(randomForest)
# set the Class column of the data as a factor (randomForest needs it to be a factor, 
# not an int like neural nets did. Then re-do the train/test split
test$class <- factor(test$class)
# Create a randomForest model with the new adjusted training data.
tree <- randomForest(class ~ ., data=train)
# Use predict() to get the predicted values from your rf model.
treePredict <- data.frame(predict(tree, test))
treePredict <- apply(treePredict, 1, round)
# Use table() to create the confusion matrix.
table(treePredict, test$class)
# How did the models compare?
# Random forest is not much worse only having 2 mistakes while the nueral net had
# no mistakes.




