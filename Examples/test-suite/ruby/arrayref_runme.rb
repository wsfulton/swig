#!/usr/bin/env ruby

require 'swig_assert'
require 'arrayref'

# Setting a variable that is a reference to an array copies into the array it refers to.
swig_assert_equal('Arrayref.numbers_sum', '10', binding)
Arrayref.numbers_ref = Arrayref.others
swig_assert_equal('Arrayref.numbers_sum', '100', binding)

# An array of char is a string here, and so is a reference to one.
swig_assert_equal('Arrayref.letters', "'abc'", binding)
swig_assert_equal('Arrayref.letters_ref', "'abc'", binding)
Arrayref.letters_ref = "xy"
swig_assert_equal('Arrayref.letters_are', "'xy'", binding)
swig_assert_equal('Arrayref.frozen_ref', "'xyz'", binding)

member = Arrayref::ArrayRefMember.new
swig_assert_equal('member.sum', '10', binding)
swig_assert_equal('member.text_ref', "'hi'", binding)
member.text_ref = "bye"
swig_assert_equal('member.text_is', "'bye'", binding)
