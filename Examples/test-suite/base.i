%module(directors="1") base
%feature("director");

%warnfilter(SWIGWARN_TYPEMAP_THREAD_UNSAFE,SWIGWARN_TYPEMAP_DIRECTOROUT_PTR) Base;

%inline %{
class Base {
public:
  Base() {}
  virtual ~Base() {}
  virtual Base* get_pointer() const { return nullptr; }
};

void do_something(Base *b) {
  Base *x = b->get_pointer();
}
%}
