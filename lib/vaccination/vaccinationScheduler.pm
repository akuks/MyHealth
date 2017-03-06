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

  $self->infant_vSchedule if $age =~ /Weeks/;

  return $self;
}

sub infant_vSchedule {
  my $self = shift;

  my $age = split(/ +/, $self->{_age})

  if ($age < 1) {
    $self->{_age}->{dueVacc} = ["BCG", "HEPB", "POLIO"];
    $self->{_age}->{dueDate} = 'Now';
  }


  return;
}

1;
