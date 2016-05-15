#!/usr/bin/env perl -w
use strict;
use warnings;
use v5.10;

$SIG{HUP} = \&hupHandler;

# to invoke this from a remote process - use 
# kill -SIGHUP <pid>
sub hupHandler {
	print "HUP'd!\n";
}

print "$$\n";

while (1) {
	sleep(1);
	print "sleeping\n";
}
