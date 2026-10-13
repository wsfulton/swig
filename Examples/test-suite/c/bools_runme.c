#include <assert.h>
#include "bools/bools_wrap.h"

int main(int argc, const char *argv[])
{
    /* A const bool reference is passed and returned by value */
    assert(bools_const_rbo(true));
    assert(!bools_const_rbo(false));
    assert(!bools_const_rbool_get());

    bools_BoolStructure *s = bools_BoolStructure_new();
    assert(!bools_BoolStructure_m_const_rbool_get(s));
    bools_BoolStructure_delete(s);

    return 0;
}
