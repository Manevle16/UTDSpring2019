# Import pandas, numpy, matplotlib, and seaborn.
from sklearn import metrics
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Read in the Ecommerce Customers csv file as a DataFrame called customers.
customers = pd.read_csv('Ecommerce Customers')
# Check the head of customers, and check out its info() and describe() methods.
print(customers.head())
print(customers.info())
print(customers.describe())

# Use seaborn to create a jointplot to compare the Time on Website and Yearly Amount Spent columns. Does the correlation make sense?
sns.jointplot(data=customers, x='Time on Website', y='Yearly Amount Spent')
plt.show()

# Do the same but with the Time on App column instead.
sns.jointplot(data=customers, x='Time on App', y='Yearly Amount Spent')
plt.show()

# Use jointplot to create a 2D hex bin plot comparing Time on App and Length of Membership.
sns.jointplot(data=customers, x='Time on App', y='Length of Membership', kind='hex')
plt.show()

# Let's explore these types of relationships across the entire data set. Use pairplot to recreate the plot below.(Don't worry about the the colors)
sns.pairplot(customers)
plt.show()

# Based off this plot what looks to be the most correlated feature with Yearly Amount Spent?
# The Length of membership

# Create a linear model plot(using seaborn's lmplot) of Yearly Amount Spent vs. Length of Membership.
# customers and a variable y equal to the "Yearly Amount Spent" column.
sns.lmplot(data=customers, x='Yearly Amount Spent', y='Length of Membership')
plt.show()

# Use model_selection.train_test_split from sklearn to split the data into training and testing sets. Set test_size=0.3 and random_state=101
# Set a variable X equal to the numerical features of the customers and a variable y equal to the "Yearly Amount Spent" column. **
x = customers[['Avg. Session Length', 'Time on App', 'Time on Website', 'Length of Membership']]
y = customers['Yearly Amount Spent']
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=.3, random_state=101)

# Import LinearRegression from sklearn.linear_model
# Some atom package automatically puts the import at top

# Create an instance of a LinearRegression() model named lm.
lm = LinearRegression()

# Train/fit lm on the training data.
lm.fit(x_train, y_train)
# Print out the coefficients of the model
print(pd.DataFrame(lm.coef_, x.columns, columns=['Coefficient']))

# Use lm.predict() to predict off the X_test set of the data.
predicted = lm.predict(x_test)
# Create a scatterplot of the real test values versus the predicted values.
plt.scatter(y_test, predicted)
plt.xlabel('Test')
plt.ylabel('Predicted')
plt.show()
# Calculate the Mean Absolute Error, Mean Squared Error, and the Root Mean Squared Error. Refer to the lecture or to Wikipedia for the formulas
print("MAE: ", metrics.mean_absolute_error(y_test, predicted))
print("MSE: ", metrics.mean_squared_error(y_test, predicted))
print("RMSE: ", np.sqrt(metrics.mean_absolute_error(y_test, predicted)))

# Plot a histogram of the residuals and make sure it looks normally distributed. Use either seaborn distplot, or just plt.hist().
residuals = predicted - y_test
sns.distplot(residuals, hist=True)
plt.show()
# Recreate the dataframe below.
print(pd.DataFrame(lm.coef_, x.columns, columns=['Coefficient']))

# How can you interpret these coefficients?
# That the length of memebership, time on app, and avg. session length have a significant positive correlation with the
# yearly amount of money spent

# Do you think the company should focus more on their mobile app or on their website?
# Their mobile app since the more time people spend on their app reflets in a greater increase of yearly money spent
# compared to the time spent on the website
# Ref: www.pieriandata.com
