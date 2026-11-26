%module python_crossmod_b

// Freeing the owning wrapper of get_owned_int_ptr() finds no destructor
%begin %{
#define SWIG_PYTHON_SILENT_MEMLEAK
%}

%{
#include "python_crossmod.h"
%}

%import(module="python_crossmod_a") "python_crossmod_a.i"

class B {
public:
    B();
    int methB();
};

class C : public A, public B {
public:
    C();
    int methC();
};

%inline %{
int *get_int_ptr() { static int i = 4; return &i; }
%}

%newobject get_owned_int_ptr;
%inline %{
int *get_owned_int_ptr() { static int i = 5; return &i; }

int d_destroyed = 0;

struct D {
  ~D() { ++d_destroyed; }
};
%}
