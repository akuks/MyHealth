package vaccinationScheduler;

use strict;
use warnings;

use lib qw(lib/login lib/vaccination);

use login::MyHealth::Schema;
use MyHealthLogger qw<$log>;

my %vaccination;

BEGIN {
  my $conf = 'conf/vaccination.conf';
  $vaccination = do ($conf);
}

sub new {
  my $class = shift;

  my $self = {
    _age    => shift,
    _gender => shift,
  };

  bless $self, $class;

  $self->{_vacc} = $self->get_vacc;

  return $self;
}

sub get_vacc {
  my $self = shift;

  return;
}


1;
