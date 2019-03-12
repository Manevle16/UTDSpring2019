# Man160530

# Import a few libraries you think you'll need
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix

# Read in the advertising.csv file and set it to a data frame called ad_data.
ad_data = pd.read_csv('advertising.csv')

# Check the head of ad_data
print(ad_data.head())

# Use info and describe() on ad_data
print(ad_data.info())
print(ad_data.describe())

# Exploratory Data Analysis
# Create a histogram of the Age
sns.distplot(ad_data['Age'], hist=True)
plt.show()

# Create a jointplot showing Area Income versus Age.
sns.jointplot(data=ad_data, x='Area Income', y='Age')
plt.show()

# Create a jointplot of 'Daily Time Spent on Site' vs. 'Daily Internet Usage'
sns.jointplot(data=ad_data, x='Daily Time Spent on Site', y='Daily Internet Usage')
plt.show()

# Finally, create a pairplot with the hue defined by the 'Clicked on Ad' column feature.
sns.pairplot(hue='Clicked on Ad', data=ad_data, diag_kind="hist", aspect=.8)
plt.show()

# Logistic Regression
# Split the data into training set and testing set using train_test_split
x = ad_data[['Age', 'Area Income', 'Daily Internet Usage', 'Daily Time Spent on Site', 'Male']]
y = ad_data['Clicked on Ad']
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=.2, random_state=101)

# Train and fit a logistic regression model on the training set.
logModel = LogisticRegression().fit(x_train, y_train)

# Predictions and Evaluations
# Now predict values for the testing data.
predictions = logModel.predict(x_test)

# Create a classification report for the model.
print(classification_report(y_test, predictions))
#
# precision    recall  f1-score   support

# 0       0.87      0.96      0.91       162
# 1       0.96      0.86      0.91       168

# avg / total       0.91      0.91      0.91       330

#
print(confusion_matrix(y_test, predictions))
#Ref: www.pieriandata.com
