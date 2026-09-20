# do not dump Octave core
if exist("crash_dumps_octave_core", "builtin")
  crash_dumps_octave_core(0);
endif

arrayref

# Setting a variable that is a reference to an array copies into the array it refers to.
if (arrayref.numbers_sum() != 10); error("numbers_sum"); endif
arrayref.cvar.numbers_ref = arrayref.cvar.others;
if (arrayref.numbers_sum() != 100); error("numbers_sum after set"); endif

# An array of char is a string here, and so is a reference to one.
if (!strcmp(arrayref.cvar.letters, "abc")); error("letters"); endif
if (!strcmp(arrayref.cvar.letters_ref, "abc")); error("letters_ref"); endif
arrayref.cvar.letters_ref = "xy";
if (!strcmp(arrayref.letters_are(), "xy")); error("letters_are"); endif
if (!strcmp(arrayref.cvar.frozen_ref, "xyz")); error("frozen_ref"); endif

member = arrayref.ArrayRefMember();
if (member.sum() != 10); error("member sum"); endif
if (!strcmp(member.text_ref, "hi")); error("member text_ref"); endif
member.text_ref = "bye";
if (!strcmp(member.text_is(), "bye")); error("member text_is"); endif
