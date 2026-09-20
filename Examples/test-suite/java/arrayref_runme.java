import arrayref.*;

public class arrayref_runme {
  static {
    try {
        System.loadLibrary("arrayref");
    } catch (UnsatisfiedLinkError e) {
      System.err.println("Native code library failed to load. See the chapter on Dynamic Linking Problems in the SWIG Java documentation for help.\n" + e);
      System.exit(1);
    }
  }

  public static void main(String argv[])
  {
    // Setting a reference to an array copies the elements into the array it refers to.
    check(10, arrayref.numbers_sum());
    arrayref.setNumbers_ref(arrayref.others_address());
    check(100, arrayref.numbers_sum());

    ArrayRefMember member = new ArrayRefMember();
    check(10, member.sum());
    member.setMember_ref(arrayref.others_address());
    check(100, member.sum());

    // An array of char is a string here, and so is a reference to one.
    check("abc", arrayref.getLetters());
    check("abc", arrayref.getLetters_ref());
    arrayref.setLetters_ref("xy");
    check("xy", arrayref.letters_are());
    check("xyz", arrayref.getFrozen_ref());

    check("hi", member.getText_ref());
    member.setText_ref("bye");
    check("bye", member.text_is());
  }

  static void check(int expected, int actual) {
    if (expected != actual)
      throw new RuntimeException("expected " + expected + " but got " + actual);
  }

  static void check(String expected, String actual) {
    if (!expected.equals(actual))
      throw new RuntimeException("expected " + expected + " but got " + actual);
  }
}
