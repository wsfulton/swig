from swig_test_utils import swig_check
import cpp11_using_typedef_template_member as m


def check_owners(c):
    o = m.OwnersInt()
    o.value = 42
    c.owners = o
    swig_check(c.owners.value, 42)


# Base class declaring the member directly.
check_owners(m.NodeIInt())

# Member inherited via a using-declaration whose qualifier is a C++11 alias of the template base.
check_owners(m.ClusterAliasInt())

# Member inherited via a using-declaration whose qualifier is a plain typedef of the template base.
check_owners(m.ClusterTypedefInt())

# Control: member inherited via a using-declaration naming the template base directly.
check_owners(m.ClusterDirectInt())
