from director_string import *

import sys
print("director_string_runme python version {}".format(sys.version_info))

class B(A):

    def __init__(self, string):
        A.__init__(self, string)

    def get_first(self):
        return A.get_first(self) + " world!"

    def process_text(self, string):
        A.process_text(self, string)
        self.smem = "hello"


b = B("hello")

b.get(0)
if b.get_first() != "hello world!":
    print b.get_first()
    raise RuntimeError


b.call_process_func()

if b.smem != "hello":
    print smem
    raise RuntimeError
