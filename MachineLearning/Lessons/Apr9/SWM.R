library(ISLR)
df <- iris
head(df)
pairs(df)

# Holds SVM model
install.packages('e1071', repos="http://cran.us.r-project.org")
library(e1071)

help(svm)

model <- svm(Species ~ ., data=df)
summary(model)

# Parameters:
# shows the given parameters when creating the svm
# cost: Determines how much variance the model will have, higher = less variance
# gamma: smaller is higher variance

predicted.values <- predict(model, iris[1:4])
table(predicted.values, iris[,5])

# Tuning gamma and costs
tune.results <- tune(svm, train.x=iris[1:4], train.y=iris[,5], kernel='radial',
                     ranges=list(cost=c(0.1,1,10), gamma=c(.5, 1, 2)))
summary(tune.results)

model <- svm(Species ~ ., data=iris, kernel="radial", cost=1, gamma=.5)
summary(model)

predicted.values <- predict(model, iris[1:4])
table(predicted.values, iris[,5])
