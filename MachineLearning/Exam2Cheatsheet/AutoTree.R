# i) Create a decision tree model on the training data
library(ISLR)
head(Auto)
df <- Auto
str(df)

library(ggplot2)
pairs(df)
ggplot(df, aes(x = origin, y = year)) + geom_point()
library(caTools)
df$origin = factor(df$origin)
split = sample.split(df$mpg, .8)

library(dplyr)

df.train = subset(df, split == TRUE)
df.test = subset(df, split == FALSE)

library(rpart)

tree = rpart(origin ~ ., method = 'class', data = df.train[,c(-7,-9)])


# ii) Run a summary of the model
summary(tree)

# iii) Make predictions of the test data
predictions <- predict(tree, df.test, type='class')

# iv) Compute the accuracy
tree
table(df.test$origin, predictions)
accuracy <-  1 - mean(predictions != df.test$origin)
paste('Accuracy: ', accuracy)
# v) Print the tree with labels
library(rpart.plot)
prp(tree)
# vi) Cross Validation
# a) Create a new tree from the cv.tree() function
library(tree)
newTree = tree(origin ~ ., method = 'class', data = df.train[,c(-7,-9)])
cvTree = cv.tree(newTree, FUN = prune.misclass)
# b) Look at the $dev and $size variables by the displaying the tree using its name
cvTree
# vii) Prune the tree
# a) create a new pruned tree using best=n where n is the optimal size indicated in step vi) above
prunedTree = prune.misclass(newTree, best = 13)

# b) plot the new pruned tree with labels
text(prunedTree, pretty = 0)
# viii) Predict
# a) Using the pruned tree, make predictions on the test data set
prunedPredictions <- predict(prunedTree, df.test, type='class')
# b) Compute the accuracy
prunedAccuracy <- 1 - mean(df.test$origin != prunedPredictions)
paste("Accuracy: ", prunedAccuracy)
