#!/usr/bin/env perl -w

package TestObject;
use Moose;
use v5.10;

has 'x' => (isa => 'Int', is => 'rw', required => 1);
has 'y_hash' => (isa => 'Maybe[HashRef]', is => 'rw', required => 1);

sub clear {
	my $self = shift;
	$self->x(0);	
}

package TestObject2;
use Moose;
use v5.10;

has 'database_handle' => (isa => 'Int', is => 'rw');

# this gives me a way 
around BUILDARGS => sub {
	my ($orig, $class, $connectionString) = @_;
	
	# pretend I'm doing constuction of a database handle
	my $dbh = length($connectionString);
	
	# calls into my base class's BUILDARGS, but note how I've
	# reintepreted it
	return $class->$orig(database_handle => $dbh);
};

package main;

sub normalMemberInitAndMaybe() {
	# now that is pretty neat - you can require that a variable is initialized on construction
	my $testObj = TestObject->new({ x => 500, y_hash => { val => 'hello!' } });
	say $testObj->x();
	say $testObj->y_hash()->{val};

	my $testObjectWithUndef = TestObject->new({ x => 101, y_hash => undef });
	say $testObjectWithUndef->x();

	say "y_hash is undef!" if (!defined($testObjectWithUndef->y_hash()));
}

sub customizedConstructor {
	my $testObj = TestObject2->new("hello world2");
	
	say "database handle => " . $testObj->database_handle();
}

# normalMemberInitAndMaybe();
customizedConstructor();
