###
# Linear Regression Project
# 1.  Read in bikeshare.csv file and set it to a dataframe called bike. 
df.data = read.csv('bikeshare.csv')
### Bikshare Data Set Information
# . datetime - hourly date + timestamp 
# . season - 1 = spring, 2 = summer, 3 = fall, 4 = winter 
# . holiday - whether the day is considered a holiday
# . workingday - whether the day is neither a weekend nor holiday
# . weather - 
#   ???1: Clear, Few clouds, Partly cloudy, Partly cloudy 
#   ???2: Mist + Cloudy, Mist + Broken clouds, Mist + Few clouds, Mist 
#   ???3: Light Snow, Light Rain + Thunderstorm + Scattered clouds, Light Rain + Scattered clouds 
#   ???4: Heavy Rain + Ice Pallets + Thunderstorm + Mist, Snow + Fog 

# . temp - temperature in Celsius
# . atemp - "feels like" temperature in Celsius
# . humidity - relative humidity
# . windspeed - wind speed
# . casual - number of non-registered user rentals initiated
# . registered - number of registered user rentals initiated
# . count - number of total rentals
###

# 2.  Check the head of df
head(df.data)
# 3.  Can you figure out what is the target we are trying to predict? 

#What factors improve chances of a higher sales in bike rentals?

#     Check the Kaggle Link above if you are confused on this. 

### 
# Exploratory Data Analysis
library(ggplot2)
# 4.  Create a scatter plot of count vs temp. Set a good alpha value.

#Temperature around 20 to 30 celsius have the greatest amount of rentals, there is also a positive 
#correlation between the amount of rentals and temperature
ggplot(df.data, aes(x=count, y=temp)) + geom_point(aes(alpha=.5))

# 5.  Plot count versus datetime as a scatterplot with a color gradient 
#     based on temperature. You'll need to convert the datetime column 
#     into POSIXct before plotting.

#During the years with a higher average temperature resulted in more rentals, there is also a positive
#correlation between the year and rentals applying renting bikes is becoming a more popular option
df.data$datetime <- as.POSIXct.Date(df.data$datetime)
ggplot(df.data, aes(x=count, y=datetime)) + geom_point(aes(color = factor(temp))) 

# 6.  What is the correlation between temp and count? 

#There is a positive correlation between the two

# 7.  Let's explore the season data. Create a boxplot, 
#     with the y axis indicating count and the x axis begin a box for each season.

#Summer and fall are the most popular seasons for renting bikes
ggplot(df.data, aes(x=season, y=count)) + geom_boxplot(aes(fill = factor(season)))

# 8.  Create an "hour" column that takes the hour from the datetime column. 
#     You'll probably need to apply some function to the entire datetime 
#     column and reassign it. 
#     Hint:
#     time.stamp <- bike$datetime[4]
#     format(time.stamp, "%H")

outputHour <- function(datetimes){
  df <- data.frame(hour = c(1:length(datetimes)))

  for(i in 1:length(datetimes)){
    df[i,'hour'] <- as.numeric(format(datetimes[i], "%H"))
  }
  print(df)
  return(df)
 
}
out <- data.frame(hour= c(1:length(df.data$datetime)))
out[1,'hour']
out <- outputHour(df.data$datetime)

df.data <- merge(df.data, out, by=0)

ggplot(df.data, aes(x=hour, y=count, color=factor(temp))) + geom_point()
# 9.  Building the Model
#     Use lm() to build a model that predicts count based solely on the temp 
#     feature, name it temp.model
temp.model = lm(count ~ temp, df.data)

# 10. Get the summary of the temp.model
summary(temp.model)

# 11. How many bike rentals would we predict if the temperature was 25 
#     degrees Celsius? Calculate this two ways:
#     . Using the values we just got above
#     . Using the predict() function

#using summary values
9.1705*25 + 6.0462

#using predict
predict(model, data.frame(temp=c(25)))

# 12. Use sapply() and as.numeric to change the hour column to a column of 
#     numeric values.

df.data$hour <- sapply(df.data$hour, as.numeric)
# already numeric

#
# 13. Finally build a model that attempts to predict count based off of the 
#     following features. Figure out if theres a way to not have to 
#     pass/write all these variables into the lm() function. 
#     Hint: StackOverflow or Google may be quicker than the documentation.

library(caTools)
split = sample.split(df.data$count, SplitRatio = .7)

data.train <- subset(df.data, split == TRUE)
data.test <- subset(df.data, split == FALSE)

model = lm(count ~ temp + season + datetime + holiday + workingday + weather + atemp + humidity + windspeed
           + factor(hour), data.train)
# 14. Get the summary of the model

summary(model)

res <- residuals(model)

# Convert to DataFrame for gglpot
res <- as.data.frame(res)
head(res)

# Histogram of residuals
ggplot(res,aes(res)) +  geom_histogram(fill='blue',alpha=0.5)
plot(model)
# 15. Did the model perform well on the training data? What do you think 
#     about using a Linear Model on this data? 

#The model has a smal R-squared value of .313 which shows that the model is not a very good fit. This is
#because since we are looking at seasons and time which is categorical data and does not work well with
#a linear model

#     You should have noticed that this sort of model doesn't work well 
#     given our seasonal and time series data. We need a model that can 
#     account for this type of trend, read about Regression Forests for 
#     more info if you're interested! For now, let's keep this in mind as a 
#     learning experience and move on towards classification with 
#     Logistic Regression!






