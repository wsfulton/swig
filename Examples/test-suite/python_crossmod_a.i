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

// D is wrapped by python_crossmod_b, so its type is in this module's type table too, as in the reproducer of #2638
%inline %{
struct D;
bool is_d(D *d) { return d != 0; }

#ifdef SWIGPYTHON_BUILTIN
bool is_python_builtin() { return true; }
#else
bool is_python_builtin() { return false; }
#endif
%}
