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
print(lm)
# print(lm.fit(X_train, y_train))  # train or fit the model on train data

"""
The intercept (often labeled the constant) is the expected mean value of Y when all X=0.
Start with a regression equation with one predictor, X.
 If X sometimes equals 0, the intercept is simply the expected mean value of Y at that value.
"""
# print the intercept
# print(lm.intercept_)

# artificial data - try Boston data
#from sklearn.datasets import load_boston
# boston = load_boston()  # dtict
# print(boston['DESCR'])
# print(boston['data'])
# print(boston['feature_names'])
# print(boston['target'])
# print(boston.keys())

coeff_df = pd.DataFrame(lm.coef_, X.columns, columns=['Coefficient'])
# print(coeff_df)

predictions = lm.predict(X_test)
plt.scatter(y_test, predictions)

#sns.distplot((y_test-predictions), bins=50)
plt.show()
#Ref: www.pieriandata.com
