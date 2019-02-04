###
# Linear Regression Project
# 1.  Read in bikeshare.csv file and set it to a dataframe called bike. 

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
# 3.  Can you figure out what is the target we are trying to predict? 
#     Check the Kaggle Link above if you are confused on this. 

### 
# Exploratory Data Analysis

# 4.  Create a scatter plot of count vs temp. Set a good alpha value.
# 5.  Plot count versus datetime as a scatterplot with a color gradient 
#     based on temperature. You'll need to convert the datetime column 
#     into POSIXct before plotting.

# 6.  What is the correlation between temp and count? 
# 7.  Let's explore the season data. Create a boxplot, 
#     with the y axis indicating count and the x axis begin a box for each season.

# 8.  Create an "hour" column that takes the hour from the datetime column. 
#     You'll probably need to apply some function to the entire datetime 
#     column and reassign it. 
#     Hint:
#     time.stamp <- bike$datetime[4]
#     format(time.stamp, "%H")

# 9.  Building the Model
#     Use lm() to build a model that predicts count based solely on the temp 
#     feature, name it temp.model

# 10. Get the summary of the temp.model
# 11. How many bike rentals would we predict if the temperature was 25 
#     degrees Celsius? Calculate this two ways:
#     . Using the values we just got above
#     . Using the predict() function

# 12. Use sapply() and as.numeric to change the hour column to a column of 
#     numeric values.

# 13. Finally build a model that attempts to predict count based off of the 
#     following features. Figure out if theres a way to not have to 
#     pass/write all these variables into the lm() function. 
#     Hint: StackOverflow or Google may be quicker than the documentation.

# 14. Get the summary of the model

# 15. Did the model perform well on the training data? What do you think 
#     about using a Linear Model on this data? 

#     You should have noticed that this sort of model doesn't work well 
#     given our seasonal and time series data. We need a model that can 
#     account for this type of trend, read about Regression Forests for 
#     more info if you're interested! For now, let's keep this in mind as a 
#     learning experience and move on towards classification with 
#     Logistic Regression!






