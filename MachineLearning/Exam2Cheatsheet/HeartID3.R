df <- read.csv('Heart.csv')
df <- df[,-1]
df <- na.omit(df)

library(RWeka)

