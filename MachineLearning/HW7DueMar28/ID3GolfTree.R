library(C50)
df <- read.csv("golf.csv")
summary(df)


tree <- C5.0(play ~ ., method='class', data=df)
summary(tree)
plot(tree)
