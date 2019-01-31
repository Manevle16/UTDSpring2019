df <- read.csv('student-mat.csv', sep=';')
head(df)
rownames(df)
summary(df) #get summary of columns in df
any(is.na(df)) #check if any NA values in df
str(df) #find structure of df columns

install.packages('corrgram')
install.packages('ggthemes')

library(ggplot2)
library(ggthemes)
library(dplyr)

num.cols <- sapply(df, is.numeric) #apply the is.numeric function to all the columns in df and return df
print(num.cols)


cor.data <- cor(df[,num.cols]) #get all col values where num.cols is true and correlate it
print(cor.data)

library(corrgram)
library(corrplot) 

print(corrplot(cor.data, method = 'color')) #plot correlation data on graph

print(corrgram(df))

#Creates a correlation graph where lower left panel uses shade, top right uses a pie, and middle is text
corrgram(df, order=TRUE, lower.panel = panel.shade, upper.panel = panel.pie, text.panel = panel.txt) 
