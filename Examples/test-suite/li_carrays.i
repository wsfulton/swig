%module li_carrays

/*
%begin %{
#include <stdio.h>
struct Printer {
  Printer() { printf("Printer\n"); }
  ~Printer() { printf("~Printer\n"); }
};
static Printer printerStart;
%}
*/
%warnfilter(SWIGWARN_RUBY_WRONG_NAME) doubleArray; /* Ruby, wrong class name */

%define TRACERMACRO(FUNC)
%exception FUNC %{
  printf("Starting  $fulldecl\n"); fflush(stdout);
  $action
  printf("Finishing $fulldecl\n"); fflush(stdout);
%}
%enddef

TRACERMACRO(AB::~AB)
TRACERMACRO(XY::~XY)
TRACERMACRO(XYArray::~XYArray)
%include <carrays.i>

%array_functions(int,intArray);
%array_class(double, doubleArray);

%inline %{
typedef struct {
  int x;
  int y;
} XY;
XY globalXYArray[3];

typedef struct {
  int a;
  int b;
} AB;

AB globalABArray[3];
%}

// Note that struct XY { ... }; gives compiler error for C when using %array_class or %array_functions, but is okay in C++
%array_class(XY, XYArray)
%array_functions(AB, ABArray)

/*
%{
static Printer printerEnd;
%}
*/
