###
# The Data We will use the popular Boston dataset from the MASS package, 
# which describes some features for houses in Boston in 1978.

#CRIM - per capita crime rate by town
#ZN - proportion of residential land zoned for lots over 25,000 sq.ft.
#INDUS - proportion of non-retail business acres per town.
#CHAS - Charles River dummy variable (1 if tract bounds river; 0 otherwise)
#NOX - nitric oxides concentration (parts per 10 million)
#RM - average number of rooms per dwelling
#AGE - proportion of owner-occupied units built prior to 1940
#DIS - weighted distances to five Boston employment centres
#RAD - index of accessibility to radial highways
#TAX - full-value property-tax rate per 10,000 dollars
#PTRATIO - pupil-teacher ratio by town
#B - 1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town
#LSTAT - % lower status of the population
#MEDV - Median value of owner-occupied homes in $1000's

# We will be trying to predict the Median Value MEDV

library(MASS)
set.seed(101)
data <- Boston
str(data)
summary(data)
head(data)
any(is.na(data))
install.packages('neuralnet',repos = 'http://cran.us.r-project.org')
library(neuralnet)
maxs <- apply(data, 2, max) 
mins <- apply(data, 2, min)
maxs
mins
# subtract min from each column
# divide each column by maxs-mins
scaled <- as.data.frame(scale(data, center = mins, scale = maxs - mins))
head(scaled)
library(caTools)
split = sample.split(scaled$medv, SplitRatio = 0.70)

train = subset(scaled, split == TRUE)
test = subset(scaled, split == FALSE)

# Training the Model
# Call package
library(neuralnet)

# Formula for Neural Net
# For some odd reasons, the neuralnet() function won't accept a formula in the 
# form: y~. that we are used to using. Instead you have to call all the 
# columns added together. Here is some convience code to help quickly create 
# that formula:

# # Get column names

nn <- neuralnet(f,data=train,hidden=c(5,3),linear.output=TRUE)

# Neural Net Visualization
# You can plot out your model to see a very neat visualization with the 
# weights on each connection.

# The black lines show the connections between each layer and the weights 
# on each connection while the blue lines show the bias term added in each step.

# The bias can be thought as the intercept of a linear model. The net is 
# essentially a black box so we cannot say that much about the fitting, 
# the weights and the model. Suffice to say that the training algorithm 
# has converged and therefore the model is ready to be used.

# Predictions using the Model
# Now we can try to predict the values for the test set and calculate the MSE. 
# Remember that the net will output a normalized prediction, so we need to 
# scale it back in order to make a meaningful comparison (or just a simple 
# prediction).

# # Compute Predictions off Test Set
predicted.nn.values <- compute(nn,test[1:13])

# Its a list returned
str(predicted.nn.values)

# Convert back to non-scaled predictions
true.predictions <- predicted.nn.values$net.result*(max(data$medv)-min(data$medv))+min(data$medv)

# Convert the test data
test.r <- (test$medv)*(max(data$medv)-min(data$medv))+min(data$medv)

# Check the Mean Squared Error
MSE.nn <- sum((test.r - true.predictions)^2)/nrow(test)

MSE.nn

# Visualize Error
error.df <- data.frame(test.r,true.predictions)
head(error.df)
library(ggplot2)
ggplot(error.df,aes(x=test.r,y=true.predictions)) + geom_point() + stat_smooth()

# Looks like a few houses threw off our model, but overall its not looking too bad considering we're pretty much treating it like a total black box.

# Conclusion¶
# Neural networks resemble black boxes a lot: explaining their outcome is much more difficult than explaining the outcome of simpler model such as a linear model. Therefore, depending on the kind of application you need, you might want to take into account this factor too. Furthermore, as you have seen above, extra care is needed to fit a neural network and small changes can lead to different results






