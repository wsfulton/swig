import sys
from swig_test_utils import swig_check
import python_crossmod_a
import python_crossmod_b

c = python_crossmod_b.C()
if c.methA() != 1:
    raise RuntimeError("methA got {}".format(c.methA()))
if c.methB() != 2:
    raise RuntimeError("methB got {}".format(c.methB()))
if c.methC() != 3:
    raise RuntimeError("methC got {}".format(c.methC()))

# Freeing a plain pointer wrapper made by the second module must leave the runtime data capsule refcount unchanged
runtime = [m for n, m in sys.modules.items() if n.startswith("swig_runtime_data")][0]
capsule_name = [a for a in dir(runtime) if a.startswith("type_pointer_capsule")][0]
capsule = getattr(runtime, capsule_name)
before = sys.getrefcount(capsule)
p = python_crossmod_b.get_int_ptr()
del p
swig_check(sys.getrefcount(capsule), before)

# The same for an owning wrapper made by the first module whose destructor is in the second module
before = sys.getrefcount(capsule)
b = python_crossmod_a.make_b()
swig_check(type(b).__name__, "B")
del b
swig_check(sys.getrefcount(capsule), before)

# An owning wrapper made by the second module holds a reference on the capsule, as one made by the first module does
before = sys.getrefcount(capsule)
a = python_crossmod_a.A()
a_refs = sys.getrefcount(capsule) - before
d = python_crossmod_b.D()
swig_check(sys.getrefcount(capsule) - before, 2 * a_refs)
del a, d
swig_check(sys.getrefcount(capsule), before)

# Freeing an owning plain pointer wrapper made by the second module must leave the capsule refcount unchanged too
before = sys.getrefcount(capsule)
p = python_crossmod_b.get_owned_int_ptr()
del p
swig_check(sys.getrefcount(capsule), before)

# Disowning a wrapper made by the other module, or with -builtin a plain pointer wrapper, releases its reference on the capsule
before = sys.getrefcount(capsule)
python_crossmod_a.delete_b(python_crossmod_b.B())
p = python_crossmod_b.get_owned_int_ptr()
swig_check(python_crossmod_b.disown_int_ptr(p), 5)
del p
swig_check(sys.getrefcount(capsule), before)

# Destroying the capsule frees the runtime data of the second module too, once its owning wrappers are freed
del c
d = python_crossmod_b.D()
destroyed = python_crossmod_b.cvar.d_destroyed
cvar_refs = sys.getrefcount(python_crossmod_b.cvar)
delattr(runtime, capsule_name)
del capsule
del d
swig_check(python_crossmod_b.cvar.d_destroyed, destroyed + 1)
swig_check(sys.getrefcount(python_crossmod_b.cvar), cvar_refs - 1)
