import matplotlib.pyplot as plt
import numpy as np

# Pie Chart 
categories = ['Data Science', 'Web Development', 'Mobile Apps', 'Other']
sizes = [35, 30, 25, 10]
colors = ['blue', 'green', 'orange', 'purple']
explode = [0.1, 0, 0, 0]

plt.pie(sizes, labels=categories, colors=colors, explode=explode, autopct='%1.1f%%', shadow=True, startangle=140)
plt.title("Distribution of Job Roles")
plt.show()

# Line Plot 
months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
temperatures_2023 = [30, 32, 35, 40, 42, 45, 38, 35, 32, 30, 28, 26]
temperatures_2024 = [28, 30, 33, 38, 40, 43, 37, 34, 30, 28, 27, 25]

plt.plot(months, temperatures_2023, color='blue', marker='o', linestyle='-', label='2023')
plt.plot(months, temperatures_2024, color='red', marker='s', linestyle='--', label='2024')
plt.title('Average Monthly Temperatures')
plt.xlabel('Month')
plt.ylabel('Temperature (°C)')
plt.legend()
plt.annotate('Heatwave', xy=('Jun', 45), xytext=('Apr', 48), arrowprops=dict(facecolor='black', shrink=0.05))
plt.grid(True)
plt.show()

# bar plot
countries = ['USA', 'China', 'India', 'Germany', 'UK']
medals = [56, 70, 45, 30, 25]

plt.barh(countries, medals, color='cyan')
plt.title('Olympic Medals by Country')
plt.xlabel('Number of Medals')
plt.ylabel('Country')
plt.show()


 # Scatter Plot 
girls_grades = [89, 90, 70, 89, 100, 80, 90, 100, 80, 34]
boys_grades = [30, 29, 49, 48, 100, 48, 38, 45, 20, 30]
grades_range = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

plt.scatter(grades_range, girls_grades, color='r', label='Girls')
plt.scatter(grades_range, boys_grades, color='b', label='Boys')
plt.xlabel('Grades Range')
plt.ylabel('Grades Scored')
plt.title('Scatter Plot of Grades')
plt.legend()
plt.show()


x1 = np.array([89, 43, 36, 36, 95, 10, 66, 34, 38, 20])
y1 = np.array([21, 46, 3, 35, 67, 95, 53, 72, 58, 10])
x2 = np.array([26, 29, 48, 64, 6, 5, 36, 66, 72, 40])
y2 = np.array([26, 34, 90, 33, 38, 20, 56, 2, 47, 15])

plt.scatter(x1, y1, c="pink", linewidths=2, marker="s", edgecolor="green", s=100)
plt.scatter(x2, y2, c="yellow", linewidths=2, marker="^", edgecolor="red", s=200, alpha=0.6)
plt.xlabel("X-axis")
plt.ylabel("Y-axis")
plt.title("Scatter Plot with Multiple Datasets")
plt.grid(True, linestyle='--', alpha=0.6)
plt.legend(["Dataset 1", "Dataset 2"], loc="upper right")
plt.show()
