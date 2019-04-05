library(ISLR)
df <- Auto
# iv) Set up train and test sets with 80% training using a seed
library(caTools)
library(dplyr)
df$origin <- factor(df$origin)
split = sample.split(df$mpg, .8)
df.train = subset(df, split == TRUE)
df.test = subset(df, split == FALSE)

# v) Create LR model on training where AHD is predicted by all other variables
library(nnet)
model = multinom(origin ~ ., data = df.train[,c(-7, -9)])
# vi) Run a summary of the model
summary(model)
# vii) Predict Yes/No on the test data
predictions <- predict(model, df.test, type = 'class')

# viii) Compute the accuracy
accuracy <- 1 - mean(df.test$origin != predictions)

table(df.test$origin, predictions)
