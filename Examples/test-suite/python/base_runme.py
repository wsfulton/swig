import base

x=base.Base()
base.do_something(x)

class MyBase(base.Base):
    pass
x=MyBase()
base.do_something(x)
print("Finished base_runme.py")
