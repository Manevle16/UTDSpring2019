import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import os

print(os.getcwd())  # C:\Users\kkhan\Documents\_CS Outreach\Python\Python Source Files\Nov 10 2018
#os.chdir('C:\\Users\kkhan\Documents\_CS Outreach\Python\Python Source Files')
# print(os.getcwd())

USAhousing = pd.read_csv('USA_Housing.csv')
print(USAhousing.head())
print(USAhousing.info())
USAhousing.describe()
USAhousing.columns

# sns.pairplot(USAhousing)
# plt.show()

# sns.distplot(USAhousing['Price'])
# plt.show()

# sns.heatmap(USAhousing.corr())
# plt.show()
correlation = USAhousing.corr()
print(correlation)
plt.figure(figsize=(15, 50))
g = sns.heatmap(correlation, vmax=1, square=True, annot=True,
                cmap='cubehelix', xticklabels=True, yticklabels=True)
g = sns.heatmap(correlation, annot=True)
g.set_yticklabels(g.get_yticklabels(), rotation=0)
g.set_xticklabels(g.get_yticklabels(), rotation=90)
plt.title('Correlation between different fearures')
# sns.heatmap(USAhousing.corr())
plt.show()
#Ref: www.pieriandata.com
