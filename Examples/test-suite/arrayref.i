// A function that passes arrays by reference

%module arrayref

%inline %{

void foo(const int (&x)[10]) {
}

void bar(int (&x)[10]) {
}

int numbers[4] = {1, 2, 3, 4};
int others[4] = {10, 20, 30, 40};

// A variable that is a reference to an array is set by copying the elements of the array it refers
// to, as the array itself is, rather than by an array assignment, which does not compile.
int (&numbers_ref)[4] = numbers;

// An array of char is wrapped as a string rather than as its elements, and so is a reference to one.
char letters[4] = "abc";
char (&letters_ref)[4] = letters;

// A reference to an array of const cannot be written through, so the variable is read only, in the
// same way the array it refers to is.
const char fixed[4] = "xyz";
const char (&fixed_ref)[4] = fixed;

int (*others_address())[4] { return &others; }

int numbers_sum() {
  return numbers[0] + numbers[1] + numbers[2] + numbers[3];
}

const char *letters_are() { return letters; }

struct ArrayRefMember {
  int backing[4];
  int (&member_ref)[4];
  char text[8] = "hi";
  char (&text_ref)[8];
  ArrayRefMember() : member_ref(backing), text_ref(text) {
    for (int i = 0; i < 4; i++)
      backing[i] = i + 1;
  }
  int sum() const {
    return backing[0] + backing[1] + backing[2] + backing[3];
  }
  const char *text_is() const { return text; }
};
%}
