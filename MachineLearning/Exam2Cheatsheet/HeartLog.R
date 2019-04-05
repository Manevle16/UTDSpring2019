
# i) Download the heart data to your machine
# ii) Load the data into R and attach it
df <- read.csv('Heart.csv')
df <- na.omit(df)

# iii) Remove the "X" column
df <- df[, -1]
df$AHD <- factor(df$AHD)
# iv) Set up train and test sets with 80% training using a seed
library(caTools)
split <- sample.split(df$Age, .8)

library(dplyr)
df.train <- subset(df, split == TRUE)
df.test <- subset(df, split == FALSE)

# v) Create LR model on training where AHD is predicted by all other variables
model <- glm(AHD ~ ., family=binomial(logit), data=df.train)
# vi) Run a summary of the model
summary(model)
plot(model)

# vii) Predict Yes/No on the test data
predictions <- predict(model, df.test, type = 'response')
predictions
predictions <- ifelse(predictions > .5, "Yes", "No")

# viii) Compute the accuracy
accuracy <- 1 - mean(df.test$AHD != predictions)
