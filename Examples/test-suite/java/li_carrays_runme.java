import li_carrays.*;

public class li_carrays_runme {

  static {
    try {
        System.loadLibrary("li_carrays");
    } catch (UnsatisfiedLinkError e) {
      System.err.println("Native code library failed to load. See the chapter on Dynamic Linking Problems in the SWIG Java documentation for help.\n" + e);
      System.exit(1);
    }
  }

  public static void main(String argv[]) throws Throwable
  {
    // array_class
    {
System.out.println("main (10)");
      int length = 5;
      XYArray xyArray = new XYArray(length);
System.out.println("main (20)");
      for (int i=0; i<length; i++) {
System.out.println("main (30)");
        XY xy = xyArray.getitem(i);
System.out.println("main loop 1 (10)");
        xy.setX(i*10);
System.out.println("main loop 1 (20)");
        xy.setY(i*100);
System.out.println("main loop 1 (30)");
        xyArray.setitem(i, xy);
System.out.println("main loop 1 (40)");
      }
      for (int i=0; i<length; i++) {
System.out.println("main loop 2 (10)");
        Assert(xyArray.getitem(i).getX(), i*10);
System.out.println("main loop 2 (20)");
        Assert(xyArray.getitem(i).getY(), i*100);
System.out.println("main loop 2 (30)");
      }
System.out.println("main (40)");
    }
System.out.println("main (50)");

    {
      // global array variable
      int length = 5;
System.out.println("main (100)");
      XY xyArrayPointer = li_carrays.getGlobalXYArray();
System.out.println("main (110)");
      XYArray xyArray = XYArray.frompointer(xyArrayPointer);
System.out.println("main (120)");
      for (int i=0; i<length; i++) {
System.out.println("main loop 3 (10)");
        XY xy = xyArray.getitem(i);
System.out.println("main loop 3 (20)");
        xy.setX(i*10);
System.out.println("main loop 3 (30)");
        xy.setY(i*100);
System.out.println("main loop 3 (40)");
        xyArray.setitem(i, xy);
System.out.println("main loop 3 (50)");
      }
      for (int i=0; i<length; i++) {
System.out.println("main loop 4 (10)");
        Assert(xyArray.getitem(i).getX(), i*10);
System.out.println("main loop 4 (20)");
        Assert(xyArray.getitem(i).getY(), i*100);
System.out.println("main loop 4 (30)");
      }
System.out.println("main (130)");
    }
System.out.println("main (140)");

    // array_functions
    {
      int length = 5;
System.out.println("main (200)");
      AB abArray = li_carrays.new_ABArray(length);
System.out.println("main (210)");
      for (int i=0; i<length; i++) {
System.out.println("main loop 5 (10)");
        AB ab = li_carrays.ABArray_getitem(abArray, i);
System.out.println("main loop 5 (20)");
        ab.setA(i*10);
System.out.println("main loop 5 (30)");
        ab.setB(i*100);
System.out.println("main loop 5 (40)");
        li_carrays.ABArray_setitem(abArray, i, ab);
System.out.println("main loop 5 (50)");
      }
      for (int i=0; i<length; i++) {
System.out.println("main loop 6 (10)");
        Assert(li_carrays.ABArray_getitem(abArray, i).getA(), i*10);
System.out.println("main loop 6 (20)");
        Assert(li_carrays.ABArray_getitem(abArray, i).getB(), i*100);
System.out.println("main loop 6 (30)");
      }
System.out.println("main (220)");
      li_carrays.delete_ABArray(abArray);
System.out.println("main (230)");
    }

    {
      // global array variable
      int length = 3;
System.out.println("main (300)");
      AB abArray = li_carrays.getGlobalABArray();
System.out.println("main (310)");
      for (int i=0; i<length; i++) {
System.out.println("main loop 7 (10)");
        AB ab = li_carrays.ABArray_getitem(abArray, i);
System.out.println("main loop 7 (20)");
        ab.setA(i*10);
System.out.println("main loop 7 (30)");
        ab.setB(i*100);
System.out.println("main loop 7 (40)");
        li_carrays.ABArray_setitem(abArray, i, ab);
System.out.println("main loop 7 (40)");
      }
      for (int i=0; i<length; i++) {
System.out.println("main loop 8 (10)");
        Assert(li_carrays.ABArray_getitem(abArray, i).getA(), i*10);
System.out.println("main loop 8 (20)");
        Assert(li_carrays.ABArray_getitem(abArray, i).getB(), i*100);
System.out.println("main loop 8 (30)");
      }
System.out.println("main (320)");
    }
System.out.println("main (330)");
  }

  private static void Assert(int val1, int val2) {
      System.out.println("val1=" + val1 + " val2=" + val2);
    if (val1 != val2)
      throw new RuntimeException("Mismatch. val1=" + val1 + " val2=" + val2);
  }
}
