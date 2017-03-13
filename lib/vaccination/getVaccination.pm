package getVaccination;

use strict;
use warnings;

use Data::Dumper;

use lib "lib/login";

use login::MyHealth::Schema;


sub new {
  my $class = shift;

  my $self = {
    _dbs => shift,
  };

  bless $self, $class;

  $self->_vaccination;

# Returning $self Variable
  return $self;
}

sub _vaccination {

  my $self = shift;
  my %vaccination;

  my $rs = $self->{_dbs}->resultset('Vaccination');

  while(my $result = $rs->next) {

#Creating relation hash and this has needs to be return to the API.
    $vaccination{$result->vaccine_name} = {
      vaccine_name => $result->vaccine_name,
      vaccine_id   => $result->vaccination_id
    }
  }

# Updates $self Variable
  $self->{_vaccination} = \%vaccination;

#Return control to the main function
  return ;
}

1;
