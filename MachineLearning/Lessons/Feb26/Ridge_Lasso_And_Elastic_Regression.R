install.packages('caret')
install.packages('glmnet')
install.packages('mlbench')
install.packages('psych')

library(caret)
library(glmnet)
library(mlbench)
library(psych)

data("BostonHousing") #mlbench
data <- BostonHousing

str(data)
help("BostonHousing")

#Scatter plot for every combination of predictors which are numeric, when they are highly correlated, this
#means this is a multicollinearity problem and when multiple regression is done, estimates are not stable, hence
# estimates may not be accurate
#Excludes 4th and 14th column
pairs.panels(data[c(-4, -14)], cex=1)

#Problem: Collinearity leads to overfitting
#Solution:
#1. Ridge Regression: Shrinks coefficients to non-zero values to prevent overfit, but keeps all variables
#
#2. Lasso Regression: Shrinks regression coefficients, with some shrink to zero. Thus helps with feature selection
#
#3. Elastic Regression: Mix of ridge and lasso regression

#Equations

#SSE(Ridge) = Sum of (actual_predicted)^2 + L2 Penalty Term
#Penalty Term: Lambda * Sum of Beta^2
#L2 makes coefficients shrink

#SSE(Lasso) = Sum of (actual_predicted)^2 + L1 Penalty Term
#Penalty Term: Lambda * Sum of |Beta|
#L1 makes the coeffiecents shrink, and some will shrink to zero selecting only the most important features

#Data Partition
set.seed(222)
ind <- sample(2, nrow(data), replace = T, prob = c(.7, .3))
train <- data[ind == 2,]
test <- data[ind == 1,]

# Custom Control Parameters
# trainControl in carrot packacge
# cv = 10
# in 10-fold cross validation, training data is broken up into 10 parts, model is made from 9 of them
# and the last part is used for error estimation, this used 5 times

custom <- trainControl(method = "repeatedcv", number = 10, repeats = 5, verboseIter = T)

#linear regression
lm <- lm(medv ~ ., train, trControl = custom)
plot(lm)
# Ridge Regression
set.seed(1234)
ridge <- train(medv ~ ., train, method = 'glmnet', #allows to fit multiple models
            tuneGrid = expand.grid(alpha = 0, lambda = seq(.0001, 1, length=5)), #Have lambda range from .0001 to 1
            trControl = custom)                                                  #in 5 even parts to be tested

# Finds the best value of lambda and uses it
# Estimated using cross validation

plot(ridge)
ridge

plot(ridge$finalModel, xvar="lambda", label="T")

plot(ridge$finalModel, xvar="dev", label="T")
plot(varImp(ridge, scale=F))
plot(varImp(ridge, scale=T))


# Lasso regression
lasso <- train(medv ~ ., train, method = 'glmnet', #allows to fit multiple models
               tuneGrid = expand.grid(alpha = 1, lambda = seq(.0001, 1, length=5)), #Have lambda range from .0001 to 1
               trControl = custom)   
plot(lasso)

lasso <- train(medv ~ ., train, method = 'glmnet', #allows to fit multiple models
               tuneGrid = expand.grid(alpha = 1, lambda = seq(.0001, .2, length=5)), #Have lambda range from .0001 to 1
               trControl = custom)
plot(lasso)


plot(lasso$finalModel, xvar="lambda", label="T")

plot(lasso$finalModel, xvar="dev", label="T")
plot(varImp(lasso, scale=F))
plot(varImp(lasso, scale=T))

# Elastic regression
set.seed(1234)
en <- train(medv ~ ., train, method = 'glmnet', #allows to fit multiple models
               tuneGrid = expand.grid(alpha =  seq(0, 1, length=10), lambda = seq(.0001, .2, length=5)), 
               trControl = custom)
plot(en)
en

predicted <- predict(en, test)
mse <- mean((predicted[1] - test$medv)^2)
rmse <- mse^.5
sd(data$medv)
