package devScreening;

use strict;
use warnings;

use lib qw(lib/login lib/vaccination);

use login::MyHealth::Schema;
use MyHealthLogger qw<$log>;


sub new {
  my $class = shift;

  my $self = {
    _dbs   => shift,
    _user  => shift
  };

  #  print "Update Profile : \n";
  #  print Dumper($self->{_dbs});

  bless $self, $class;

  $self->_devScreeningDetails;

  return $self;
}

sub _devScreeningDetails {
  my $self = shift;

#
# FP => Family Profile
#
  $rs = $self->{_dbs}->resultset('FamilyProfile')->search({
      -and => [
        login_id    => { like => $self->{_user} }
      ]
  });

  return $self;
}

sub set_familyid {
  my ($self, $fam_id) = @_;

  $self->{_user}->{_familyid} = $fam_id;

  return;
}

sub set_questionid {
  my ($self, $question_id) = @_;

  $self->{_user}->{_questionid} = $question_id;

  return;
}

sub set_response {
  my ($self, $response) = @_;

  $self->{_user}->{_response} = $response;

  return;
}

#
# Getters
#

sub get_familyid {
  my $self = shift;

  return $self->{_user}->{_familyid};
}


sub get_questionid {
  my $self = shift;

  return $self->{_user}->{_questionid};
}

sub get_response {
  my $self = shift;

  return $self->{_user}->{_response};
}
