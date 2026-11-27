%module python_crossmod_b

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
%apply SWIGTYPE *DISOWN { int *disowned };
%inline %{
int *get_owned_int_ptr() { static int i = 5; return &i; }
int disown_int_ptr(int *disowned) { return *disowned; }

int d_destroyed = 0;

struct D {
  ~D() { ++d_destroyed; }
};
%}
