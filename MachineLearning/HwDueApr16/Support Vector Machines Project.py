"""
Support Vector Machines Project
Welcome to your Support Vector Machine Project! Just follow along with the
notebook and instructions below. We will be analyzing the famous iris data
set!

The Data
For this series of lectures, we will be using the famous Iris flower data set.
The Iris flower data set or Fisher's Iris data set is a multivariate data
set introduced by Sir Ronald Fisher in the 1936 as an example of discriminant
analysis. The data set consists of 50 samples from each of three species of
Iris (Iris setosa, Iris virginica and Iris versicolor), so 150 total samples.
Four features were measured from each sample: the length and the width of the
sepals and petals, in centimeters. Here's a picture of the three different
Iris types:

"""

"""The iris dataset contains measurements for 150 iris flowers from three different species.
The three classes in the Iris dataset:

Iris-setosa (n=50)
Iris-versicolor (n=50)
Iris-virginica (n=50)
The four features of the Iris dataset:

sepal length in cm
sepal width in cm
petal length in cm
petal width in cm
Get the data
"""
# Use seaborn to get the iris data
from sklearn import datasets
import numpy as np
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split as tts
from sklearn.svm import SVC
data = datasets.load_iris()
Iris = pd.DataFrame(data.data, columns=data.feature_names)
print(Iris.head())
Iris["Species"] = pd.Series(data.target)

"""
Let's visualize the data and get you started!
Exploratory Data Analysis
Time to put your data viz skills to the test! Try to recreate the following plots, make sure to import the libraries you'll need!
Import some libraries you think you'll need.
"""

# ** Create a pairplot of the data set. Which flower species seems to be the most separable?**
# sns.pairplot(Iris)


# Create a kde plot of sepal_length versus sepal width for setosa species of flower.
sns.kdeplot(Iris['sepal length (cm)'], Iris['sepal width (cm)'])
plt.show()
# Train Test Split
# ** Split your data into a training set and a testing set.**
x = Iris[['sepal length (cm)',  'sepal width (cm)',  'petal length (cm)',  'petal width (cm)']]
x_train, x_test, y_train, y_test = tts(x, Iris['Species'], test_size=.2, random_state=101)

# Train a Model
# Now its time to train a Support Vector Machine Classifier.
# Call the SVC() model from sklearn and fit the model to the training data.

model = SVC().fit(x_train, y_train)
# Model Evaluation
# Now get predictions from the model and create a confusion matrix and a classification report.
predictions = model.predict(x_test)

from sklearn.metrics import classification_report, confusion_matrix
print(confusion_matrix(y_test, predictions))
print(classification_report(y_test, predictions))

# Gridsearch Practice
# ** Import GridsearchCV from SciKit Learn.**
from sklearn.model_selection import GridSearchCV

# Create a dictionary called param_grid and fill out some parameters for C and gamma.
# ** Create a GridSearchCV object and fit it to the training data.**
param_grid = {'C': [0.1, 1, 10, 100, 1000], 'gamma': [1, 0.1, 0.01, 0.001, 0.0001], 'kernel': ['rbf']}
grid = GridSearchCV(SVC(), param_grid, refit=True, verbose=3)
grid.fit(x_train, y_train)

# ** Now take that grid model and create some predictions using the test set and create classification reports and confusion matrices for them.
# Were you able to improve?**
predictions = grid.predict(x_test)
print(confusion_matrix(y_test, predictions))
print(classification_report(y_test, predictions))
