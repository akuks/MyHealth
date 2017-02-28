package updateProfile;

use strict;
use warnings;

use lib "lib/login";

use login::MyHealth::Schema;


use Data::Dumper;
use DateTime;
use DateTime::Format::MySQL;

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

  my $self->{Profile} = {
    _dbs   => shift,
    _user  => shift
  };

#  print "Update Profile : \n";
#  print Dumper($self->{_dbs});

  bless $self, $class;

  return $self;
}

sub insert_in_db {
  my ($self) = @_;

#   print Dumper($self);

  my $login_id    = $self->get_login_id;
  my $first_name  = $self->get_first_name;
  my $middle_name = $self->get_middle_name;
  my $last_name   = $self->get_last_name;
  my $dob         = $self->get_dob;
  my $gender      = $self->get_gender;
  my $mobile      = $self->get_mobile;
  my $blood_group = $self->get_blood_group;
  my $weight      = $self->get_weight;
  my $height      = $self->get_height;
  my $aadhar_card = $self->get_aadhar;
  my $address     = $self->get_address;
  my $created_at  = $self->get_mySql_timestamp;
  my $updated_at  = $self->get_mySql_timestamp;
  my $pin_code    = $self->get_pincode;

  my $profile = $self->{Profile}->{_dbs}->resultset('UserProfile')->create({
    login_id    => $login_id,
    first_name  => $first_name,
    middle_name => $middle_name,
    last_name   => $last_name,
    dob         => $dob,
    gender      => $gender,
    mobile      => $mobile,
    blood_group => $blood_group,
    weight      => $weight,
    height      => $height,
    aadhar_card => $aadhar_card,
    address     => $address,
    pin_code    => $pin_code,
    created_at  => $created_at,
    updated_at  => $updated_at
  });

#
# Destroy From Memory
#
 ($login_id, $first_name, $middle_name, $last_name,
         $dob, $gender, $mobile, $blood_group, $weight,
         $height, $aadhar_card, $address, $pin_code,
         $created_at, $updated_at
        ) = undef * 15;

  return ('Profile Updated');
}

#
# Setting Getter and Setter for Profile Values
#

sub set_login_id {
  my $self = shift;
  my $user_id = shift;

  $self->{Profile}->{_user}->{user_id} = $user_id;

  return 1 if $user_id;
}

sub set_first_name {
  my $self = shift;
  my $first_name = shift;

  $self->{Profile}->{_user}->{first_name} = $first_name;

  return 1 if $first_name;
}

sub set_middle_name {
  my ($self, $middle_name) = @_;

  $self->{Profile}->{_user}->{middle_name} = $middle_name;

  return;
}

sub set_last_name {
  my ($self, $last_name) = @_;

  $self->{Profile}->{_user}->{last_name} = $last_name;

  return;
}

sub set_gender {
  my ($self, $gender) = @_;

  $self->{Profile}->{_user}->{gender} = $gender;

  return;
}

# dob ==> Date Of Birth
sub set_dob {
  my ($self, $dob) = @_;

  $self->{Profile}->{_user}->{dob} = $dob;

  return;
}

sub set_blood_group {
  my ($self, $blood_group) = @_;

  $self->{Profile}->{_user}->{blood_group} = $blood_group;

  return;
}

sub set_weight {
  my ($self, $weight) = @_;

  $self->{Profile}->{_user}->{weight} = $weight;

  return;
}

sub set_height {
  my ($self, $height) = @_;

  $self->{Profile}->{_user}->{height} = $height;

  return;
}

sub set_mobile {
  my ($self, $mobile) = @_;

  $self->{Profile}->{_user}->{mobile} = $mobile;

  return;
}

sub set_aadhar {
  my ($self, $aadhar) = @_;

  $self->{Profile}->{_user}->{aadhar} = $aadhar;

  return;
}

sub set_address {
  my ($self, $address) = @_;

  $self->{Profile}->{_user}->{address} = $address;

  return;
}

sub set_pincode {
  my ($self, $pincode) = @_;

  $self->{Profile}->{_user}->{pincode} = $pincode;

  return;
}

############

sub get_login_id {
  my $self = shift;

  return $self->{Profile}->{_user}->{user_id};
}

sub get_first_name {
  my $self = shift;

  return $self->{Profile}->{_user}->{first_name};
}

sub get_middle_name {
  my ($self, $middle_name) = @_;

  if ($self->{Profile}->{_user}->{middle_name}) {
    return $self->{Profile}->{_user}->{middle_name};
  }
  else {
    return;
  }
}

sub get_last_name {
  my $self = shift;

  return $self->{Profile}->{_user}->{last_name};
}

sub get_gender {
  my $self = shift;

  return $self->{Profile}->{_user}->{gender};
}

# dob ==> Date Of Birth
sub get_dob {
  my $self = shift;

  return $self->{Profile}->{_user}->{dob};
}

sub get_blood_group {
  my $self = shift;

  return $self->{Profile}->{_user}->{blood_group};
}

sub get_weight {
  my $self = shift;

  return $self->{Profile}->{_user}->{weight};
}

sub get_height {
  my $self = shift;

  return $self->{Profile}->{_user}->{height};
}

sub get_mobile {
  my $self = shift;

  return $self->{Profile}->{_user}->{mobile};
}

sub get_aadhar {
  my $self = shift;

  if ($self->{Profile}->{_user}->{aadhar}) {
    return $self->{Profile}->{_user}->{aadhar};
  }

  else {
    return '';
  }
}

sub get_address {
  my $self = shift;

  if ($self->{Profile}->{_user}->{address}) {
    return $self->{Profile}->{_user}->{address};
  }
  else {
    return;
  }
}

sub get_pincode {
  my $self = shift;

  if($self->{Profile}->{_user}->{pincode}) {
    return $self->{Profile}->{_user}->{pincode};
  }
  else{
    return;
  }
}

# To get the timestamp
sub get_mySql_timestamp {
  my $self = shift;

  my $date = DateTime::Format::MySQL->parse_datetime(DateTime->now);

  return DateTime::Format::MySQL->format_datetime($date);
}

1;
