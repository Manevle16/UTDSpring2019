library(ggplot2)
library(ggthemes)
head(mpg)
df <- data.frame(mpg)
# 1. Histogram of hwy mpg values:
ggplot(data = df, aes(x=hwy)) + geom_histogram()
# 2. Barplot of car counts per manufacturer with color fill defined 
#    by cyl count
ggplot(data = df, aes(x = manufacturer, fill = factor(cyl))) + geom_bar()

head(txhousing)
df <- data.frame(txhousing)
# 3. Create a scatterplot of volume versus sales. Afterwards play 
#    around with alpha and color arguments to clarify information.
pl <- ggplot(df, aes(x = volume, y = sales)) + geom_point(aes(color=factor(year)))
# 4. Add a smooth fit line to the scatterplot from above. 
#    Hint: You may need to look up geom_smooth()
pl + geom_smooth()

