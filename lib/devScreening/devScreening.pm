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

  #
  #  print "Update Profile : \n";
  #  print Dumper($self->{_dbs});
  #

  bless $self, $class;

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

sub set_status {
  my $self = shift;

  my $result = $self->{_dbs}
                    ->resultset('DevelopmentScreeningTracker')
                    ->search({
                      -and => [
                         familiy_id    => { like => $self->get_familyid },
                         question_id   => { like => $self->get_questionid },
                       ]
                });
  if (not defined $result) {
    print "Error Man \n";
  }
  else {
    while (my $rs = $result->next) {
        $self->{_user}->{status}  = $rs->status;
        $self->{_user}->{counter} = $rs->counter;
      }
    }

#
# Application Will only ask this Question to user for only threee time.
# Hence Counter is required.
# If user asnwers no
# If Counter is 2, ++counter and update the status as 3. (Consult to doctor).
# If Counter is 0, ++counter and update the status as 0. (Question is Active)
# if Counter is 1, ++counter and update the status as 0. (Question is Active)
#

  if ($self->get_response == 0) {
    if ($self->get_counter == 2) {
      $self->{_user}->{status} = 3;
      $self->set_counter(3);
    }
    elsif ($self->get_counter == 1) {
      $self->{_user}->{status} = 0;
      $self->set_counter(2);
    }
    elsif ($self->get_counter == 0){
      $self->{_user}->{status} = 0;
      $self->set_counter(1);
    }
    else {
      $self->{_user}->{status} = 'Invalid Status';
      $self->set_counter('InValid Counter Value');
    }
  }
  elsif ($self->get_response == 1) {
    $self->{_user}->{status} = 2;
    $self->set_counter(4);
  }
}

sub set_counter {
  my ($self, $c) = @_;

  $self->{_user}->{counter} = $c;

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

sub get_status {
  my $self = shift;

  return $self->{_user}->{status};
}

sub get_counter {
  my $self = shift;

  return $self->{_user}->{counter};
}

sub update_development_tracker {
  my $self = shift;

  my $result = $self->{_dbs}
                    ->resultset('DevelopmentScreeningTracker')
                    ->search({
                      -and => [
                         familiy_id    => { like => $self->get_familyid },
                         question_id   => { like => $self->get_questionid },
                       ]
                });
# Update the Response.
  $result->update({
    counter    => $self->{_user}->{counter},
    status     => $self->{_user}->{status},
    user_input => $self->{_user}->{response}
  });

  if ($result) {
    return 1;
  }
  else {
    return 0;
  }
}

sub get_screening_details {
  my $self = shift;

  my %screening;

  my $result = $self->{_dbs}
                    ->resultset('DevelopmentScreeningTracker')
                    ->search({
                      -and => [
                         familiy_id    => { like => $self->get_familyid },
                         question_id   => { like => $self->get_questionid },
                       ]
                });
    while (my $rs = $result->next) {
      $screening{$self->{_user}}->{$rs->family_id} = {
        $rs->question_id => $rs->question_id
      };
    }
    $self->{_user}->{screening} = \%screening;
    return;
}

1;
