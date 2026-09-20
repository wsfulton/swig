ar=require("arrayref")
catch_undef_globs() -- catch "undefined" global variables

-- Setting a variable that is a reference to an array copies into the array it refers to.
assert(ar.numbers_sum() == 10)
ar.numbers_ref = ar.others_address()
assert(ar.numbers_sum() == 100)

-- An array of char is a string here, and so is a reference to one.
assert(ar.letters == "abc")
assert(ar.letters_ref == "abc")
ar.letters_ref = "xy"
assert(ar.letters_are() == "xy")
assert(ar.frozen_ref == "xyz")

local member = ar.ArrayRefMember()
assert(member:sum() == 10)
assert(member.text_ref == "hi")
member.text_ref = "bye"
assert(member:text_is() == "bye")
