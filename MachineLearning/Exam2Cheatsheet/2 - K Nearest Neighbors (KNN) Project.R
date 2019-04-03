# KNN Project

# Since KNN is such a simple algorithm, we will just use this "Project" as a 
# simple exercise to test your understanding of the implementation of KNN. 
# By now you should feel comfortable implementing a machine learning 
# algorithm in R, as long as you know what library to use for it.

# So for this project, just follow along with the bolded instructions. 
# Get the Iris Data Set

# We'll use the famous iris data set for this project. It's a small data set 
# with flower features that can be used to attempt to predict the species of 
# an iris flower.

# Use the ISLR libary to get the iris data set. Check the head of the iris 
# Data Frame.

library(ISLR)
head(iris)

# Standardize Data
# In this case, the iris data set has all its features in the same order of  
# magnitude, but its good practice (especially with KNN) to standardize 
# features in your data. Lets go ahead and do this even though its not 
# necessary for this data!

iris <- iris

# Use scale() to standardize the feature columns of the iris dataset. 
# Set this standardized version of the data as a new variable.

data.iris <- scale(iris[,-5])


# Check that the scaling worked by checking the variance of one of the new 
# columns

var(data.iris[,1])

# Join the standardized data with the response/target/label column 
# (the column with the species names.

data.iris <- cbind(data.iris, data.frame(iris$Species))
colnames(data.iris) <- colnames(iris)
####################
# Train and Test Splits
library(caTools)
library(dplyr)
# Use the caTools library to split your standardized data into train and 
# test sets. Use a 70/30 split.
split <- sample.split(data.iris$Species, SplitRatio=.7)
data.train <- subset(data.iris, split == TRUE)
data.test <- subset(data.iris, split==FALSE)

# Build a KNN model.
library(class)

# Use the knn function to predict Species of the test set. Use k=1 


data.predicted <- knn(data.train[,-5], data.test[,-5], data.train$Species, k=1)

# What was your misclassification rate?
misclassification <- mean(data.test$Species != data.predicted)
misclassification
# Choosing a K Value
# Although our data is quite small for us to really get a feel for choosing 
# a good K value, let's practice.

# Create a plot of the error (misclassification) rate for k values ranging 
# from 1 to 10.
library(ggplot2)
kvalues <- NULL
data.predicted <- NULL
for( i in 1:10){
  data.predicted <- knn(data.train[,-5], data.test[,-5], data.train$Species, k = i)
  kvalues[i] <- mean(data.test$Species != data.predicted)
}
kframe <- data.frame(misclass=kvalues, k = 1:10)
ggplot(kframe, aes(x=k, y=misclass)) + geom_point() + geom_line() + scale_x_continuous(breaks = seq(1:10))

#Ref: www.pieriandata.com