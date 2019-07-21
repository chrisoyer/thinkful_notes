
# coding: utf-8

# In[2]:


import numpy as np
import pandas as pd
import matplotlib.pylab as plt
import seaborn as sns
from zipfile import ZipFile
import urllib.request
import os
from sklearn import naive_bayes
#import data to DF
yelp_df = pd.read_csv(r'C:\Users\User\Documents\Github\thinkful_notes\data_sets\sentiment_labelled_sentences\yelp_labelled.txt', sep='\t', header=None)

yelp_df.rename(index=str, columns={0:'sentence', 1:'score'}, inplace=True)

pd.set_option('display.max_colwidth', 120)
yelp_df.head(20)

#build classifier
keywords = ['loved', 'prompt', 'overpriced', 'slow', 'tasty', 'delicious', 'favorite', 'angry', 'great', 'would not']
for kword in keywords:
    yelp_df[kword] = yelp_df.sentence.str.contains(' ' + str(kword) + '[ \.]', case=False)
yelp_df.head()


# In[45]:


yelp_df['yelling'] = yelp_df.sentence.str.isupper()


# In[46]:


yelp_df.shape


# In[49]:


yelp_df.iloc[:,2:-1].sum()


# In[50]:


#investigate keywords
sns.set_style(style='dark')
sns.heatmap(yelp_df.corr());


# In[51]:


data = yelp_df.iloc[:,2:-1]
target = yelp_df.score
data.head()


# In[52]:


#model
nb_bernou = naive_bayes.BernoulliNB()
nb_bernou.fit(data, target)

#predict
y_predict = nb_bernou.predict(data)

#result
print('model correctly predicted {} and missed {}'.format((y_predict==target).sum(),(y_predict!=target).sum()))


# In[53]:


yelp_df['y_predict'] = y_predict
yelp_df.head()


# In[54]:


y_predict_df = pd.DataFrame(y_predict)
results = pd.merge(yelp_df[['score']], y_predict_df, left_index=True, right_index=True)#indexes were not named
results.head()


# In[18]:


results = pd.concat([yelp_df.reset_index(), y_predict_df.reset_index()], axis=1) #reset_index fixed problem.
results.head()

