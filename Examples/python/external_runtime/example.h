/* File : example.h */

#include <iostream>
#include "Python.h"

class Mesh {
  int value_;
public:
  Mesh(const int value = 0) : value_(value) {}
  int value() { return value_; }
};

class Function {
  PyObject *pyObj_;
public:
  explicit Function(PyObject *pyCallable = 0);
};
