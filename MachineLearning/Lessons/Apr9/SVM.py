import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

from sklearn.datasets import load_breast_cancer
cancer = load_breast_cancer()
cancer.keys()
print(cancer['DESCR'])
cancer['feature_names']
df_feat = pd.DataFrame(cancer['data'], columns=cancer['feature_names'])
df_feat.head(2)
df_feat.info()
cancer['target']
cancer['target_names']
df_target = pd.DataFrame(cancer['target'], columns=['Cancer'])
df_target.head()

from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(
    df_feat, np.ravel(df_target), test_size=0.30, random_state=101)

from sklearn.svm import SVC
model = SVC()
print(model)
model.fit(X_train, y_train)
predictions = model.predict(X_test)

from sklearn.metrics import classification_report, confusion_matrix
print(confusion_matrix(y_test, predictions))
print('\n')
print(classification_report(y_test, predictions))

# models needs to have parameters adjusted or may help to normalize the data as well
# use GridSearch to find the right parameters...which C and gamma values to used
# GridSearchCV takes the dictionary of the parameters that should be tried
# Read the book ISLR
# param_grid = {'C': [0.1, 1, 10, 100, 1000], 'gamma': [1, 0.1, 0.01, 0.001, 0.0001]}
param_grid = {'C': [0.1, 1, 10, 100, 1000], 'gamma': [1, 0.1, 0.01, 0.001, 0.0001], 'kernel': ['rbf']}

from sklearn.model_selection import GridSearchCV
grid = GridSearchCV(SVC(), param_grid, refit=True, verbose=3)

# May take awhile!
# runs cross validation to get the best parameter setting
grid.fit(X_train, y_train)
grid.best_params_
grid.best_estimator_
# rerun our model with these parameters
grid_predictions = grid.predict(X_test)
print(confusion_matrix(y_test, grid_predictions))
print('\n')
print(classification_report(y_test, grid_predictions))
