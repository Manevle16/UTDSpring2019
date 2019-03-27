install.packages('rpart')
library(rpart)
help(rpart)


str(kyphosis)
head(kyphosis)
df.kyphosis = as.data.frame(kyphosis)
tree <- rpart(Kyphosis ~ . , method='class', data= kyphosis)
printcp(tree)
plot(tree, uniform=TRUE, main="Main Title")
text(tree, use.n=TRUE, all=TRUE)

install.packages('rpart.plot')
library(rpart.plot)
prp(tree)

# Random Forests
# Random forests improve predictive accuracy by generating a large number of 
# bootstrapped trees (based on random samples of variables), classifying a case using each tree in this new "forest", and deciding a final predicted outcome by combining the results across all of the trees (an average in regression, a majority vote in classification).

# We can use the randomForest library to create and build out a Random Forest:
# Random Forest prediction of Kyphosis data
install.packages('randomForest')
library(randomForest)
model <- randomForest(Kyphosis ~ .,   data=kyphosis)

print(model) # view results
importance(model) # importance of each predictor
