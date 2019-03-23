# Exploratory Data Analysis
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import os

os.chdir('C:\\Users\kkhan\Documents\_CS Outreach\Python\Python Source Files')
train = pd.read_csv('titanic_train.csv')
# print(train.head())
# print(train.isnull())

plt.figure(figsize=(12, 7))
sns.boxplot(x='Pclass', y='Age', data=train, palette='winter')
plt.show()


def impute_age(cols):
    Age = cols[0]
    Pclass = cols[1]
    if pd.isnull(Age):
        if Pclass == 1:
            return 37
        elif Pclass == 2:
            return 29
        else:
            return 24
    else:
        return Age


train['Age'] = train[['Age', 'Pclass']].apply(impute_age, axis=1)
sns.heatmap(train.isnull(), yticklabels=False, cbar=False, cmap='viridis')
# plt.show()

train.drop('Cabin', axis=1, inplace=True)
# train.head()

train.dropna(inplace=True)
# train.info()

# convert string to number for machine learning algorithm can understand
# print(pd.get_dummies(train['Sex']))
# avoid issue multicolinearity/predictor columns
sex = pd.get_dummies(train['Sex'], drop_first=True)
print(sex.head())
embark = pd.get_dummies(train['Embarked'], drop_first=True)
# print(embark.head())
train = pd.concat([train, sex, embark], axis=1)
# print(train.head())
train.drop(['Sex', 'Embarked', 'Name', 'Ticket'], axis=1, inplace=True)  # all data is numerical
print(train.head())
train.drop('PassengerId', axis=1, inplace=True)
print(train.head())

train.to_csv('train2.csv', index=False)
#Ref: www.pieriandata.com
