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
  }

  static void check(int expected, int actual) {
    if (expected != actual)
      throw new RuntimeException("expected " + expected + " but got " + actual);
  }
}
