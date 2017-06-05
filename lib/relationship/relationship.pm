package relationship;

use strict;
use warnings;

use Data::Dumper;

use lib "lib/login";

use login::MyHealth::Schema;

=head1 Name
Package Name: relationship

=head1 Description
Return the relationship hash to the REST API.

This package is static package and doesn't require any session to get
relationship and their ID details.

This package is only used by the frontend to get the relationship ID when user
updates the family Profile.

For Ex- if User updates relationship as son or daughter then in the family
table only relationship ID will be updated which will get from the relationship
table using this package called by the REST API route /relationship.

=head2

We need to pass the database connection to this Package as input params.
using the DB connection, this package will query the database and return the
relationship hash.

=cut

sub new {
  my $class = shift;

  my $self = {
    _dbs => shift,
  };

  bless $self, $class;

  $self->_relationship;

# Returning $self Variable
  return $self;
}

sub _relationship {

  my $self = shift;
  my %relation;

  my $rs = $self->{_dbs}->resultset('Relationship');

  while(my $result = $rs->next) {

#Creating relation hash and this has needs to be return to the API.
    $relation{$result->relationship_name} = {
      relationship_name => $result->relationship_name,
      relationship_id   => $result->relationship_id
    }
  }

# Updates $self Variable
  $self->{_relation} = \%relation;

#Return control to the main function
  return ;
}

1;
