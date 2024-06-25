# 1. Given a 3D array a with shape (2, 3, 4) and a 2D array b with shape (3, 4), perform element-wise multiplication between a and b using broadcasting.
import numpy as np

a = np.array([[[1, 2, 3, 4],
               [5, 6, 7, 8],
               [9, 10, 11, 12]],
              
              [[13, 14, 15, 16],
               [17, 18, 19, 20],
               [21, 22, 23, 24]]])

b = np.array([[1, 2, 3, 4],
              [5, 6, 7, 8],
              [9, 10, 11, 12]])

res = a * b
print(res)

# 2. Implement a function that takes two 2D arrays c and d with different shapes and performs element-wise operations (addition, subtraction, multiplication, and division) between them using broadcasting. Handle the case where broadcasting is not possible.
def elementwise_operations(c, d):
    try:
        addition = c + d
        subtraction = c - d
        multiplication = c * d
        division = c / d
        return addition, subtraction, multiplication, division
    except ValueError:
        return "Broadcasting not possible for the given shapes."

c = np.array([[1, 2, 3, 4],
              [5, 6, 7, 8],
              [9, 10, 11, 12]])
d = np.array([[13, 11, 6, 7],
              [4, 2, 1, 2],
              [1, 1, 2, 3]])
res = elementwise_operations(c, d)
print(res)

# 3. Create a 2D array e with shape (5, 3) and a 1D array f with length 5. Compute the outer product of e and f using broadcasting.
p = np.random.rand([[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9],
              [1, 2, 3],
              [4, 5, 6]])
q = np.random.rand([5, 4, 5, 8, 8])

outer_product = p[:, np.newaxis, :] * q[:, np.newaxis]
outer_product = outer_product.reshape(5, 3, 5)

# 4. Given a 3D array g with shape (4, 3, 2), extract every other element along the first and second dimensions, but keep all elements along the third dimension.
a = np.random.rand([[[1, 2], [3, 4], [5, 6]],
              [[7, 8], [9, 10], [11, 12]],
              [[13, 14], [15, 16], [17, 18]],
              [[19, 20], [21, 22], [23, 24]]])

slicee = a[::2, ::2, :]

# 5. Create a function that takes a 2D array h and an array of row indices i and column indices j. The function should return a new array k where k[m, n] is the sum of the elements in h along the diagonal specified by i[m] and j[n].
def diagonal_sum(h, i, j):
    k = np.array([h[i[m], j[n]] for m in range(len(i)) for n in range(len(j))]).reshape(len(i), len(j))
    return k.sum(axis=1)

a = np.array([[1, 2, 3, 4],
              [5, 6, 7, 8],
              [9, 10, 11, 12],
              [13, 14, 15, 16]])
b = np.array([0, 1, 2])
c = np.array([1, 2, 3])
k = diagonal_sum(h, i, j)
print(k)

# 6. Implement a function that takes a 2D array l and returns a new array m where each element in m is the product of the corresponding row and column means in l.
def row_col_mean_product(l):
    row_means = l.mean(axis=1).reshape(-1, 1)
    col_means = l.mean(axis=0).reshape(1, -1)
    return row_means * col_means

l = np.random.rand(4, 4)
m = row_col_mean_product(l)
print(m)

# 7. Given a 2D array n with shape (4, 6), reshape it into a 3D array with shape (2, 2, 6) and then flatten it back to a 2D array with shape (4, 6).
n = np.random.rand(4, 6)

reshapee = n.reshape(2, 2, 6)
flattened = reshapee.reshape(4, 6)
print(reshapee)
print(flattened)

# 8. Implement a function that takes a 2D array o and rolls it along the first axis by a specified number of positions. For example, if the input array is [[1, 2, 3], [4, 5, 6]] and the number of positions is 1, the output should be [[4, 5, 6], [1, 2, 3]].
def roll_along_first_axis(o, positions):
    return np.roll(o, shift=positions, axis=0)

a = np.array([[1, 2, 3], [4, 5, 6]])
rolle = roll_along_first_axis(a, 1)
print(rolle)

# 9. Create a function that takes a 2D array p and replaces all occurrences of a specified value x with the mean of the neighboring elements (horizontally and vertically) in the array.
def replace_with_neighbor_mean(p, x):
    rows, cols = p.shape
    result = p.copy()
    for r in range(rows):
        for c in range(cols):
            if p[r, c] == x:
                neighbors = []
                if r > 0:
                    neighbors.append(p[r-1, c])
                if r < rows-1:
                    neighbors.append(p[r+1, c])
                if c > 0:
                    neighbors.append(p[r, c-1])
                if c < cols-1:
                    neighbors.append(p[r, c+1])
                if neighbors:
                    result[r, c] = np.mean(neighbors)
    return result

p = np.array([[1, 2, 3], [4, 0, 6], [7, 8, 9]])
x = 0
modified_p = replace_with_neighbor_mean(p, x)
print(modified_p)
