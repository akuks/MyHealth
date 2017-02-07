#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

#use MyHealth::Schema;
use FindBin;
use lib "$FindBin::Bin/../lib";

#Custom Packages
use login::userlogin;
use login::updateProfile;
use login::MyHealth::Schema;
use relationship::relationship;

#my $schema = MyHealth::Schema->connect('dbi:mysql:database=MyHealth_DB', 'root', 'admin');

#my $result = $schema->resultset('Login');

#print Dumper($schema);

my $db = userlogin->new();


my $login_id = $db->{_dbs}->resultset('Login')->find({
    email  => 'kukreti.ashutosh@gmail.com'
  });

print Dumper ($login_id->login_id);
