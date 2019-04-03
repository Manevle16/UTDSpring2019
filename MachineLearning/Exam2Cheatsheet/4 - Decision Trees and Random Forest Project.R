# Call the ISLR library and check the head of College (a built-in data frame 
# with ISLR, use data() to check this.) Then reassign College to a dataframe 
# called df
library(ISLR)
head(College)
df <- College
# EDA
# Let's explore the data!
# Create a scatterplot of Grad.Rate versus Room.Board, colored by the 
# Private column.
library(ggplot2)
ggplot(df) + geom_point(aes(x=Grad.Rate, y=Room.Board, color = factor(Private)))

# Create a histogram of full time undergrad students, color by Private.
ggplot(df) + geom_histogram(aes(x=F.Undergrad, fill = factor(Private)))

# Create a histogram of Grad.Rate colored by Private. You should see something odd here.
ggplot(df) + geom_histogram(aes(x=Grad.Rate, fill=factor(Private)))

# What college had a Graduation Rate of above 100% ?
library(dplyr)
df[df[,'Grad.Rate'] > 100,]
# Cazenovia College

# Change that college's grad rate to 100% 
df$Grad.Rate[df$Grad.Rate > 100] <- 100

# Train Test Split
# Split your data into training and testing sets 70/30. Use the caTools 
# library to do this.
library(caTools)

split <- sample.split(df$Private, .7)
df.train <- subset(df, split == TRUE)
df.test <- subset(df, split == FALSE)

# Decision Tree
# Use the rpart library to build a decision tree to predict whether or not a 
# school is Private. Remember to only build your tree off the training data.
library(rpart)

tree <- rpart(Private ~ ., method='class', df.train)
summary(tree)
# Use predict() to predict the Private label on the test data.
predictions <- data.frame(predict(tree, df.test))

# Check the Head of the predicted values. You should notice that you actually have two columns with the probabilities.
head(predictions)

# Turn these two columns into one column to match the original Yes/No Label 
# for a Private column.

predictions$Yes[predictions$Yes >= .5] <- "Yes"
predictions$Yes[predictions$Yes < .5] <- "No"
predictions <- predictions$Yes
# Lots of ways to do this
joiner <- function(x){
  if (x>=0.5){
    return('Yes')
  }else{
    return("No")
  }
}
tree.preds$Private <- sapply(tree.preds$Yes,joiner)
head(tree.preds)

# Now use table() to create a confusion matrix of your tree model.
table(df.test$Private, predictions)

# Use the rpart.plot library and the prp() function to plot out your tree 
# model.

library(rpart.plot)
prp(tree)
# Random Forest
# Now let's build out a random forest model!
# Call the randomForest package library
library(randomForest)


# Now use randomForest() to build out a model to predict Private class. 
# Add importance=TRUE as a parameter in the model. (Use help(randomForest) 
# to find out what this does.
randTree <- randomForest(Private ~ ., importance=TRUE, df.train)

# What was your model's confusion matrix on its own training set? 
# Use model$confusion. 
randTree$confusion

# Grab the feature importance with model$importance. Refer to the reading 
# for more info on what Gini[1] means.[2] 
randTree$importance

# Predictions
# Now use your random forest model to predict on your test set!
randPredict <- predict(randTree, df.test)
length(randPredict)
table( df.test$Private, randPredict)

# It should have performed better than just a single tree, how much better 
# depends on whether you are emasuring recall, precision, or accuracy as 
# the most important measure of the model.



#Ref: www.pieriandata.com