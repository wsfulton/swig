/* -----------------------------------------------------------------------------
 * exceptions.swg
 *
 * Defines SWIG_exception(code, msg) and the SWIG_exception fragment with any support code that it needs.
 * SWIG_exception raises the target language error for a SWIG error code and leaves the wrapper function.
 * Included by swigcommon.swg.
 * ----------------------------------------------------------------------------- */

%include <typemaps/exception.swg>

/* SWIG_Error leaves the wrapper, by throwing a C++ exception with NAPI_CPP_EXCEPTIONS, so SWIG_exception does not
   jump to the fail label and can then be used outside a wrapper function. SWIG_exception_fail does jump to it. */
%insert("runtime") %{
#define SWIG_exception_fail(code, msg) do { SWIG_Error(code, msg); SWIG_fail; } while (0)
#undef SWIG_exception
#define SWIG_exception(code, msg) SWIG_Error(code, msg)
%}
