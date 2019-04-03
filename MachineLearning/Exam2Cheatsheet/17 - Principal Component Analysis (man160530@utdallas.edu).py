# Principal Component Analysis

import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import seaborn as sns

from sklearn.datasets import load_breast_cancer
cancer = load_breast_cancer()
cancer.keys()
print(cancer['DESCR'])
df = pd.DataFrame(cancer['data'], columns=cancer['feature_names'])
cancer['target']
cancer['target_names']
df.head()
# difficult to visualize 30 feature_names
# we use PCA to determine the 2 components
from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
scaler.fit(df)
scaled_data = scaler.transform(df)

# PCA
from sklearn.decomposition import PCA
pca = PCA(n_components=2) # 2 principal components
pca.fit(scaled_data)
x_pca = pca.transform(scaled_data)
scaled_data.shape
x_pca.shape
plt.figure(figsize=(8, 6))
plt.scatter(x_pca[:, 0], x_pca[:, 1])
plt.xlabel('First principal component')
plt.ylabel('Second Principal Component')
print(x_pca)
# an array of each component
# each row PC and each column original features
pca.components_
plt.scatter(x_pca[:, 0], x_pca[:, 1], c=cancer['target'])
plt.scatter(x_pca[:, 0], x_pca[:, 1], c=cancer['target'], cmap='plasma')

# visualize with heatmap
df_comp = pd.DataFrame(pca.components_, columns=cancer['feature_names'])
df_comp
plt.figure(figsize=(12, 6))
sns.heatmap(df_comp, cmap='plasma',)
plt.show()
# This heatmap and the color bar basically represent the correlation between the various
# feature and the principal component itself.

# x_pca into a classification algorithm
# now you can do logistic regression on x_pca instead of on all features


#Ref: www.pieriandata.com
