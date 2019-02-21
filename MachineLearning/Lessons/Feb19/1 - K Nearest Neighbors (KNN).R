#install.packages('ISLR',repos = 'http://cran.us.r-project.org')

install.packages('ISLR')
library(ISLR)

# Insurance Policy Purchase
str(Caravan)

summary(Caravan$Purchase) # only 6% purchased the policy
348/5474
any(is.na(Caravan)) # none

# Standardize Variables
# Because the KNN classifier predicts the class of a given test observation 
# by identifying the observations that are nearest to it, the scale of the 
# variables matters. Any variables that are on a large scale will have a 
# much larger effect on the distance between the observations, and hence on 
# the KNN classifier, than variables that are on a small scale.

# For example, let's check out the variance of two features:

var(Caravan[,1])
var(Caravan[,2])

# Clearly the scales are different! We are now going to standarize all the 
# X variables except Y (Purchase). The Purchase variable is in column 86 
# of our dataset, so let's save it in a separate variable because the knn() 
# function needs it as a separate argument.

# save the Purchase column in a separate variable
purchase <- Caravan[,86]

# Standarize the dataset using "scale()" R function
print(head(Caravan))
#Scales all values into a range of 1 except the last target column
standardized.Caravan <- scale(Caravan[,-86])
var(standardized.Caravan[,1])
var(standardized.Caravan[,2])
print(head(standardized.Caravan))

# Train Test Split
# First 1000 rows for test set
test.index <- 1:1000
test.data <- standardized.Caravan[test.index,]
test.purchase <- purchase[test.index]

# Rest of data for training
train.data <- standardized.Caravan[-test.index,]
train.purchase <- purchase[-test.index]

# KNN Model
library(class) # contains KNN function
set.seed(101)
#Given train features, test features, train labels, and k value, return the predictions for the test.data
predicted.purchase <- knn(train.data,test.data,train.purchase,k=1)
head(predicted.purchase)

error.rate <- mean(test.purchase != predicted.purchase)
print(error.rate)

# try the model with K = 3 and K = 5
predicted.purchase <- knn(train.data,test.data,train.purchase,k=3)
error.rate <- mean(test.purchase != predicted.purchase)
print(error.rate)
head(predicted.purchase)

predicted.purchase <- knn(train.data,test.data,train.purchase,k=5)
error.rate <- mean(test.purchase != predicted.purchase)
print(error.rate)
head(predicted.purchase)

###
# Choosing a K value
###
predicted.purchase <- NULL
error.rate <- NULL

#Do K Nearest Neighbors for kvalues 1 from 20 and store all the error rates
for(i in 1:20){
  set.seed(101)
  predicted.purchase = knn(train.data,test.data,train.purchase,k=i)
  error.rate[i] = mean(test.purchase != predicted.purchase)
}

print(error.rate)

###
# VISUALIZE K ELBOW METHOD
###
library(ggplot2)
k.values <- 1:20
error.df <- data.frame(error.rate,k.values)
error.df

pl <- ggplot(error.df,aes(x=k.values,y=error.rate)) 
pl <- pl + geom_point()+ geom_line(lty="dotted",color='red')
pl

# The optimal K based on pl
predicted.purchase <- knn(train.data,test.data,train.purchase,k=9)
error.rate <- mean(test.purchase != predicted.purchase)
print(error.rate)


#Ref: www.pieriandata.com