

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

df <- read.csv('titanic.csv')


impute_age <- function(age,class){
  out <- age
  for(i in 1:length(age)){
    if(is.na(age[i])){
      if(class[i] == 1){
        out[i] <- 37
      }else if(class[i] == 2){
        out[i] <- 29
      }else{
        out[i] <- 24
      }
    }else{
      out[i]<-age[i]
    }
  }
  return(out)
}

library(dplyr)
is.na(df['pclass'])
df[is.na(df['pclass']),]
df <- df[-1310,]

df[is.na(df['fare']),]
df <- df[-1226,]

fixed.ages <- impute_age(df$age, df$pclass)
df$age <- fixed.ages
df <- subset(df, select = -c(name, body, boat, home.dest, cabin, ticket))
df$sex <- factor(df$sex)
df$sex <- as.numeric(df$sex)
df$sex[df$sex == 1] <- 0
df$sex[df$sex == 2] <- 1

df[df$embarked == "", ]
df<- df[-c(169, 285), ]

df$embarked <- factor(df$embarked)
df$SFlag <- ifelse(df$embarked == "S", 1, 0)
df$CFlag <- ifelse(df$embarked == "C", 1, 0)
df$QFlag <- ifelse(df$embarked == "Q", 1, 0)

df <- df[,-8]

which(is.na(df), arr.ind=TRUE)
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

split = sample.split(df$age, SplitRatio = 0.70)

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
f <- as.formula(paste("survived ~", paste(n[!n %in% "survived"], collapse = " + ")))
f

net <- neuralnet(f, data=train, hidden=10, linear.output = FALSE)
# Predictions
# Use compute() to grab predictions useing your nn model on the test set. 
predictions <- compute(net, test[, -2])
predictions$net.result
# Check the head of the predicted values. You should notice that they are still probabilities.
head(predictions)
str(predictions)
predictions <- predictions$net.result
predictions <- data.frame(predictions)

# Apply the round function to the predicted values so you only 0s and 1s as your predicted classes.
predictions <- apply(predictions, 1, round)

# Use table() to create a confusion matrix of your predictions versus the real values
table(predictions, test$survived)

# Comparing Models
# Call the randomForest library
library(randomForest)
# set the Class column of the data as a factor (randomForest needs it to be a factor, 
# not an int like neural nets did. Then re-do the train/test split
test$survived <- factor(test$survived)
# Create a randomForest model with the new adjusted training data.
tree <- randomForest(survived ~ ., data=train)
# Use predict() to get the predicted values from your rf model.
treePredict <- predict(tree, test)
treePredict <- apply(data.frame(treePredict), 1, round)
# Use table() to create the confusion matrix.
table(treePredict, test$survived)
# How did the models compare?
# Same as heart, random forest performs a little better, and probably could perform even
# more accurate if some of the other predictors were included.