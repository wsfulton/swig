%module xxx

%inline %{
#include <concepts>

// Overloads whose parameters are written differently but whose C++ function signatures are the
// same, top level cv-qualification not being part of a signature.  A call is ambiguous in C++.
int classify(const std::floating_point auto value) { return 1; }
double classify(std::floating_point auto value) { return 2; }
%}

%template(classify_double) classify<double>;
