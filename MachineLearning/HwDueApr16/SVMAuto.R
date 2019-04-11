# 1. Apply a different data set to solve the classification problem using
# SVM in R; like Titanic or any dataset of your choice

library(ISLR)
df <- Auto
head(df)
df <- df[,-9]
df[,8] <- factor(df[, 8])

# 2. For Data Wrangling: Add Visualization, Correlation Graph, PCA

pairs(df)

library(ggplot2)
library(viridis) 
ggplot(df, aes(origin, year, fill = origin)) + geom_boxplot() + scale_fill_viridis(discrete = TRUE)

ggplot(df, aes(acceleration, horsepower, color = origin)) + geom_point()

pca <- prcomp(df[,-8], scale. = TRUE)
summary(pca)
library(ggfortify)
library(cluster)
autoplot(pca, data = df, colour = 'origin', loadings = TRUE, loadings.label = TRUE)
autoplot(pam(df[-8], 3), frame = TRUE, frame.type = 'norm')

# 3. For Tune up: Add Visualization for determining better cost and gamma
library(e1071)
library(caTools)

split = sample.split(df$mpg, .8)

library(dplyr)
df.train <- subset(df, split = TRUE)
df.test <- subset(df, split = FALSE)

tune.results <- tune(svm, df.train[,-8], df.train[,8], kernel='radial', 
                     ranges = list(cost = c(1:10), gamma = c(.025, .05, .1, .2, .25, .5, 1, 2)))
summary(tune.results)


plot(tune.results, type='perspective', theta = 120, phi = 35) + scale_fill_viridis()

# 3. For Evaluation: Add Visualization for the Predicted Results
model <- svm(origin ~ ., data=df.train, kernel='radial', cost = 8, gamma=.2)

df.predictions = predict(model, df.test)

table(df.predictions, df.test$origin)

accuracy <- 1 - mean(df.test$origin != df.predictions)
