import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# this generate random data for dataset. starts from 2023-1-1 to till now 
np.random.seed(42)
dates = pd.date_range(start="2023-01-01", periods=100)
companies = ['Apple', 'Microsoft', 'Google', 'Amazon', 'Tesla']
data = {
    'Date': dates,
    'Apple': np.random.normal(loc=150, scale=20, size=100),
    'Microsoft': np.random.normal(loc=250, scale=30, size=100),
    'Google': np.random.normal(loc=1800, scale=150, size=100),
    'Amazon': np.random.normal(loc=3300, scale=200, size=100),
    'Tesla': np.random.normal(loc=700, scale=100, size=100),
    'Volume_Apple': np.random.randint(1e6, 5e6, size=100),
    'Volume_Microsoft': np.random.randint(2e6, 6e6, size=100),
    'Volume_Google': np.random.randint(3e6, 7e6, size=100),
    'Volume_Amazon': np.random.randint(4e6, 8e6, size=100),
    'Volume_Tesla': np.random.randint(5e6, 9e6, size=100)
}

df = pd.DataFrame(data)
# change data file into .csv file
df.to_csv('share_market_data.csv', index=False)
print(df.head())


# line plot for all company share prices
sns.lineplot(x='Date', y='value', hue='variable', 
             data=pd.melt(df, ['Date'], value_vars=companies), 
             palette='tab10', linewidth=2.5)
plt.title('Line Plot of Share Prices', fontsize=16)
plt.xlabel('Date', fontsize=14)
plt.ylabel('Share Price', fontsize=14)
plt.legend(title='Company', title_fontsize='13', fontsize='11')
plt.xticks(rotation=45)
plt.show()

# bar plot for based on prices
sns.barplot(x='Date', y='Apple', data=df, color='skyblue')
plt.title('Bar Plot of Apple Share Prices', fontsize=16)
plt.xlabel('Date', fontsize=14)
plt.ylabel('Share Price', fontsize=14)
plt.xticks(rotation=45)
plt.show()

# box plot
sns.boxplot(data=df[companies])
plt.title('Box Plot of Share Prices', fontsize=16)
plt.xlabel('Company', fontsize=14)
plt.ylabel('Share Price', fontsize=14)
plt.show()

# scatter plot for apple vs microsft share price based on volume
sns.scatterplot(x='Apple', y='Microsoft', data=df, hue='Volume_Apple', palette='viridis', s=100, edgecolor='w', alpha=0.8)
plt.title('Scatter Plot of Apple vs Microsoft Share Prices', fontsize=16)
plt.xlabel('Apple Share Price', fontsize=14)
plt.ylabel('Microsoft Share Price', fontsize=14)
plt.legend(title='Volume Apple', title_fontsize='13', fontsize='11')
plt.show()

# heat map for all data
sns.heatmap(df.corr(), annot=True, cmap='coolwarm', linewidths=0.5, linecolor='white')
plt.title('Heatmap of Share Market Data', fontsize=16)
plt.xticks(rotation=45)
plt.yticks(rotation=0)
plt.show()

# kde plot based on share price
sns.kdeplot(df['Apple'], shade=True, label='Apple', color='blue')
sns.kdeplot(df['Microsoft'], shade=True, label='Microsoft', color='green')
sns.kdeplot(df['Google'], shade=True, label='Google', color='red')
sns.kdeplot(df['Amazon'], shade=True, label='Amazon', color='orange')
sns.kdeplot(df['Tesla'], shade=True, label='Tesla', color='purple')
plt.title('KDE Plot of Share Prices', fontsize=16)
plt.xlabel('Share Price', fontsize=14)
plt.ylabel('Density', fontsize=14)
plt.legend(title='Company', title_fontsize='13', fontsize='11')
plt.show()

# histogram plot based on shareprice
sns.histplot(df['Microsoft'], kde=True, bins=20, color='purple', alpha=0.6)
plt.title('Histogram of Microsoft Share Prices', fontsize=16)
plt.xlabel('Share Price', fontsize=14)
plt.ylabel('Frequency', fontsize=14)
plt.show()
