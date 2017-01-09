#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

#use MyHealth::Schema;

use userlogin;

#my $schema = MyHealth::Schema->connect('dbi:mysql:database=MyHealth_DB', 'root', 'admin');

#my $result = $schema->resultset('Login');

#print Dumper($schema);

my ($db) = userlogin->new();

my $new_user = $db->create_new_user('Ashu', 'Password');

print "New User : ", $new_user, "\n";
