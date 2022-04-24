/* -----------------------------------------------------------------------------
 * std_wstring.i
 *
 * Typemaps for std::wstring and const std::wstring&
 * These are mapped to a C# String and are passed around by value.
 *
 * To use non-const std::wstring references use the following %apply.  Note 
 * that they are passed by value.
 * %apply const std::wstring & {std::wstring &};
 * ----------------------------------------------------------------------------- */

%include <wchar.i>

%{
#include <string>

std::wstring UTF16ToWString(const wchar_t *str) {
  if (str == nullptr)
    return std::wstring();

  const unsigned short * pBegin((const unsigned short *)(str));
  const unsigned short * ptr(pBegin);

  while (*ptr != 0)
    ++ptr;

  std::wstring result;

  result.reserve(ptr - pBegin);

  while(pBegin != ptr)
    result.push_back(*pBegin++);

  return result;
}

%}

namespace std {

%naturalvar wstring;

class wstring;

// wstring
%typemap(ctype, out="void *") wstring "wchar_t *"
%typemap(imtype,
         inattributes="[global::System.Runtime.InteropServices.MarshalAs(global::System.Runtime.InteropServices.UnmanagedType.LPWStr)]",
         outattributes="[return: global::System.Runtime.InteropServices.MarshalAs(global::System.Runtime.InteropServices.UnmanagedType.LPWStr)]"
         ) wstring "string"
%typemap(cstype) wstring "string"
%typemap(csdirectorin) wstring "$iminput"
%typemap(csdirectorout) wstring "$cscall"

%typemap(in, canthrow=1) wstring
%{ if (!$input) {
    SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentNullException, "null wstring", 0);
    return $null;
   }
   $1 = UTF16ToWString($input); %}
//%typemap(out) wstring %{ $result = SWIG_csharp_wstring_with_length_callback($1.c_str(), $1.size()); %}
%typemap(out) wstring %{
{
  unsigned char *p = (unsigned char *)$1.data();
  size_t len = $1.size()*sizeof(wchar_t);
  std::wcout << L"to : " << /*s <<*/ L"[";
  for (size_t i = 0; i<len; i++) {
    std::wcout << std::hex << *p << L" ";
    p++;
  }
  std::wcout << L"]" << std::endl;
  std::wcout << std::flush;
}
// $result = SWIG_csharp_wstring_with_length_callback($1.c_str(), $1.size());
$result = SWIG_csharp_wstring_with_length_callback($1.c_str(), $1.size());
{
  unsigned char *p = (unsigned char *)$result;
  size_t len = $1.size()*sizeof(wchar_t);
  std::wcout << L"out: " << /*s <<*/ L"[";
  for (size_t i = 0; i<len; i++) {
    std::wcout << std::hex << *p << L" ";
    p++;
  }
  std::wcout << L"]" << std::endl;
  std::wcout << std::flush;
}
// note: SWIG_csharp_wstring_with_length_callback (in & out is the same) so doesn't do anything on windows with the delegate having MarshalAs(LPWStr) (not sure about leaks)
%}

%typemap(directorout, canthrow=1) wstring
%{ if (!$input) {
    SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentNullException, "null wstring", 0);
    return $null;
   }
   $result.assign($input); %}

%typemap(directorin) wstring %{ $input = SWIG_csharp_wstring_with_length_callback($1.c_str(), $1.size()); %}

%typemap(csin) wstring "$csinput"
%typemap(csout, excode=SWIGEXCODE) wstring {
    string ret = $imcall;$excode
    return ret;
  }

%typemap(typecheck) wstring = wchar_t *;

%typemap(throws, canthrow=1) wstring
%{ std::string message($1.begin(), $1.end());
   SWIG_CSharpSetPendingException(SWIG_CSharpApplicationException, message.c_str());
   return $null; %}

// const wstring &
%typemap(ctype, out="void *") const wstring & "wchar_t *"
%typemap(imtype,
         inattributes="[global::System.Runtime.InteropServices.MarshalAs(global::System.Runtime.InteropServices.UnmanagedType.LPWStr)]",
         outattributes="[return: global::System.Runtime.InteropServices.MarshalAs(global::System.Runtime.InteropServices.UnmanagedType.LPWStr)]"
         ) const wstring & "string"
%typemap(cstype) const wstring & "string"

%typemap(csdirectorin) const wstring & "$iminput"
%typemap(csdirectorout) const wstring & "$cscall"

%typemap(in, canthrow=1) const wstring &
%{ if (!$input) {
    SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentNullException, "null wstring", 0);
    return $null;
   }
   std::wstring $1_str(UTF16ToWString($input));
   $1 = &$1_str; %}
%typemap(out) const wstring & %{ $result = SWIG_csharp_wstring_with_length_callback($1->c_str(), $1->size()); %}

%typemap(csin) const wstring & "$csinput"
%typemap(csout, excode=SWIGEXCODE) const wstring & {
    string ret = $imcall;$excode
    return ret;
  }

%typemap(directorout, canthrow=1, warning=SWIGWARN_TYPEMAP_THREAD_UNSAFE_MSG) const wstring &
%{ if (!$input) {
    SWIG_CSharpSetPendingExceptionArgument(SWIG_CSharpArgumentNullException, "null wstring", 0);
    return $null;
   }
   /* possible thread/reentrant code problem */
   static std::wstring $1_str;
   $1_str = $input;
   $result = &$1_str; %}

%typemap(directorin) const wstring & %{ $input = SWIG_csharp_wstring_with_length_callback($1.c_str(), $1->size()); %}

%typemap(csvarin, excode=SWIGEXCODE2) const wstring & %{
    set {
      $imcall;$excode
    } %}
%typemap(csvarout, excode=SWIGEXCODE2) const wstring & %{
    get {
      string ret = $imcall;$excode
      return ret;
    } %}

%typemap(typecheck) const wstring & = wchar_t *;

%typemap(throws, canthrow=1) const wstring &
%{ std::string message($1.begin(), $1.end());
   SWIG_CSharpSetPendingException(SWIG_CSharpApplicationException, message.c_str());
   return $null; %}

}

