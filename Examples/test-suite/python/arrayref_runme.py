import arrayref
from swig_test_utils import swig_check

# A global variable that is a reference to an array reads as the array it refers to.
swig_check(arrayref.cvar.numbers_ref, arrayref.cvar.numbers)

# Setting one copies the elements into the array it refers to.
swig_check(arrayref.numbers_sum(), 10)
arrayref.cvar.numbers_ref = arrayref.cvar.others
swig_check(arrayref.numbers_sum(), 100)

# A reference to an array of char is a string, as the array it refers to is.
swig_check(arrayref.cvar.letters, "abc")
swig_check(arrayref.cvar.letters_ref, "abc")
arrayref.cvar.letters_ref = "xy"
swig_check(arrayref.letters_are(), "xy")

# A reference to an array of const is read only.
swig_check(arrayref.cvar.fixed_ref, "xyz")

member = arrayref.ArrayRefMember()
swig_check(member.sum(), 10)
member.member_ref = arrayref.others_address()
swig_check(member.sum(), 100)

# The same for a member that is a reference to an array of char.
swig_check(member.text_ref, "hi")
member.text_ref = "bye"
swig_check(member.text_is(), "bye")
