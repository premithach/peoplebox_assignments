# Function that multiplies a and b, then adds b to the result
def multiplyAndAdd(a, b):
    product = a * b  # Multiply a and b
    result = product + b  # Add b to the product
    return result

# Function that calculates the sum of a and b, and the result of multiplyAndAdd
def calculateSumAndProduct(a, b):
    sumOfAandB = a + b  # Calculate the sum of a and b
    multiplicationResult = multiplyAndAdd(a, b)  # Get the result of multiplyAndAdd
    return sumOfAandB, multiplicationResult  # Return both the sum and multiplication result
