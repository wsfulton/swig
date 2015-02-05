#!/usr/bin/env python3
c_common = "-Werror -fdiagnostics-show-option -std=gnu89 -Wno-long-long -Wreturn-type -Wdeclaration-after-statement"
cflags = {
        "csharp":c_common,
             "d":c_common,
            "go":c_common,
         "guile":c_common,
          "java":c_common + " -pedantic",
    "javascript":c_common + " -pedantic",
           "lua":c_common + " -pedantic",
        "octave":c_common + " -pedantic",
         "perl5":c_common,
           "php":c_common,
        "python":c_common,
          "ruby":c_common,
        "scilab":c_common,
           "tcl":c_common,
}

cxx_common = "-Werror -fdiagnostics-show-option -std=c++98 -Wno-long-long -Wreturn-type"
cxxflags = {
        "csharp":cxx_common + " -pedantic",
             "d":cxx_common + " -pedantic",
            "go":cxx_common + " -pedantic",
         "guile":cxx_common,
          "java":cxx_common + " -pedantic",
    "javascript":cxx_common + " -pedantic",
           "lua":cxx_common + " -pedantic",
        "octave":cxx_common,
         "perl5":cxx_common,
           "php":cxx_common + " -pedantic",
        "python":cxx_common + " -pedantic",
          "ruby":cxx_common + " -pedantic",
        "scilab":cxx_common + " -pedantic",
           "tcl":cxx_common,
}

import argparse
parser = argparse.ArgumentParser(description="Display CFLAGS or CXXFLAGS to use for testing the SWIG examples and test-suite.")
parser.add_argument('-c', '--cflags', action='store_true', default=False, help='show CFLAGS')
parser.add_argument('-x', '--cxxflags', action='store_true', default=False, help='show CXXFLAGS')
parser.add_argument('-l', '--language', help='Language to show flags for')
args = parser.parse_args()

if args.cflags:
    print("{}".format(cflags[args.language]))
elif args.cxxflags:
    print("{}".format(cxxflags[args.language]))
else:
    parser.print_help()
    exit(1)

