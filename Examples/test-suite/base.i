%module(directors="1") base
%feature("director");

%warnfilter(SWIGWARN_TYPEMAP_THREAD_UNSAFE,SWIGWARN_TYPEMAP_DIRECTOROUT_PTR) Base;

%inline %{
#include <iostream>
class Base {
public:
  Base() { std::cout << "Base::Base()" << std::endl; }
  virtual ~Base() { std::cout << "Base::~Base()" << std::endl; }
  virtual Base* get_pointer() const { 
    std::cout << "Base::get_pointer()" << std::endl;
    return nullptr;
  }
};

void do_something(Base *b) {
  std::cout << "do_something() (start)" << std::endl;
  Base *x = b->get_pointer();
  std::cout << "do_something() (fini)" << std::endl;
}
%}
