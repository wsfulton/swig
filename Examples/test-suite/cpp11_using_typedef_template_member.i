%module cpp11_using_typedef_template_member

// Regression test for https://github.com/swig/swig/issues/1042
//
// A using-declaration brings an inherited data member of a template base class into a derived template
// class.  The member's type is itself written in terms of a template parameter of the base
// (Owners<links_type>).  When the using-declaration names the base through a typedef or a C++11 alias of
// the template instantiation (NodeIT) rather than through the base class name directly, the template
// parameter in the wrapped member's type must still be expanded.  Otherwise the qualifier was reduced to
// the bare template name and the generated wrapper referred to the unexpanded 'links_type', failing to
// compile.

%inline %{
template <typename T> struct Owners {
  T value;
};

template <typename LinksT>
class NodeI {
public:
  using links_type = LinksT;
  Owners<links_type> owners;
};

// The using-declaration qualifier is a C++11 alias declaration of the template instantiation base.
template <typename LinksT>
class ClusterAlias : public NodeI<LinksT> {
public:
  using NodeIT = NodeI<LinksT>;
  using NodeIT::owners;
};

// The using-declaration qualifier is a plain typedef of the template instantiation base.
template <typename LinksT>
class ClusterTypedef : public NodeI<LinksT> {
public:
  typedef NodeI<LinksT> NodeIT;
  using NodeIT::owners;
};

// Control: the qualifier names the base class directly (this form already worked).
template <typename LinksT>
class ClusterDirect : public NodeI<LinksT> {
public:
  using NodeI<LinksT>::owners;
};
%}

%template(OwnersInt) Owners<int>;
%template(NodeIInt) NodeI<int>;
%template(ClusterAliasInt) ClusterAlias<int>;
%template(ClusterTypedefInt) ClusterTypedef<int>;
%template(ClusterDirectInt) ClusterDirect<int>;
