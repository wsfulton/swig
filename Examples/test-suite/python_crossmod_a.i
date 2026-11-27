%module python_crossmod_a

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
%apply SWIGTYPE *DISOWN { B *disowned };
%inline %{
B *make_b() { return new B(); }
void delete_b(B *disowned) { delete disowned; }
%}
