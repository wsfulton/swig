%module li_std_wstring
%include <std_basic_string.i>
%include <std_wstring.i>


// throw is invalid in C++17 and later, only SWIG to use it
#define TESTCASE_THROW(TYPES...) throw(TYPES)
%{
#define TESTCASE_THROW(TYPES...)
%}

%inline %{

struct A : std::wstring 
{
  A(const std::wstring& s) : std::wstring(s)
  {
  }
};

struct B 
{
  B(const std::wstring& s) : cname(0), name(s), a(s)
  {
  }
  
  char *cname;
  std::wstring name;
  A a;

};
 

wchar_t test_wcvalue(wchar_t x) {
   return x;
}

const wchar_t* test_ccvalue(const wchar_t* x) {
   return x;
}

wchar_t* test_cvalue(wchar_t* x) {
   return x;
}
  

wchar_t* test_wchar_overload() {
   return 0;
}

wchar_t* test_wchar_overload(wchar_t *x) {
   return x;
}

std::wstring test_value(std::wstring x) {
   return x;
}

const std::wstring& test_const_reference(const std::wstring &x) {
   return x;
}

void test_pointer(std::wstring *x) {
}

std::wstring *test_pointer_out() {
   static std::wstring x = L"x";
   return &x;
}

void test_const_pointer(const std::wstring *x) {
}

const std::wstring *test_const_pointer_out() {
   static std::wstring x = L"x";
   return &x;
}

void test_reference(std::wstring &x) {
}

std::wstring& test_reference_out() {
   static std::wstring x = L"x";
   return x;
}

bool test_equal_abc(const std::wstring &s) {
  return L"abc" == s;
}

void test_throw() TESTCASE_THROW(std::wstring){
  static std::wstring x = L"x";
  
  throw x;
}

#ifdef SWIGPYTHON_BUILTIN
bool is_python_builtin() { return true; }
#else
bool is_python_builtin() { return false; }
#endif

%}


