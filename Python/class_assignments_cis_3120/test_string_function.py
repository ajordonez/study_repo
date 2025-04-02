import unittest
from io import StringIO
import sys


# Write a python function called 'greet' that will receive one parameter called 'name'. The function will print Hello - Name

# greet function 
# receives one parameter
# print 'Hello {name}'
def greet(name):
	print(f'Hello {name}')
	print('Welcome to our platform.')

class TestGreet(unittest.TestCase):
	def test_prints_hello(self):
		# Arrange: redirecting the stdoutput object to capture the output
		captured_output = StringIO()
		sys.stdout = captured_output

		# call the function
		greet('Alice')
		
		# restore the original stdout
		sys.stdout = sys.__stdout__
		
		# check if the function prints the correct response

		expected_output = (
			'Hello Alice\n'
			'Welcome to our platform.')

		output = captured_output.getvalue().strip()

		self.assertEqual(output, expected_output)


# run the test when the script is excuted directly
if __name__  == '__main__':
	unittest.main()


