from functools import reduce
from numpy import arange
from math import pi

# XXX: https://mathieularose.com/function-composition-in-python/
def compose(*functions):
    return reduce(lambda f, g: lambda x: f(g(x)), functions, lambda x: x)

l=1
r=4
s=0.001

# XXX: https://pynative.com/python-range-for-float-numbers/
A=list(arange(l, r+0.0001,s ))
#A=list(arange(l+s/2, r,s ))
#print("Array {}".format(A))
p=lambda x: 1*x**6+2*x**7+3*x**8+4*x**9+5*x**10
#e=list(map(p,A))
e=list(map(compose(lambda x:x**2,p),A))
#print(e)
#print(sum(e)*s)
print(sum(e)*s*pi)
