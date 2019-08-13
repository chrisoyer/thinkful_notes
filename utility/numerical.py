#!/usr/bin/env python
# coding: utf-8

# In[1]:


def winsorize(data=[], lower=.05, upper=.95):
    '''Winsorizes an array. Defaults are at .05 and .95 of unit rank. 
    '''
    pcts = np.percentile(data, q=[lower, upper])
    w_ized = []
    for i in data:
        if i<pcts[0]:
            w_ized.append(pcts[0])
        elif i>pcts[1]:
            w_ized.append(pcts[1])
        else: 
            w_ized.append(i)
    return w_ized


# In[3]:


def corr_finder(df, min=.65):
    corr = df[(df.abs() > min) & ~(df == 1)]
    for i, row in df.iterrows():
        if row.sum() > 0: 
            print("{} is correlated with: ".format(i), end = '') 
            for ind, col in row.iteritems():
                if ~np.isnan(col):
                    print("{} at {}".format(ind, col))
            print("\n")


# In[ ]:




