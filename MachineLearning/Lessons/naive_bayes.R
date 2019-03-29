library(ISLR)
df <- iris 

df <- scale(df[,-5])

var(df[,2])
df <- cbind(df, data.frame(iris$Species))

colnames(df) <- colnames(iris)
summary(df)

library(caTools)

split <- sample.split(df$Sepal.Length, .8)

library(dplyr)

df.train <- subset(df, split == 1)
df.test <- subset(df, split == 0)

library(e1071)
classifier = naiveBayes(x = df.train[,-5], y = df.train$Species)

df.predict = predict(classifier, df.test[-5])

cm = table(df.test$Species, df.predict)

