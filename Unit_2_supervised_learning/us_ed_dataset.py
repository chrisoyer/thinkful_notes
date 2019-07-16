#!/usr/bin/env python
# coding: utf-8

import pandas as pd
import numpy as np
from sqlalchemy import create_engine
import matplotlib.pyplot as plt
import seaborn as sns

#database values
postgres_user = 'dsbc_student'
postgres_pw = '7*.8G9QH21'
postgres_host = '142.93.121.174'
postgres_port = '5432'
postgres_db = 'useducation'

engine = create_engine('postgresql://{}:{}@{}:{}/{}'.format(
    postgres_user, postgres_pw, postgres_host, postgres_port, postgres_db))
usedu_df = pd.read_sql_query('select * from useducation',con=engine)
engine.dispose()

#remove poorly reporting jurisdictions
def remove_nonstate(df):
    df = df[df.ENROLL.notna()]
    return df

usedu_stateonly_df = remove_nonstate(usedu_df)

#state groups to see where missing value are and plot
def plot_nulls(datasource):
    datasource = datasource.groupby('STATE').apply(lambda x: x.isna().sum() / x.count())#.transpose()
    sns.set(style="whitegrid", palette="pastel")
    f2, ax2 = plt.subplots(figsize=(15, 7))
    ax2 = sns.heatmap(datasource, vmin=0, vmax=1)
#plot_nulls(usedu_df) 


usedu_stateonly_df = usedu_stateonly_df.sort_values(by=["YEAR"]).groupby('STATE').apply(lambda x: x.interpolate())

#usedu_stateonly_df[usedu_stateonly_df.isna().any(axis=1)]

#replace remaining nulls with state mean for column
def statecolmean(df):
    df1 = df
    for column in df1.columns:
        try:
            df1[column] = df1.groupby('STATE')[column].transform(lambda x: x.fillna(x.mean()))
        except TypeError:
            pass
    return df1
used_cl_df = statecolmean(usedu_stateonly_df)    



