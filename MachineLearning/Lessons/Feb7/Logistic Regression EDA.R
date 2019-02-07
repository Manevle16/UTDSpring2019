install.packages('Amelia')

df.train <- read.csv('titanic_train.csv')

library(Amelia)

#Displays a graph showing any missing values for the dataframe with yellow
missmap(df.train, main="Titanic Training Data - Missings Map", col=c("yellow", "black"), legend=FALSE)

#Data visualization with ggplot2
library(ggplot2)
#Bar graph showing amount of survivers and nonsurvivers
ggplot(df.train,aes(Survived)) + geom_bar()

#Bar graph showing amount of passengers for each class and colors the bars and makes them %50 see-through
ggplot(df.train,aes(Pclass)) + geom_bar(aes(fill=factor(Pclass)), alpha=.5)

#Same as above but with sex
ggplot(df.train, aes(Sex)) + geom_bar(aes(fill=factor(Sex), alpha=.5))

#Creates histogram showing a count of all the different ages
ggplot(df.train, aes(Age)) + geom_histogram(fill='blue', bins=20,alpha=.5)

ggplot(df.train, aes(SibSp)) + geom_bar(fill='red',alpha=.5)

#Histpgram bars have fill of green and border black
ggplot(df.train, aes(Fare)) + geom_histogram(fill='green', color='black', alpha=.5)

#Replaces missing ages with the age expected for an individual within their present class
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

#Data cleaning
#Create a box plot of ages by class and differentiate them with color by class
pl <- ggplot(df.train, aes(Pclass, Age)) + geom_boxplot(aes(group = Pclass, fill=factor(Pclass),alpha=.4))
#Scale graph by y axis to show from 0 to 80 in steps of 2
#Graph shows average of age by class which is used in the impute age function
pl + scale_y_continuous(breaks= seq(min(0), max(80), by = 2))

#Cleans up age data with function and returns cleaned ages
fixed.ages <- impute_age(df.train$Age, df.train$Pclass)
#Replaces ages with cleaned data
df.train$Age <- fixed.ages

#Now shows no missing values for ages since its been cleaned
missmap(df.train, main="Titanic Training Data - Missings Map", col=c("yellow", "black"), legend=FALSE)

#Start build of logistic model
str(df.train)
head(df.train, 3)

library(dplyr) # to remove features

#Remove features that cannot be analyzed or is unimportant for prediciting survival
df.train <- select(df.train, -PassengerId, -Name, -Ticket, -Cabin)

#Factor converts features into type factor which is a category with an enemurated type
df.train$Survived <- factor(df.train$Survived)
df.train$Pclass <- factor(df.train$Pclass)
df.train$SibSp <- factor(df.train$SibSp)
df.train$Parch <- factor(df.train$Parch)
str(df.train)

#train the model - glm: generalized linear model
log.model <- glm(formula=Survived ~., family=binomial(link='logit'), data=df.train)

#Look at model to see what features are good predictors for surviving
summary(log.model)

#now split into train and test
library(caTools)

split = sample.split(df.train$Survived, SplitRatio=.8)

final.train = subset(df.train, split==TRUE)

final.test = subset(df.train, split==FALSE)

head(final.train)
#Create model from train data in split
final.log.model <- glm(formula=Survived ~ Age + Pclass + Sex + SibSp, family=binomial(link='logit'), data=final.train)

summary(final.log.model)

#response for classification
#Predict whether someone survivded using the model on the test data
fitted.probabilities <- predict(final.log.model, newdata = final.test,type='response')

#Round all results to 1 or 0 for survived or not survived
fitted.results <- ifelse(fitted.probabilities > .5, 1, 0)

#calculate the error of what was predicted and what was the atual result
misClasificError <- mean(fitted.results != final.test$Survived)

#Print the accuracy of the model
print(paste('Accuracy', 1-misClasificError))
#Print out the confusion matrix of the results
print('CONFUSION MATRIX')
table(final.test$Survived, fitted.probabilities>.5)
