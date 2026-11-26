%module python_crossmod_a

// With -builtin this module frees the owning wrapper of python_crossmod_b's get_owned_int_ptr(), which finds no destructor
%begin %{
#define SWIG_PYTHON_SILENT_MEMLEAK
%}

%{
#include "python_crossmod.h"
%}

class A {
public:
    A();
    int methA();
};

// B is wrapped by python_crossmod_b, so the destructor of the object returned is in that module
class B;
%newobject make_b;
%inline %{
B *make_b() { return new B(); }
%}
