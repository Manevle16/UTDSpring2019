install.packages('caTools')
library(caTools)
library(ggplot2)
df <- read.csv('student-mat.csv', sep=';')

#Set seed for sample to match teachers test set
set.seed(101)

#Split set into training and test set, 70% training. Sample shows what rows were included in training set with true
#df$G3 returns all the rows of G3, any column can be chosen for this
sample <- sample.split(df$G3, SplitRatio = .7)
sample

#Training Data
train <- subset(df, sample == TRUE)

#Test Data
test <- subset(df, sample == FALSE)

#model <- lm(y ~ ., data)   Period includes all columns 
#model <- lm(G3 ~ X1 + X2 + X3, data) Include only specific columns X1, X2, and X3
model1 <- lm(G3 ~ ., data = train)
#
model2 <- lm(G3 ~ G2 + age + absences + famrel + G1, train) 

#The more astrics next to columns, the more important it is to predicting G3
summary(model1)
summary(model2)

res <- residuals(model1)
res2 <- residuals(model2)

res <- as.data.frame(res)
res2 <- as.data.frame(res2)

ggplot(res, aes(res)) + geom_histogram(fill = "blue")
ggplot(res2, aes(res2)) + geom_histogram(fill = "blue")

