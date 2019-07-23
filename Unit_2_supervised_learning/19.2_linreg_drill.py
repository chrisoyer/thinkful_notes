#!/usr/bin/env python
# coding: utf-8
'''
output is lrm model
'''
import numpy as np
import pandas as pd

from sklearn.decomposition import PCA
from sklearn import linear_model
from sklearn.preprocessing import StandardScaler

import matplotlib.pyplot as plt
import seaborn as sns
from sqlalchemy import create_engine
from scipy.stats import mode

#credentials
user = 'dsbc_student'
pw = '7*.8G9QH21'
host = '142.93.121.174'
port = '5432'
db = 'houseprices'
dialect = 'postgresql'

engine = create_engine('{}://{}:{}@{}:{}/{}'.format(dialect, user, pw, host, port, db))
engine.table_names()

sql_query = '''
SELECT
    *
FROM
    houseprices
'''
source_df = pd.read_sql(sql_query, con=engine)
engine.dispose()
house_df = source_df.copy()
for column in house_df.columns[house_df.dtypes== 'object']:
    print("Column {} has values {}".format(column, house_df[column].unique()))
#fillvalues
missing_numerical = ['lotfrontage', 'masvnrarea', 'garageyrblt']
for miss in missing_numerical: #column-wise
    house_df[miss] = house_df[miss].fillna(house_df[miss].mean()) #fill with column mean
    
missing_cat_ob = house_df.dtypes[house_df.isna().sum() > 0]
missing_categorical = missing_cat_ob[missing_cat_ob == 'object'].index
for miss in missing_categorical:
    house_df[miss] = house_df[miss].fillna(house_df[miss].value_counts().index[0])  #fill with most common value

categorical_feat = house_df.dtypes[house_df.dtypes == 'object'].index
new_categories_df = pd.DataFrame()
for feature in categorical_feat:
    new_categories_df = pd.concat([new_categories_df, 
                                   pd.get_dummies(house_df[feature], columns=categorical_feat, drop_first=True)], axis=1)
new_categories_df = pd.concat([new_categories_df, 
                               house_df.filter(items=(house_df.columns[(house_df.dtypes.values != 'object').tolist()]), axis=1) ], 
                              axis=1) #tolist() needed to avoid hashability issue

#Find highly (>.95) correlated values and drop
house_corr_df = house_df.corr()
house_corr_df[house_corr_df >.95].notna()#.any()

#standardize data and compute PCA
pca = PCA()
scaler = StandardScaler()
X = scaler.fit_transform(new_categories_df.drop(["saleprice"], axis=1))
y = new_categories_df.saleprice

pca.fit(X)
pca.explained_variance_ratio_

sns.set_style('darkgrid')
plt.figure(figsize=(15,5))
sns.lineplot(data=np.cumsum(pca.explained_variance_ratio_), marker="o")
plt.title("Cumulative Variance explained");

pca_75 = PCA(n_components=75)
X_pca = pca_75.fit_transform(X)
lrm = linear_model.LinearRegression()
lrm.fit(X_pca, y)
lrm

print('\nCoefficients: \n', lrm.coef_)
print('\nIntercept: \n', lrm.intercept_)




