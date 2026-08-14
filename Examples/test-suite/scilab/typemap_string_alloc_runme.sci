exec("swigtest.start", -1);

Custom_Reset();
text_set("one");
text_set("two");

checkequal(Custom_WasAllocated(), %t, "Custom_WasAllocated()");
checkequal(Custom_WasDeallocated(), %t, "Custom_WasDeallocated()");

exec("swigtest.quit", -1);
