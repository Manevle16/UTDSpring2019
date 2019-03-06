import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import os

os.chdir('C:\\Users\kkhan\Documents\_CS Outreach\Python\Python Source Files')
train = pd.read_csv('titanic_train.csv')
train.head()

sns.heatmap(train.isnull(), yticklabels=False, cbar=False, cmap='viridis')
plt.show()

sns.set_style('whitegrid')
sns.countplot(x='Survived', data=train, palette='RdBu_r')
plt.show()

sns.set_style('whitegrid')
sns.countplot(x='Survived', hue='Sex', data=train, palette='RdBu_r')
plt.show()

sns.set_style('whitegrid')
sns.countplot(x='Survived', hue='Pclass', data=train, palette='rainbow')
plt.show()

sns.distplot(train['Age'].dropna(), kde=False, color='darkred', bins=30)
plt.show()

sns.countplot(x='SibSp', data=train)
plt.show()

train['Fare'].hist(color='green', bins=40, figsize=(8, 4))
+Ref: www.pieriandata.com
