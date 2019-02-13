###
# Linear Regression Project
# 01. Read in bikeshare.csv file and set it to a dataframe called bike. 
bike <- read.csv('bikeshare.csv')

# 02. Check the head of df
head(bike)


# 03. Can you figure out what is the target we are trying to predict? 
# Count is what we are trying to predict 

### 
# Exploratory Data Analysis

# 04.  Create a scatter plot of count vs temp. Set a good alpha value.
library(ggplot2)
pl <- ggplot(bike,aes(temp,count)) 
pl <- pl + geom_point(alpha=0.2, aes(color=temp)) + theme_bw()
pl

# 05.  Plot count versus datetime as a scatterplot with a color gradient
bike$datetime <- as.POSIXct(bike$datetime)

# 06.  What is the correlation between temp and count?
cor(bike[,c('temp','count')])

# 07.  Let's explore the season data. Create a boxplot, 
pl <- ggplot(bike,aes(factor(season),count)) 
pl <- pl + geom_boxplot(aes(color=factor(season))) +theme_bw()
pl

# 08.  Create an "hour" column that takes the hour from the datetime column.
bike$hour <- sapply(bike$datetime,function(x){format(x,"%H")})
head(bike)

# 09.  Building the Model
temp.model <- lm(count~temp,bike)

# 10. Get the summary of the temp.model
summary(temp.model)
# 11. How many bike rentals would we predict if the temperature was 25 

# Method 1
6.0462 + 9.17*25

# Method 2
temp.test <- data.frame(temp=c(25))

predict(temp.model,temp.test)

# 12. Use sapply() and as.numeric to change the hour column to a column of 
# numeric values.
bike$hour <- sapply(bike$hour,as.numeric)


# 13. Finally build a model that attempts to predict count based off of the 
# following features. 
model <- lm(count ~ . -casual - registered -datetime -atemp,data=bike)

# 14. Get the summary of the model
summary(model)

# 15. Did the model perform well on the training data? What do you think 
# about using a Linear Model on this data? 

# A linear model like the one we chose which uses OLS won't be able to take 
# into account seasonality of our data, and will get thrown off by the 
# growth in our dataset, accidentally attributing it towards the winter 
# season, instead of realizing its just overall demand growing! Later on, 
# we'll see if other models may be a better fit for this sort of data.

# Note: You should have noticed that this sort of model doesn't work well 
# given our seasonal and time series data. We need a model that can 
# account for this type of trend, read about Regression Forests for 
# more info if you're interested! For now, let's keep this in mind as a 
# learning experience and move on towards classification with 
# Logistic Regression!


#Ref: www.pieriandata.com




