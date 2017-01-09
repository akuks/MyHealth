package updateProfile.pm;

use strict;
use warnings;

=head1 Package Name
   Name of the Package: updateProfile

=head1 Description
This Package is used to update the User Profile.
when this package is initialize, it will retun the hash map for the
user updated values.

$self->{_toUpdate}

=cut

sub new {
  my $class = shift;
  my %params = @_;

  my $self = {
    _dbs   => $params{_dbs},
    _value => $params{_values}
  };

  bless $self, $class;

  $self->_update;

  return $self->{_toUpdate};
}

sub _update {
  my $self = shift;
  my %user_update = {};

  $self->{_toUpdate} = \%user_update;

  return $self;
}

1;
