#include "math.h"
#include "ruby.h"
#include <iostream>

int main() {
    std::cout << "isfinite: " << isfinite(1.0) << std::endl;
    std::cout << "isfinite: " << isfinite(10/0.0) << std::endl;
    return 0;
}
