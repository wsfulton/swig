typemap_string_alloc

Custom_Reset();
cvar.text = "one";
cvar.text = "two";

assert(Custom_WasAllocated());
assert(Custom_WasDeallocated());
