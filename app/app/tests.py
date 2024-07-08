"""
Sample Test
"""
from django.test import SimpleTestCase

from . import calculator

class CalcTest(SimpleTestCase):

    def test_add_numbers(self):
        res = calculator.add(5,6)
        self.assertEqual(res,11)

    def test_subtract_numbers(self):
        res = calculator.subtract(6,5)
        self.assertEqual(res,1)

    def test_multiply_numbers(self):
        res = calculator.multiply(5,6)
        self.assertEqual(res,30)

    def test_divide_numbers(self):
        res = calculator.divide(30,5)
        self.assertEqual(res,6)

    def test_square_number(self):
        res = calculator.square(2,3)
        self.assertEqual(res,8)