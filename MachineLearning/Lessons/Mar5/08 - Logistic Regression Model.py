# Exploratory Data Analysis
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import os

os.chdir('C:\\Users\kkhan\Documents\_CS Outreach\Python\Python Source Files')
train = pd.read_csv('train2.csv')
print(train.head())

from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix
from sklearn.metrics import classification_report

X = train.drop('Survived', axis=1)
y = train['Survived']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.33, random_state=42)

logmodel = LogisticRegression().fit(X_train, y_train)

predictions = logmodel.predict(X_test)
print(confusion_matrix(y_test, predictions))
print(classification_report(y_test, predictions))  # don't have to read from confusion matrix

"""
             precision    recall  f1-score   support

          0       0.81      0.93      0.86       163
          1       0.85      0.65      0.74       104

avg / total       0.82      0.82      0.81       267

"""
"""
You might want to explore other feature engineering and the other titanic_text.csv file, some suggestions for feature engineering:
•   Try grabbing the Title (Dr.,Mr.,Mrs,etc..) from the name as a feature
•   Maybe the Cabin letter could be a feature
•   Is there any info you can get from the ticket?
"""
#Ref: www.pieriandata.com
