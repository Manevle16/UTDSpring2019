install.packages('dplyr')
library(dplyr)
head(mtcars)
df <- data.frame(mtcars)
df
# 1. Return rows of cars that have an mpg value greater than 20 and 6 cylinders. 
filter(df, mpg > 20 & cyl == 6) 
# 2. Reorder the Data Frame by cyl first, then by descending wt. 
arrange(df, cyl, desc(wt))
# 3. Select the columns mpg and hp
select(df, mpg, hp)
# 4. Select the distinct values of the gear column. 
distinct(df, gear)
# 5. Create a new column called "Performance" which is calculated by hp 
#    divided by wt. 
mutate(df, Performance = hp/wt)
# 6. Find the mean mpg value using dplyr. 
summarise(df, mean(hp))
# 7. Use pipe operators to get the mean hp value for cars with 6 cylinders. 
df %>%
  filter(cyl == 6) %>%
  summarise(mean = mean(hp), n = n())

mean(filter(df, cyl == 6)$hp)
