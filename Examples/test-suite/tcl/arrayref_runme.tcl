if [ catch { load ./arrayref[info sharedlibextension] Arrayref} err ] {
    puts stderr "Could not load shared object:\n$err"
    exit 1
}

# Setting a variable that is a reference to an array copies into the array it refers to.
if {[numbers_sum] != 10} { error "numbers_sum" }
set numbers_ref $others
if {[numbers_sum] != 100} { error "numbers_sum after set" }

# An array of char is a string here, and so is a reference to one.
if {$letters != "abc"} { error "letters" }
if {$letters_ref != "abc"} { error "letters_ref" }
set letters_ref "xy"
if {[letters_are] != "xy"} { error "letters_are" }
if {$frozen_ref != "xyz"} { error "frozen_ref" }

ArrayRefMember member
if {[member sum] != 10} { error "member sum" }
if {[member cget -text_ref] != "hi"} { error "member text_ref" }
member configure -text_ref "bye"
if {[member text_is] != "bye"} { error "member text_is" }
