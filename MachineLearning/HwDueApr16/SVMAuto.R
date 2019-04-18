# 1. Apply a different data set to solve the classification problem using
# SVM in R; like Titanic or any dataset of your choice

df <- read.csv('titanic.csv')
head(df)

library(Amelia)
missmap(df, main="Titanic Training Data - Missings Map", col=c("yellow", "black"), legend=FALSE)

impute_age <- function(age,class){
  out <- age
  for(i in 1:length(age)){
    if(is.na(age[i])){
      if(class[i] == 1){
        out[i] <- 37
      }else if(class[i] == 2){
        out[i] <- 29
      }else{
        out[i] <- 24
      }
    }else{
      out[i]<-age[i]
    }
  }
  return(out)
}

library(dplyr)
is.na(df['pclass'])
df[is.na(df['pclass']),]
df <- df[-1310,]

df[is.na(df['fare']),]
df <- df[-1226,]

summary(df)
fixed.ages <- impute_age(df$age, df$pclass)
df$age <- fixed.ages
df$survived <- factor(df$survived)
df <- subset(df, select = -c(name, body, boat, home.dest, cabin, ticket))
df$sex <- factor(df$sex)
df$sex <- as.numeric(df$sex)
df$embarked <- factor(df$embarked)
df$embarked <- as.numeric(df$embarked)
# 2. For Data Wrangling: Add Visualization, Correlation Graph, PCA

pairs(df)

library(ggplot2)
library(viridis) 
ggplot(df, aes(age, fill = survived)) + geom_histogram() + scale_fill_viridis(discrete = TRUE)

ggplot(df, aes(age, sex, color = survived)) + geom_point()

pca <- prcomp(df[, -2], scale. = TRUE)
summary(pca)
library(ggfortify)
library(cluster)
autoplot(pca, data = df, colour = 'survived', loadings = TRUE, loadings.label = TRUE)
autoplot(pam(df[, -2], 2), frame = TRUE, frame.type = 'norm')

# 3. For Tune up: Add Visualization for determining better cost and gamma
library(e1071)
library(caTools)

split = sample.split(df$age, .8)

df.train <- subset(df, split == TRUE)
df.test <- subset(df, split == FALSE)

tune.results <- tune(svm, df.train[,-2], df.train$survived, kernel='radial', 
                     ranges = list( gamma = 10^(-5:-1), cost = 10^(-3:1)))
summary(tune.results)

plot(tune.results)
plot(tune.results, type='perspective', theta = 50, phi = 10) 
# 3. For Evaluation: Add Visualization for the Predicted Results
model <- svm(survived ~ ., data=df.train, kernel='radial', cost = 1, gamma=.1)

df.predictions = predict(model, df.test)

table(df.predictions, df.test$survived)

accuracy <- 1 - mean(df.test$origin != df.predictions)
