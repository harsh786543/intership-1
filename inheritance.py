


class Parent:
    def __init__(self, name, id):
        self.name = name
        self.id = id
        print("p1")
    def ret(self):
        print("parent")
    class Two:
        def ret1():
            print("sample")
class Child (Parent):
    def __init__(self):
        pass
    def ret1(self):
        print("child")

class Parent2 ():
    def __init__(self):
        print("p2")

    def prtr(self):
        print("Hi, it me")

    
class Grandchild(Child):
    def ret1(self):
        super().ret1()
        print("grandchild")

class child2(Parent,Parent2):
    def __init__(self):
        print("child 2")

x = child2()
x.ret()
obj = Grandchild()
obj.Two.ret1()
obj.ret1()

