if {[catch {load ./typemap_string_alloc[info sharedlibextension] Typemap_string_alloc} err]} {
  puts stderr "Could not load shared object:\n$err"
  exit 1
}

Custom_Reset
set text "one"
set text "two"

if {![Custom_WasAllocated]} { error "custom allocator was not called" }
if {![Custom_WasDeallocated]} { error "custom deallocator was not called" }
