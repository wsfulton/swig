using System;
using arrayrefNamespace;

public class arrayref_runme {

  public static void Main() {
    // Setting a variable that is a reference to an array copies into the array it refers to.
    check(10, arrayref.numbers_sum());
    arrayref.numbers_ref = arrayref.others_address();
    check(100, arrayref.numbers_sum());

    // An array of char is a string here, and so is a reference to one.
    check("abc", arrayref.letters);
    check("abc", arrayref.letters_ref);
    arrayref.letters_ref = "xy";
    check("xy", arrayref.letters_are());
    check("xyz", arrayref.frozen_ref);

    ArrayRefMember member = new ArrayRefMember();
    check(10, member.sum());
    check("hi", member.text_ref);
    member.text_ref = "bye";
    check("bye", member.text_is());
  }

  private static void check(int expected, int actual) {
    if (expected != actual)
      throw new Exception("expected " + expected + " but got " + actual);
  }

  private static void check(string expected, string actual) {
    if (expected != actual)
      throw new Exception("expected " + expected + " but got " + actual);
  }
}
