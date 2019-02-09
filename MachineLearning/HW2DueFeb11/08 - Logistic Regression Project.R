###
# Logistic Regression Project
# 01. Read in the adult_sal.csv file and set it to a data frame called adult. 
adult <- read.csv('adult_sal.csv')
# 02. Check the head of adult
head(adult)

library(dplyr)
# 03. You should notice the index has been repeated. Drop this column. 
adult <- select(adult, -X)
# 04. Check the head,str, and summary of the data now. 
head(adult)
str(adult)
summary(adult)
###
# Data Cleaning
###

# Notice that we have a lot of columns that are cateogrical factors, 
# however a lot of these columns have too many factors than may be necessary.
# In this data cleaning section we'll try to clean these columns up by 
# reducing the number of factors.

# 05. Use table() to check out the frequency of the type_employer column.
table(adult$type_employer)

# 06. How many Null values are there for type_employer?  
# 1836 Null Values

# 07. What are the two smallest groups?
# Never-worked and Without-pay
  
# 08. Combine these two smallest groups into a single group called 
# "Unemployed". There are lots of ways to do this, so feel free to get 
# creative. 
# Hint: It may be helpful to convert these objects into character data types 
# (as.character() and then use sapply with a custom function)
adult$type_employer <- sapply(adult$type_employer, as.character)

adult$type_employer[adult$type_employer == 'Never-worked' | adult$type_employer == 'Without-pay'] <- "Unemployed"

# 09. What other columns are suitable for combining? Combine State and 
# Local gov jobs into a category called SL-gov and combine self-employed 
# jobs into a category called Self-emp.

adult$type_employer[adult$type_employer == 'State-gov' | adult$type_employer == 'Local-gov'] <- "SL-gov"

adult$type_employer[adult$type_employer == 'Self-emp-inc' | adult$type_employer == 'Self-emp-not-inc'] <- "Self-emp"
# 10. Use table() to look at the marital column 
table(adult$marital)
# 11. Reduce this to three groups:
#     . Married
#     . Not-married
#     . Never-married

adult$marital <- sapply(adult$marital, as.character)

adult$marital[adult$marital == "Married-AF-spouse" | adult$marital == "Married-civ-spouse" | 
                adult$marital ==  "Married-spouse-absent"] <- "Married"

adult$marital[adult$marital != "Married" & adult$marital != "Never-married"] <- "Not-married"

# 12. Check the country column using table()
table(adult$country)
# 13. Group these countries together however you see fit. 
# You have flexibility here because there is no right/wrong way to do this, 
# possibly group by continents. You should be able to reduce the number of 
# groups here significantly though.

adult$country <- sapply(adult$country, as.character)

adult$country[adult$country == "El-Salvador" | adult$country == "Outlying-US(Guam-USVI-etc)" | 
                adult$country == "Cuba" | adult$country == "Dominican-Republic" | adult$country == "Guatemala" | 
                adult$country == "Mexico" | adult$country == "Nicaragua" | adult$country == "Puerto-Rico" |
                adult$country == "United-States" | adult$country == "Canada" |
                adult$country == "Jamaica" | adult$country == "Haiti" | 
                adult$country == "Trinadad&Tobago"] <- "North-America"

adult$country[adult$country == "Cambodia" | adult$country == "China" | adult$country == "Hong" | 
                adult$country == "India" | adult$country == "Hong" | adult$country == "Japan" | 
                adult$country == "Laos" | adult$country == "Philippines" | adult$country == "Taiwan" |
                adult$country == "Thailand" | adult$country == "South" | adult$country == "Vietnam"] <- "Asia"

adult$country[adult$country == "Columbia" | adult$country == "Equador" | adult$country == "Honduras" |
                adult$country == "Peru"] <- "South-America"

adult$country[adult$country != "North-America" & adult$country != "South-America" & adult$country != "Asia" &
                adult$country != "?"] <- "Europe"
# 14. Use table() to confirm the groupings
table(adult$country)
# 15. Check the str() of adult again. Make sure any of the columns we 
# changed have factor levels with factor()
str(adult)
adult$type_employer <- factor(adult$type_employer)
adult$marital <- factor(adult$marital)
adult$country <- factor(adult$country)
# Note: You could have also done something like:
# adult$type_employer <- factor(adult$type_employer)


# 16. Convert any cell with a '?' or a ' ?' value to a NA value. 
# Hint: is.na() may be useful here or you can also use brackets with a 
# conditional statement. Refer to the solutions if you can't figure this 
# step out.

adult <- mutate_all(adult, na_if, "?")

# 17. Using table() on a column with NA values should now not display those 
# NA values, instead you'll just see 0 for ?. 
# Optional: Refactor these columns (may take awhile). For example: 
table(adult$occupation)

# 18. Play around with the missmap function from the Amelia package. 
# Can you figure out what its doing and how to use it?
library(Amelia)
#Shows that some values in occupation, type_employer, and country are NA
missmap(adult, col = c("yellow", "black"))

# 19. Use na.omit() to omit NA data from the adult data frame. 
# Note, it really depends on the situation and your data to judge whether 
# or not this is a good decision. You shouldn't always just drop NA values.
# May take awhile
adult <- na.omit(adult)
# 20. Use missmap() to check that all the NA values were in fact dropped. 
missmap(adult, col = c("yellow", "black"))

###
# EDA
###

# 21. Use ggplot2 to create a histogram of ages, colored by income. 
#Older people around the 40 year old mark seem to typically have an income greater than 50k
ggplot(adult, aes(x=age, fill = income)) + geom_histogram()
# 22. Plot a histogram of hours worked per week
ggplot(adult, aes(x=hr_per_week, fill = income)) + geom_histogram()
# 23. Rename the country column to region column to better reflect the 
# factor levels.
colnames(adult)[colnames(adult) == "country"] <- "region"
# 24. Create a barplot of region with the fill color defined by income 
# class. Optional: Figure out how rotate the x axis text for readability

ggplot(adult, aes(x=region, fill = income)) + geom_bar()
###
# Train Test Split

# 25. Split the data into a train and test set using the caTools library 
# as done in previous lectures. Reference previous solutions notebooks if 
# you need a refresher. 
library(caTools)

# Split up the sample, basically randomly assigns a booleans to 
# a new column "sample"
split <- sample.split(adult$region, SplitRatio = .7)

# Training Data
adult.train <- subset(adult, split == TRUE)

# Testing Data
adult.test <- subset(adult, split == FALSE)

###
# Training the Model

# 26. Explore the glm() function with help(glm). Read through the 
# documentation.
help(glm)
# 27. Use all the features to train a glm() model on the training data set, 
# pass the argument family=binomial(logit) into the glm function.
model <- glm(data = adult, income ~ ., family=binomial(logit))
# If you get a warning, this just means that the model may have guessed 
# the probability of a class with a 0% or 100% chance of occuring.

# 28. Check the model summary
summary(model)
# We have still a lot of features! Some important, some not so much. 
# R comes with an awesome function called step(). The step() function 
# iteratively tries to remove predictor variables from the model in an 
# attempt to delete variables that do not significantly add to the fit. 
# How does it do this? It uses AIC. Read the wikipedia page for AIC if you 
# want to further understand this, you can also check out help(step). 
# This level of statistics is outside the scope of this project assignment 
# so let's keep moving along

# 29. Use new.model <- step(your.model.name) to use the step() function 
# to create a new model.
new.model <- step(model)
# 30. You should get a bunch of messages informing you of the process. 
# Check the new.model by using summary()
summary(new.model)
# 31. Create a confusion matrix using the predict function with 
# type='response' as an argument inside of that function.
predictions <- predict(new.model, adult.test, type = "response")

fittedResults <- ifelse(predictions > .5, 1, 0)

conMatrix <- table(adult.test$income, predictions > .5)
colnames(conMatrix) <- c("<=50k", ">50k")
conMatrix
adult.test$income <- sapply(adult.test$income, as.character)
adult.test$income
adult.test$income[adult.test$income == '<=50K'] <- "0"
adult.test$income[adult.test$income != '0'] <- "1"
adult.test$income <- sapply(adult.test$income, as.numeric)


# Warning message:
# In predict.lm(object, newdata, se.fit, scale = 1, type = ifelse(type == : prediction 
# from a rank-deficient fit may be misleading
                                                                  
# 32. What was the accuracy of our model?
error <- mean(fittedResults != adult.test$income)

paste("Accuracy: ",  1 - error)
# 33. Calculate other measures of performance like, recall or precision.
sum(fittedResults == 1)

recall =  conMatrix[2,2] / length(adult.test$income[adult.test$income == 1])
recall
# 34. precision
precision = conMatrix[2,2] / (conMatrix[2,2] + conMatrix[1,2])
precision
#Ref: www.pieriandata.com




