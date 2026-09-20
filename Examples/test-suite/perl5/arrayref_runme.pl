use strict;
use warnings;
use Test::More tests => 9;
BEGIN { use_ok('arrayref') }
require_ok('arrayref');

# Setting a variable that is a reference to an array copies into the array it refers to.
is(arrayref::numbers_sum(), 10, "numbers_sum");
$arrayref::numbers_ref = $arrayref::others;
is(arrayref::numbers_sum(), 100, "numbers_sum after set");

# An array of char is a string here, and so is a reference to one.
is($arrayref::letters, "abc", "letters");
is($arrayref::letters_ref, "abc", "letters_ref");
$arrayref::letters_ref = "xy";
is(arrayref::letters_are(), "xy", "letters_are");
is($arrayref::frozen_ref, "xyz", "frozen_ref");

my $member = arrayref::ArrayRefMember->new();
is($member->sum(), 10, "member sum");
