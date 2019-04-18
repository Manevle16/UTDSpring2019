# Support Vector Machines Project - Solutions
# For this project we will be exploring publicly available data from 
# LendingClub.com. Lending Club connects people who need money (borrowers) 
# with people who have money (investors). Hopefully, as an investor you 
# would want to invest in people who showed a profile of having a high 
# probability of paying you back. We will try to create a model that will 
# help predict this.

# Lending club had a very interesting year in 2016, so let's check out some 
# of their data and keep the context in mind. This data is from before they 
# even went public.

# We will use lending data from 2007-2010 and be trying to classify and 
# predict whether or not the borrower paid back their loan in full. 
# You can download the data from here or just use the csv already provided. 
# It's recommended you use the csv provided as it has been cleaned of NA 
# values.


# Here are what the columns represent:
# .credit.policy: 1 if the customer meets the credit underwriting criteria 
# of LendingClub.com, and 0 otherwise.

# .purpose: The purpose of the loan (takes values "credit_card", 
# "debt_consolidation", "educational", "major_purchase", "small_business", 
# and "all_other").

# .int.rate: The interest rate of the loan, as a proportion 
# (a rate of 11% would be stored as 0.11). Borrowers judged by 
# LendingClub.com to be more risky are assigned higher interest rates.

# .installment: The monthly installments owed by the borrower if the loan 
# is funded.

# .log.annual.inc: The natural log of the self-reported annual income of the 
# borrower.

# .dti: The debt-to-income ratio of the borrower (amount of debt divided 
# by annual income).

# .fico: The FICO credit score of the borrower.

# .days.with.cr.line: The number of days the borrower has had a credit line.

# .revol.bal: The borrower's revolving balance (amount unpaid at the end of 
# the credit card billing cycle).

# .revol.util: The borrower's revolving line utilization rate 
# (the amount of the credit line used relative to total credit available).

# .inq.last.6mths: The borrower's number of inquiries by creditors in the 
# last 6 months.

# .delinq.2yrs: The number of times the borrower had been 30+ days past 
# due on a payment in the past 2 years.

# .pub.rec: The borrower's number of derogatory public records 
# (bankruptcy filings, tax liens, or judgments).

# Data
# Open the loan_data.csv file and save it as a dataframe called loans.

loans <- read.csv('loan_data.csv')
# Check the summary and structure of loans.
summary(loans)
str(loans)

# Convert the following columns to categorical data using factor()
# .inq.last.6mths 
# .delinq.2yrs 
#.pub.rec 
#.not.fully.paid 
#.credit.policy
loans$inq.last.6mths <- factor(loans$inq.last.6mths)
loans$delinq.2yrs <- factor(loans$delinq.2yrs)
loans$pub.rec <- factor(loans$pub.rec)
loans$not.fully.paid <- factor(loans$not.fully.paid)
loans$credit.policy <-  factor(loans$credit.policy)


#EDA
# Let's use ggplot 2 to visualize the data!
library(ggplot2)
# Create a histogram of fico scores colored by not.fully.paid

pl <- ggplot(loans, aes(x=fico))
pl <- pl + geom_histogram(aes(fill=not.fully.paid), color='black', bins=40, alpha=.5)
pl + scale_fill_manual(values=c('green', 'red')) + theme_bw()

# Create a barplot of purpose counts, colored by not.fully.paid. 
# Use position=dodge in the geom_bar argument
ggplot(loans, aes(x=purpose)) + geom_bar(aes(fill = not.fully.paid), position="dodge")

# Building the Model
# Now its time to build a model!
# Train and Test Sets
# Split your data into training and test sets using the caTools library.

loans$inq.last.6mths <- as.numeric(loans$inq.last.6mths)
loans$delinq.2yrs <- as.numeric(loans$delinq.2yrs)
loans$pub.rec <- as.numeric(loans$pub.rec)
loans$credit.policy <-  as.numeric(loans$credit.policy)
loans$purpose <- as.numeric(loans$purpose)

library(caTools)
split <- sample.split(loans$credit.policy, .8)

library(dplyr)
loans.train <- subset(loans, split == TRUE)
loans.test <- subset(loans, split == FALSE)
# Call the e1071 library 
library(e1071)

# Now use the svm() function to train a model on your training set.
model <- svm(not.fully.paid ~ ., loans.train, kernel="radial")

# Get a summary of the model.
summary(model)

# Use predict to predict new values from the test set using your model. 
badPredictions <- predict(model, loans.test)
table(badPredictions, loans.test$not.fully.paid)

# Tuning the Model
# You probably got some bad results! With the model classifying everything 
# into one group! Let's tune our model to try to fix this.

# Use the tune() function to test out different cost and gamma values. 
# In the lecture we showed how to do this by using train.x and train.y, 
# but its usually simpler to just pass a formula. 
# Try checking out help(tune) for more details. 
# This is the end of the project because tuning can take a long time 
# (since its running a bunch of different models!). 
# Take as long or as little time with this step as you would like.

tuning <- tune(svm, loans.train[,c(-14)], loans.train[,14], kernel="radial",
               ranges = list(cost=(3:1), gamma=10^(-5:1)))
summary(tuning)


model <- svm(not.fully.paid ~ ., loans.train, kernel="radial", gamma=1e-01, cost=1)
predicitons <- predict(model, loans.test)
table(predicitons, loans.test$not.fully.paid)
