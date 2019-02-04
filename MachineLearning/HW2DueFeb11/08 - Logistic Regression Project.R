###
# Logistic Regression Project
# 01. Read in the adult_sal.csv file and set it to a data frame called adult. 

# 02. Check the head of adult

# 03. You should notice the index has been repeated. Drop this column. 

# 04. Check the head,str, and summary of the data now. 

###
# Data Cleaning
###

# Notice that we have a lot of columns that are cateogrical factors, 
# however a lot of these columns have too many factors than may be necessary.
# In this data cleaning section we'll try to clean these columns up by 
# reducing the number of factors.

# 05. Use table() to check out the frequency of the type_employer column.

# 06. How many Null values are there for type_employer?  
# 1836 Null Values

# 07. What are the two smallest groups?
# Never-worked and Without-pay
  
# 08. Combine these two smallest groups into a single group called 
# "Unemployed". There are lots of ways to do this, so feel free to get 
# creative. 
# Hint: It may be helpful to convert these objects into character data types 
# (as.character() and then use sapply with a custom function)

# 09. What other columns are suitable for combining? Combine State and 
# Local gov jobs into a category called SL-gov and combine self-employed 
# jobs into a category called self-emp.


# 10. Use table() to look at the marital column 

# 11. Reduce this to three groups:
#     . Married
#     . Not-Married
#     . Never-Married


# 12. Check the country column using table()

# 13. Group these countries together however you see fit. 
# You have flexibility here because there is no right/wrong way to do this, 
# possibly group by continents. You should be able to reduce the number of 
# groups here significantly though.

# 14. Use table() to confirm the groupings

# 15. Check the str() of adult again. Make sure any of the columns we 
# changed have factor levels with factor()


# Note: You could have also done something like:
# adult$type_employer <- factor(adult$type_employer)


# 16. Convert any cell with a '?' or a ' ?' value to a NA value. 
# Hint: is.na() may be useful here or you can also use brackets with a 
# conditional statement. Refer to the solutions if you can't figure this 
# step out.

# 17. Using table() on a column with NA values should now not display those 
# NA values, instead you'll just see 0 for ?. 
# Optional: Refactor these columns (may take awhile). For example: 


# 18. Play around with the missmap function from the Amelia package. 
# Can you figure out what its doing and how to use it?

# 19. Use na.omit() to omit NA data from the adult data frame. 
# Note, it really depends on the situation and your data to judge whether 
# or not this is a good decision. You shouldn't always just drop NA values.
# May take awhile

# 20. Use missmap() to check that all the NA values were in fact dropped. 

###
# EDA
###

# 21. Use ggplot2 to create a histogram of ages, colored by income. 

# 22. Plot a histogram of hours worked per week

# 23. Rename the country column to region column to better reflect the 
# factor levels.

# 24. Create a barplot of region with the fill color defined by income 
# class. Optional: Figure out how rotate the x axis text for readability

###
# Train Test Split

# 25. Split the data into a train and test set using the caTools library 
# as done in previous lectures. Reference previous solutions notebooks if 
# you need a refresher. 


# Split up the sample, basically randomly assigns a booleans to 
# a new column "sample"

# Training Data

# Testing Data


###
# Training the Model

# 26. Explore the glm() function with help(glm). Read through the 
# documentation.

# 27. Use all the features to train a glm() model on the training data set, 
# pass the argument family=binomial(logit) into the glm function.

# If you get a warning, this just means that the model may have guessed 
# the probability of a class with a 0% or 100% chance of occuring.

# 28. Check the model summary

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

# 30. You should get a bunch of messages informing you of the process. 
# Check the new.model by using summary()

# 31. Create a confusion matrix using the predict function with 
# type='response' as an argument inside of that function.

# Warning message:
# In predict.lm(object, newdata, se.fit, scale = 1, type = ifelse(type == : prediction 
# from a rank-deficient fit may be misleading
                                                                  
# 32. What was the accuracy of our model?

# 33. Calculate other measures of performance like, recall or precision.

# 34. precision

#Ref: www.pieriandata.com




