#Name: Matthew Nevle
#NetID: Man160530

#*************** Problem 1 **********************************

#(a)
library(ISLR)
df <- Auto
names(df)
summary(df)

#(b)
model <- lm(mpg ~ horsepower, df)
summary(model)

#Equation: mpg = -0.157845*horsepower + 39.935861
#There is a weak negative relationship between horsepower and mpg because the R^2 value is only around .6

#(c)
predict(model, data.frame(horsepower = 98))

predict(model, data.frame(horsepower = 98), interval = "confidence")

#(d)
plot(df$horsepower, df$mpg)

abline(model)

#(e)
#Not sure what 2x2 arrangement means, so i plotted the above graph 4 times in a 2x2 arrangement with the fit line
par(mfrow=c(2,2))

for(i in 1:4){
  plot(df$horsepower, df$mpg)
  abline(model)
}
#Yes there is non-linearity present as shown through the residuals growing larger as the horsepower deviates 
#further from its median median


#**************** Problem 2 **********************************
library(dplyr)
#(a)
pairs(df)

#(b)
cor(select(df, -name))

#(c)
model <- lm(mpg ~ . -name, df)

summary(model)

#The significant predictors of mpg are displacement, weight, year, and orgin.

#(d)
par(mfrow=c(2,2))

#Residuals vs Fitted
#Residuals is not evenly distrubuted in graph indicating the model is not a good fit 
plot(model, which = 1)  

#Normal Q-Q
#The upper tail is greater than expected stating that the model might not be a good fit
plot(model, which = 2)

#Scale-Location
#The residuals are shown to be spread evenly resulting in a horizontal fit line for the graph, this indicates
#that the model is a good fit
plot(model, which = 3)


#(e)
#This is a very vague question.
newModel <- lm(mpg ~ +displacement * weight, df)

#(f)
model <- lm(mpg ~ +log(weight) +sqrt(horsepower) + acceleration + I(acceleration^2),df)
summary(model)

plot(model, which = 1)

#(g)
model2 <- lm(log(mpg) ~ . -name, df)
