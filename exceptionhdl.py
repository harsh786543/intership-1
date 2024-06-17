'''Write a function that takes two numbers as input and
 divides the first number by the second number.
 Raise a ZeroDivisionError if the second number is zero.'''

def div1(x,y):
    if y==0:
        raise ZeroDivisionError
    else:
        return x/y
try:
    print(div1(6,3))
    print(div1(10,0))
    print(div1(5,0))
except:
    print("You cannot divide by zero");


'''Create a function that checks if a given string is a palindrome.
 Raise a custom PalindromeError if the input is not a valid string.'''

class PalindromeError(Exception):
    pass


def palin(str1):
    if type(str1)!=str:
        raise PalindromeError
    
    if str1 != str1[::-1]:
        return False
    else:
        return True
    
try:
    print(palin("abcba"))
    print(palin(42))
    print(palin("racecar"))
except PalindromeError as e:
    print("Error Occurred")





'''Write a Python script that iterates through a list of integers and attempts to divide each integer by 
zero. Handle the ZeroDivisionError exception within a try-except block,
 and use a finally block to print a message indicating the end of the iteration process.'''

def zdiv(ls):
    for i in ls:
        try:
            print(i/0)
        except:
            pass
        finally:
            print("Exception handled")

list1 = [1,6,5,3]
zdiv(list1)


'''Write a Python function that attempts to divide two numbers and handles the ZeroDivisionError exception. 
Include a finally block to print a message indicating the end of the division operation.'''

def div1(x,y):
    try:
        z=x/y
        print(z)
    except ZeroDivisionError as e:
        print("Cant divide by zero")
    finally:
        print("--Process finished--")

div1(10,5)
div1(5,0)


'''Create a Python program that converts a string to an integer. Handle the ValueError exception if the 
string cannot be converted to an integer, and print a message indicating the error.'''

def convert(str1):
    try:
        num = int(str1)
        return num
    except ValueError:
        return "Invalid Input"

print(convert("72")," ",convert("Alonso"))




'''Write a Python function that takes a number as input and returns its square root. Handle the case where 
the input is a negative number by raising a custom exception called NegativeNumberError.'''

class NegativeNumberError(Exception):
    pass

def numroot(x):
    if x<0:
        raise NegativeNumberError
    
    for i in range(2,x):
        if x/i==i:
            return i
    return "No square root"

try:
    print(numroot(36))
    print(numroot(20))
    print(numroot(-24))
except NegativeNumberError as e:
    print("Error: Negative Number Detected!")
