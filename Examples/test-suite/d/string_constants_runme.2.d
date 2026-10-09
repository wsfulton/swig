module string_constants_runme;

import std.exception;
import string_constants.string_constants;
import string_constants.things;

void main() {
  enforce(EN1 == "a\0bc", "EN1 failed");
  enforce(EN2 == "a\0bc", "EN2 failed");
  enforce(things.EN5 == "a\0bc", "EN5 failed");
}
