import unittest

# Write a functon that recieves 2 integer paramaets and return the sum

def add(x: int, y: int):
    return x + y
# Basic unit test


# We can inherit TestCase because we did the "unittest." as it is how we call the library and TestCase is the Class
"""
class TestMathOperations(unittest.TestCase):
    def test_add(self):
        self.assertEqual(add(2,3),5)
        self.assertEqual(add(-1,1),0)
        self.assertEqual(add(0,0),0)
        
if __name__ == "__main__":
    unittest.main()
        
"""

def is_odd(x: int):
    if x % 2 == 1:
        return True
    else:
        return False

    
class TestIsOdd(unittest.TestCase):
    def test_is_odd(self):
        self.assertEqual(is_odd(3), True)
        self.assertEqual(is_odd(100), False)
        self.assertEqual(is_odd(0), False)
        self.assertEqual(is_odd(1), True)
        self.assertEqual(is_odd(5), True)
        self.assertEqual(is_odd(-2), False)
if __name__ == "__main__":
    unittest.main()
        