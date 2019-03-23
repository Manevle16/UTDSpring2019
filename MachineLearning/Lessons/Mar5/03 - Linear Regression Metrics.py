import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import os

from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression

os.chdir('C:\\Users\kkhan\Documents\_CS Outreach\Python\Python Source Files')
USAhousing = pd.read_csv('USA_Housing.csv')

X = USAhousing[['Avg. Area Income', 'Avg. Area House Age', 'Avg. Area Number of Rooms',
                'Avg. Area Number of Bedrooms', 'Area Population']]
y = USAhousing['Price']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.4, random_state=101)

lm = LinearRegression().fit(X_train, y_train)  # Linear Regression Object

coeff_df = pd.DataFrame(lm.coef_, X.columns, columns=['Coefficient'])

predictions = lm.predict(X_test)
print(predictions)
print(y_test)

# How far off the predictions from the test prices, the actual prices?
plt.scatter(y_test, predictions)

# risiduals: a difference between a value measured in a scientific experiment and the theoretical or true value.
# normally distributed risiduals are good sign; if not then go back and look at the model if it was a correct choice
sns.distplot((y_test-predictions), bins=50)
plt.show()

"""
Regression Evaluation Metrics - Here are three common evaluation metrics for regression problems:

Mean Absolute Error(MAE) is the mean of the absolute value of the errors
Mean Squared Error(MSE) is the mean of the squared errors
Root Mean Squared Error(RMSE) is the square root of the mean of the squared errors

Comparing these metrics:
•   MAE is the easiest to understand, because it's the average error.
•   MSE is more popular than MAE, because MSE "punishes" larger errors, which tends to be useful in the real world.
•   RMSE is even more popular than MSE, because RMSE is interpretable in the "y" units.

All of these are loss functions, we want to minimize them
"""

from sklearn import metrics
print('MAE:', metrics.mean_absolute_error(y_test, predictions))
print('MSE:', metrics.mean_squared_error(y_test, predictions))
print('RMSE:', np.sqrt(metrics.mean_squared_error(y_test, predictions)))
#Ref: www.pieriandata.com
