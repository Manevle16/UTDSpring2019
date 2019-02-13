###
# Logistic Regression Project
# 01. Read in the adult_sal.csv file and set it to a data frame called adult. 
adult <- read.csv('adult_sal.csv')

# 02. Check the head of adult
head(adult)


# 03. You should notice the index has been repeated. Drop this column. 
library(dplyr)
adult <- select(adult,-X)

# 04. Check the head,str, and summary of the data now. 
print(head(adult))
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
unemp <- function(job){
    job <- as.character(job)
    if (job=='Never-worked' | job=='Without-pay'){
      return('Unemployed')
    }else{
      return(job)
    }
}

adult$type_employer <- sapply(adult$type_employer,unemp)
table(adult$type_employer)

# 09. What other columns are suitable for combining? Combine State and 
# Local gov jobs into a category called SL-gov and combine self-employed 
# jobs into a category called self-emp.

group_emp <- function(job){
    if (job=='Local-gov' | job=='State-gov'){
      return('SL-gov')
    }else if (job=='Self-emp-inc' | job=='Self-emp-not-inc'){
      return('self-emp')
    }else{
      return(job)
    }
}

adult$type_employer <- sapply(adult$type_employer,group_emp)
table(adult$type_employer)

# 10. Use table() to look at the marital column 
table(adult$marital)

# 11. Reduce this to three groups:
#     . Married
#     . Not-Married
#     . Never-Married

group_marital <- function(mar){
    mar <- as.character(mar)
    
    # Not-Married
    if (mar=='Separated' | mar=='Divorced' | mar=='Widowed'){
      return('Not-Married')
      
      # Never-Married   
    }else if(mar=='Never-married'){
      return(mar)
      
      #Married
    }else{
      return('Married')
    }
}

adult$marital <- sapply(adult$marital,group_marital)
table(adult$marital)

# 12. Check the country column using table()
table(adult$country)

# 13. Group these countries together however you see fit. 
# You have flexibility here because there is no right/wrong way to do this, 
# possibly group by continents. You should be able to reduce the number of 
# groups here significantly though.
levels(adult$country)
Asia <- c('China','Hong','India','Iran','Cambodia','Japan', 'Laos' ,
            'Philippines' ,'Vietnam' ,'Taiwan', 'Thailand')

North.America <- c('Canada','United-States','Puerto-Rico' )

Europe <- c('England' ,'France', 'Germany' ,'Greece','Holand-Netherlands','Hungary',
            'Ireland','Italy','Poland','Portugal','Scotland','Yugoslavia')

Latin.and.South.America <- c('Columbia','Cuba','Dominican-Republic','Ecuador',
                             'El-Salvador','Guatemala','Haiti','Honduras',
                             'Mexico','Nicaragua','Outlying-US(Guam-USVI-etc)','Peru',
                             'Jamaica','Trinadad&Tobago')
Other <- c('South')
group_country <- function(ctry){
    if (ctry %in% Asia){
      return('Asia')
    }else if (ctry %in% North.America){
      return('North.America')
    }else if (ctry %in% Europe){
      return('Europe')
    }else if (ctry %in% Latin.and.South.America){
      return('Latin.and.South.America')
    }else{
      return('Other')      
    }
}

adult$country <- sapply(adult$country,group_country)

# 14. Use table() to confirm the groupings
table(adult$country)

# 15. Check the str() of adult again. Make sure any of the columns we 
# changed have factor levels with factor()
str(adult)

adult$type_employer <- sapply(adult$type_employer,factor)
# Note: You could have also done something like:
# adult$type_employer <- factor(adult$type_employer)

adult$country <- sapply(adult$country,factor)
adult$marital <- sapply(adult$marital,factor)



str(adult)
library(Amelia)

# 16. Convert any cell with a '?' or a ' ?' value to a NA value. 
# Hint: is.na() may be useful here or you can also use brackets with a 
# conditional statement. Refer to the solutions if you can't figure this 
# step out.
adult[adult == '?'] <- NA

# 17. Using table() on a column with NA values should now not display those 
# NA values, instead you'll just see 0 for ?. 
# Optional: Refactor these columns (may take awhile). For example: 
table(adult$type_employer)

adult$type_employer <- sapply(adult$type_employer,factor)
adult$country <- sapply(adult$country,factor)
adult$marital <- sapply(adult$marital,factor)
adult$occupation <- sapply(adult$occupation,factor)

# 18. Play around with the missmap function from the Amelia package. 
# Can you figure out what its doing and how to use it?
missmap(adult)
missmap(adult,y.at=c(1),y.labels = c(''),col=c('yellow','black'))

# 19. Use na.omit() to omit NA data from the adult data frame. 
# Note, it really depends on the situation and your data to judge whether 
# or not this is a good decision. You shouldn't always just drop NA values.
# May take awhile in your experience...
adult <- na.omit(adult)
str(adult)

# 20. Use missmap() to check that all the NA values were in fact dropped. 
missmap(adult,y.at=c(1),y.labels = c(''),col=c('yellow','black'))

###
# EDA
###

# 21. Use ggplot2 to create a histogram of ages, colored by income. 
library(ggplot2)
library(dplyr)
pl <- ggplot(adult,aes(age)) 
pl <- pl + geom_histogram(aes(fill=income),color='black',binwidth=1) + theme_bw()
pl

# 22. Plot a histogram of hours worked per week
pl <- ggplot(adult,aes(hr_per_week)) + geom_histogram() + theme_bw()
pl

# 23. Rename the country column to region column to better reflect the 
# factor levels.
names(adult)[names(adult)=="country"] <- "region"
str(adult)

# 24. Create a barplot of region with the fill color defined by income 
# class. Optional: Figure out how rotate the x axis text for readability
pl <- ggplot(adult,aes(region)) 
pl <- pl + geom_bar(aes(fill=income),color='black') 
pl <- pl + theme_bw() 
pl <- pl + theme(axis.text.x = element_text(angle = 90, hjust = 1))
pl

###
# Train Test Split

# 25. Split the data into a train and test set using the caTools library 
# as done in previous lectures. Reference previous solutions notebooks if 
# you need a refresher. 

library(caTools)
set.seed(101) 

# Split up the sample, basically randomly assigns a booleans to 
# a new column "sample"
sample <- sample.split(adult$income, SplitRatio = 0.70) # SplitRatio = percent of sample==TRUE

# Training Data
train = subset(adult, sample == TRUE)

# Testing Data
test = subset(adult, sample == FALSE)


###
# Training the Model

# 26. Explore the glm() function with help(glm). Read through the 
# documentation.
help(glm)

# 27. Use all the features to train a glm() model on the training data set, 
# pass the argument family=binomial(logit) into the glm function.
model = glm(income ~ ., family = binomial(logit), data = train)

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
help(step)

# 29. Use new.model <- step(your.model.name) to use the step() function 
# to create a new model.
new.step.model <- step(model)

# 30. You should get a bunch of messages informing you of the process. 
# Check the new.model by using summary()
summary(new.step.model)

# 31. Create a confusion matrix using the predict function with 
# type='response' as an argument inside of that function.
test$predicted.income = predict(model, newdata=test, type="response")
table(test$income, test$predicted.income > 0.5)

# Warning message:
# In predict.lm(object, newdata, se.fit, scale = 1, type = ifelse(type == : prediction 
# from a rank-deficient fit may be misleading
                                                                  
# 32. What was the accuracy of our model?
(6372+1423)/(6372+1423+548+872)

# 33. Calculate other measures of performance like, recall or precision.
6732/(6372+548)
                                                                  
# 34. precision
6732/(6372+872)
                                                                  
#Ref: www.pieriandata.com




