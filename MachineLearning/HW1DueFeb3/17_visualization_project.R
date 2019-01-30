# Data Visualization Project

# 1. Import the ggplot2 data.table libraries and use fread to load the 
# csv file 'Economist_Assignment_Data.csv' into a dataframe called df 
# (Hint: use drop=1 to skip the first column) 

# 2. Check the head of df 

# 3. Use ggplot() + geom_point() to create a scatter plot object called 
#    pl. You will need to specify x=CPI and y=HDI and color=Region as 
#    aesthetics

# 4. Change the points to be larger empty circles. 
#    (You'll have to go back and add arguments to geom_point() and 
#    reassign it to pl.) You'll need to figure out what shape= and 
#    size= 

# 5. Add geom_smooth(aes(group=1)) to add a trend line 

# 6. We want to further edit this trend line. Add the following arguments to geom_smooth (outside of aes): 
#    method = 'lm'
#    formula = y ~ log(x)
#    se = FALSE
#    color = 'red'
#    Assign all of this to pl2 

# 7. It's really starting to look similar! But we still need to add 
#    labels, we can use geom_text! Add geom_text(aes(label=Country)) 
#    to pl2 and see what happens. (Hint: It should be way too many 
#    labels) 

pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl3 <- pl2 + geom_text(aes(label = Country), color = "gray20", 
                       data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)

pl3

# 8. Add theme_bw() to your plot and save this to pl4
# 9. Add scale_x_continuous() and set the following arguments:
#    name = Same x axis as the Economist Plot
#    limits = Pass a vector of appropriate x limits
#    breaks = 1:10

# 10. Now use scale_y_continuous to do similar operations to the y axis! 
# 11. Finally use ggtitle() to add a string as a title. 








