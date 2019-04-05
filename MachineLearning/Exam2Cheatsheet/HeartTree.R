# i) Create a decision tree model on the training data
df <- read.csv('Heart.csv')
df <- df[,-1]
head(df)

pairs(df)
library(caTools)
library(dplyr)
split = sample.split(df$Age, .8)
df.train = subset(df, split == TRUE)
df.test = subset(df, split == FALSE)

library(rpart)
rTree <- rpart(AHD ~ ., method = 'class', data = df.train)
# ii) Run a summary of the model
summary(rTree)
# iii) Make predictions of the test data
rPredictions <- predict(rTree, df.test, type = 'class')
# iv) Compute the accuracy
accuracy <- 1 - mean(df.test$AHD != rPredictions)
# v) Print the tree with labels
library(rpart.plot)
prp(rTree)
# vi) Cross Validation
# a) Create a new tree from the cv.tree() function
library(tree)
Tree <- tree(AHD ~ ., method = 'class', data = df.train)
cvTree <- cv.tree(Tree)
# b) Look at the $dev and $size variables by the displaying the tree using its name
cvTree
# vii) Prune the tree
# a) create a new pruned tree using best=n where n is the optimal size indicated in step vi) above
prunedTree <- prune.misclass(Tree, best = 7)
# b) plot the new pruned tree with labels
plot(prunedTree)
text(prunedTree)
# viii) Predict
# a) Using the pruned tree, make predictions on the test data set
prunedPredictions <- predict(prunedTree, df.test, type = 'class')
# b) Compute the accuracy
prunedAccuracy <- 1 - mean(df.test$AHD != prunedPredictions)
