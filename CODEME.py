# Area Calculator:
# Create a function Calculate_area(shape, dimensions) that takes the shape (e.g., "rectangle", "circle") and its dimensions as arguments.
# The function should calculate the area based on the shape and return the result.
# Implement logic for handling different shapes (rectangle, circle) and their corresponding dimensions (length, width for rectangle; radius for circle).
# Hint: Use if statements or a dictionary to handle different shapes.

def calculate_area(shape, dimensions):
    if shape.lower() == "rectangle":
        length, width = dimensions
        return length * width
    elif shape.lower() == "circle":
        radius, = dimensions
        return 3.14159 * (radius ** 2)
    else:
        return 0

print(calculate_area("rectangle", (10,4))) 
print(calculate_area("circle", (6)))  



# String Manipulation:
# Create a function reverse_words(text) that takes a string as input.
# The function should reverse the order of words in the string while maintaining the order of characters within each word. -Return the modified string.
# Hint: Use string methods like split and join to manipulate the words.

def reverse_words(text):
    words = text.split()
    reversed_words = words[::-1]
    return ' '.join(reversed_words)

print(reverse_words("hello world"))



# List Statistics:
# Create a function analyze_list(numbers) that takes a list of numbers as input.
# The function should calculate and return the following in a dictionary:
# Minimum value in the list
# Maximum value in the list
# Average value in the list (use sum and division)
# Use a dictionary to store and return the calculated statistics.
# Hint: Utilize built-in functions like min, max, and sum for calculations.

def analyze_list(numbers):
    stats = {
        minimum: min(numbers),
        maximum: max(numbers),
        average: sum(numbers) / len(numbers)
    }
    return stats

print(analyze_list[1,2,3,4,3,2,1,5,6,4,6,7,5,8,9])


# Filtering with Lambda:
# Create a list of product names (strings).
# Define a function filter_short_names(names, max_length) that takes the list of names and a maximum length as arguments.
# Use filter with a lambda function to return a new list containing only names shorter than the provided max_length.
# Hint: The lambda function should check the length of each name and return True if it's less than max_length.

def filter_short_names(names, max_length):
    return list(filter(lambda name: len(name) < max_length, names))

names = ["Aditya", "Edwin", "Gautam","Shiva"]
print(filter_short_names(name, 4))


# Text Analyzer (Bonus Challenge):
# Create a function analyze_text(text) that takes a block of text as input.
# The function should:
# Count the number of words in the text (split by whitespace).
# Count the number of characters (excluding whitespaces).
# Find the most frequent word (you can assume case-insensitive matching for simplicity).
# Return a dictionary containing these counts and the most frequent word.
# Hint: This might involve using loops, string methods, and potentially keeping track of word occurrences in a dictionary.

def analyze_text(text):
    lower_text = text.lower()
    words = lower_text.split()
    word_count = len(words)
    
    char_count = 0
    for char in lower_text:
        if not char.isspace():
            char_count += 1
            
    word_freq = {}
    for word in words:
        if word in word_freq:
            word_freq[word] += 1
        else:
            word_freq[word] = 1
            
    most_common_word = max(word_freq, key=word_freq.get) if word_freq else None

    analysis = {
        'word_count': word_count,
        'char_count': char_count,
        'most_common_word': most_common_word
    }
    
    return analysis

text = "Today is very Special for those Who want to Peace."
print(analyze_text(text))
