class complexnumber:
    def __init__(self,real,imaginary):
      self.real=real
      self.imaginary=imaginary
    def __add__(self,x):
      b=complex(self.real,self.imaginary)
      c=complex(x.real,x.imaginary)
      #print(b+c)
      a=(b+c).real
      m=(b+c).imag
      return complexnumber(a,m)
    

    def __diff__(self,x):
      b=complex(self.real,self.imaginary)
      c=complex(x.real,x.imaginary)
      a=(b-c).real
      m=(b-c).imag
      return complexnumber(a,m)
    
    def __pr__(self,x):
      b=complex(self.real,self.imaginary)
      c=complex(x.real,x.imaginary)
      a=(b*c).real
      m=(b*c).imag
      return complexnumber(a,m)
    def __div__(self,x):
      b=complex(self.real,self.imaginary)
      c=complex(x.real,x.imaginary)
      a=(b/c).real
      m=(b/c).imag
      return complexnumber(a,m)
    def __str__(self):
      x1=self.real
      x2=self.imaginary
      x=complex(x1,x2)
      return "complex number is "+str(x)
      
      
x=complexnumber(1,2)
y=complexnumber(4,5)
print(x.__add__(y))
print(x.__diff__(y))
print(x.__pr__(y))
print(x.__div__(y))
print(x)
