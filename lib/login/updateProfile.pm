package updateProfile;

use strict;
use warnings;

use lib "lib/login";

use login::MyHealth::Schema;

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
    _user  => $params{_user}
  };

  bless $self, $class;

  return $self;
}

sub insert_in_db {
  my ($self) = shift;

  my $profile = $self->{_dbs}->resultset('UserProfile')->create({

    login_id    => $self->{_user},
    first_name  => $self->{_user}->{first_name},
    middle_name => $self->{_user}->{middle_name},
    last_name   => $self->{_user}->{last_name},
    dob         => $self->{_user}->{dob},
    gender      => $self->{_user}->{gender},
    mobile      => $self->{_user}->{mobile},
    blood_group => $self->{_user}->{blood_group},
    weight      => $self->{_user}->{weight},
    height      => $self->{_user}->{height},
    aadhar_card => $self->{_user}->{aadhar},
    address     => $self->{_user}->{address},
    pin_code    => $self->{_user}->{pincode},
    created_at  => _get_mySql_timestamp(),
    updated_at  => _get_mySql_timestamp()
  });

  return ('Profile Updated');
}

# To get the timestamp
sub _get_mySql_timestamp {

  my $date = localtime->ymd;
  my $time = localtime->hms;

  return $date.' '.$time;

}

#
# Setting Getter and Setter for Profile Values
#

sub set_first_name {
  my $self = shift;
  my $first_name = shift;

  $self->{_user}->{first_name} = $first_name;

  return 1 if $first_name;
}

sub set_middle_name {
  my ($self, $middle_name) = @_;

  $self->{_user}->{middle_name} = $middle_name;

  return;
}

sub set_last_name {
  my ($self, $last_name) = @_;

  $self->{_user}->{last_name} = $last_name;

  return;
}

sub set_geder {
  my ($self, $gender) = @_;

  $self->{_user}->{gender} = $gender;

  return;
}

# dob ==> Date Of Birth
sub set_dob {
  my ($self, $dob) = @_;

  $self->{_user}->{dob} = $dob;

  return;
}

sub set_blood_group {
  my ($self, $blood_group) = @_;

  $self->{_user}->{blood_group} = $blood_group;

  return;
}

sub set_weight {
  my ($self, $weight) = @_;

  $self->{_user}->{weight} = $weight;

  return;
}

sub set_height {
  my ($self, $height) = @_;

  $self->{_user}->{height} = $height;

  return;
}

sub set_mobile {
  my ($self, $mobile) = @_;

  $self->{_user}->{mobile} = $mobile;

  return;
}

sub set_aadhar {
  my ($self, $aadhar) = @_;

  $self->{_user}->{aadhar} = $aadhar;

  return;
}

sub set_address {
  my ($self, $address) = @_;

  $self->{_user}->{address} = $address;

  return;
}

sub set_pincode {
  my ($self, $pincode) = @_;

  $self->{_user}->{pincode} = $pincode;

  return;
}

############

sub get_first_name {
  my $self = shift;

  return $self->{_user}->{first_name};
}

sub get_middle_name {
  my ($self, $middle_name) = @_;

  return $self->{_user}->{middle_name};
}

sub get_last_name {
  my $self = shift;

  return $self->{_user}->{last_name};
}

sub get_gender {
  my $self = shift;

  return $self->{_user}->{gender};
}

# dob ==> Date Of Birth
sub get_dob {
  my $self = shift;

  return $self->{_user}->{dob};
}

sub get_blood_group {
  my $self = shift;

  return $self->{_user}->{blood_group};
}

sub get_weight {
  my $self = shift;

  return $self->{_user}->{weight};
}

sub get_height {
  my $self = shift;

  return $self->{_user}->{height};
}

sub get_mobile {
  my $self = shift;

  return $self->{_user}->{mobile};
}

sub get_aadhar {
  my $self = shift;

  return $self->{_user}->{aadhar};
}

sub get_address {
  my $self = shift_;

  return $self->{_user}->{address};
}

sub get_pincode {
  my $self = shift;

  return $self->{_user}->{pincode};
}

1;
