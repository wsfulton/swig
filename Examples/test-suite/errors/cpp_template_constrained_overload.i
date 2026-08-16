%module xxx

%inline %{
#include <concepts>

// C++20 abbreviated function templates told apart only by their type-constraint.
int classify(std::integral auto value) { return 1; }
double classify(std::floating_point auto value) { return 2; }

// The same overloads written with an explicit template parameter list and a requires-clause.
template<typename T> requires std::integral<T> int rank(T value) { return 1; }
template<typename T> requires std::floating_point<T> double rank(T value) { return 2; }

// Member function templates carrying the same member qualifiers, so only the type-constraint
// tells them apart.
struct Holder {
  int get(std::integral auto x) const & { return 1; }
  double get(std::floating_point auto x) const & { return 2; }
};
%}

%template(classify_int) classify<int>;
%template(classify_double) classify<double>;
%template(rank_double) rank<double>;
%template(get_int) Holder::get<int>;
