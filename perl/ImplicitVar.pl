use strict;
use warnings;
use v5.10;
use Test::More;

my $initialValue = "this is initially a value";;

$_ = $initialValue;
my @values = grep { $_ =~ /hello/ } ("hello", "hello world", "adios");
is_deeply(['hello', 'hello world'], \@values, "grep did work");
is($_, "this is initially a value", $initialValue);

@values = map { "hello" } ("one", "two", "three");
is_deeply(['hello', 'hello', 'hello'], \@values);
is($_, "this is initially a value", $initialValue);

# interestingly enough these declarations are preventing
# $a and $b from being used below in the block. I guess
# there's no real syntactic sugar in there at all.
#my $a = "original value - a";
#my $b = "original value - b";

my @sorted = sort { $a cmp $b } ("a", "b", "c");
is_deeply(['a', 'b', 'c'], \@sorted);

done_testing();
