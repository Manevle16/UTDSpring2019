# FIX: https://archive.ics.uci.edu/ml/datasets/Student+Performance
# Read CSV, note the delimiter (sep)
df <- read.csv('student-mat.csv',sep=';')
head(df)
summary(df)
any(is.na(df))
str(df) # check for the data types, factors, etc

install.packages('corrgram')
install.packages('corrplot')
install.packages('ggthemes')
install.packages('dplyr')

library(ggplot2)
library(ggthemes)
library(dplyr)

# understand the correlation
# consider only the numeric columns
num.cols <- sapply(df, is.numeric)
print(num.cols)
# filter
cor.data <- cor(df[,num.cols])
print(cor.data)
     
# plot out correlation diagrams                                                                                                                                                                                                                                                                                    
library(corrgram) # corr -> association or relation
library(corrplot)

print(corrplot(cor.data, method = 'color'))

# not doing numerical columns
corrgram(df)

# checkout the links and notes 
help("corrgram")

# PCA based ordering: order=TRUE
corrgram(df, order=TRUE, lower.panel = panel.shade,
         upper.panel = panel.pie, text.panel = panel.txt)

# we will predict on G3
pl <- ggplot(df, aes(x=G3)) 
pl <- pl + geom_histogram(bins=20, alpha=0.5,fill='blue')
pl

#Ref: www.pieriandata.com