package familyProfile;

use strict;
use warnings;

use lib qw(lib/login lib/vaccination);

use login::MyHealth::Schema;
use MyHealthLogger qw<$log>;

use Data::Dumper;
use DateTime;
use DateTime::Format::MySQL;
use Time::Local;
use Date::Calc qw(Delta_Days);

=head1 Package Name
Name of the Package: familyProfile

=head1 Description
This Package is used to update the Family Profile.
when this package is initialize, it will retun the hash map for the
user updated values.

=head2 API : http://localhost:5000/family/:user/:values

=head3 Purpose

This Package can create the Family Profile and also calculate the vaccination
Schedule for the added Family Member.

=cut

sub new {
  my $class = shift;

  my $self = {
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

  my $login_id        = $self->get_login_id;
  my $first_name      = $self->get_first_name;
  my $middle_name     = $self->get_middle_name;
  my $last_name       = $self->get_last_name;
  my $dob             = $self->get_dob;
  my $age             = $self->get_age;
  my $gender          = $self->get_gender;
  my $blood_group     = $self->get_blood_group;
  my $weight          = $self->get_weight;
  my $height          = $self->get_height;
  my $aadhar_card     = $self->get_aadhar;
  my $relationship_id = $self->get_relationship_id;
  my $created_at      = $self->get_mySql_timestamp;
  my $updated_at      = $self->get_mySql_timestamp;

    my $profile = $self->{_dbs}->resultset('FamilyProfile')->create({
      login_id        => $login_id,
      relationship_id => $relationship_id,
      first_name      => $first_name,
      middle_name     => $middle_name,
      last_name       => $last_name,
      dob             => $dob,
      age             => $age,
      gender          => $gender,
      blood_group     => $blood_group,
      weight          => $weight,
      height          => $height,
      aadhar_card     => $aadhar_card,
      created_at      => $created_at,
      updated_at      => $updated_at
    });

  #
  # Destroy From Memory
  #
  ($login_id, $first_name, $middle_name, $last_name,
  $dob, $gender,  $blood_group, $weight,
  $height, $aadhar_card,
  $created_at, $updated_at
  ) = undef * 12;

#  return ('Family Profile Updated');
  return $self;
}

#
# Set Getters and Setters
#

sub set_login_id {
  my ($self, $user_id) = @_;

  $self->{_user}->{login_id} = $user_id;

  return $self;
}

sub set_first_name {
  my ($self, $first_name) = @_;

  $self->{_user}->{first_name} = $first_name;

  return $self;
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

sub set_gender {
  my ($self, $gender) = @_;

  $self->{_user}->{gender} = $gender;

  return;
}

# dob ==> Date Of Birth
sub set_dob {
  my ($self, $dob) = @_;

  $self->{_user}->{dob} = $dob;
  $self->{_user}->{age} = _get_age($dob);

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

sub set_aadhar {
  my ($self, $aadhar) = @_;

  $self->{_user}->{aadhar} = $aadhar;

  return;
}

sub set_relationship_id {
  my ($self, $relationship_id) = @_;

  $self->{_user}->{relationship_id} = $relationship_id;

  return;
}

#
# Getters
#
sub get_login_id {
  my $self = shift;

  return $self->{_user}->{login_id};
}

sub get_first_name {
  my $self = shift;

  return $self->{_user}->{first_name};
}

sub get_middle_name {
  my ($self, $middle_name) = @_;

  if ($self->{_user}->{middle_name}) {
    return $self->{_user}->{middle_name};
  }
  else {
    return;
  }
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

  my ($d, $m, $y) = split(/_/, $self->{_user}->{dob});

  return $y.'-'.$m.'-'.$d;
}

sub get_age {
  my $self = shift;

  return $self->{_user}->{age};
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

sub get_aadhar {
  my $self = shift;

  if ($self->{_user}->{aadhar}) {
    return $self->{_user}->{aadhar};
  }

  else {
    return '';
  }
}

sub get_relationship_id {
  my $self = shift;

  return ($self->{_user}->{relationship_id}) ;

}

# To get the timestamp
sub get_mySql_timestamp {
  my $self = shift;

  my $date = DateTime::Format::MySQL->parse_datetime(DateTime->now);

  return DateTime::Format::MySQL->format_datetime($date);
}

# To Calculate age
sub _get_age {

  my $dob = shift;

  my ($birth_date, $birth_month, $birth_year) = split(/_/, $dob);
  my ($day, $month, $year) = (localtime)[3,4,5];
  $year += 1900;
  $month += 1;

  my @today_sec = localtime();
  my $time = timelocal(@today_sec);
  my @birthday_sec = (0, 0, 0, $birth_date, $birth_month, $birth_year);
  my $birthtime = timelocal(@birthday_sec);
  my @birthday=($birth_year, $birth_month, $birth_date);
  my @today=($year, $month, $day);

  $log->info('Today : '.@today);
  $log->info('Birthday: '. @birthday );

  my $days = Delta_Days(@birthday, @today);
  my $netage="";
  if($days > 6) {
    my $age = $year - $birth_year;
    $age-- unless sprintf("%02d%02d", $month, $day)
    >= sprintf("%02d%02d", $birth_month, $birth_date);
    my $mnth=($month>$birth_month)?$month-$birth_month:12+($month-$birth_month);
    my $mnth_total=($age*12)+$mnth;

    if($mnth_total > 0 && $mnth_total < 4) {
      my $week=int($days/7);
      if($week > 1) {
        $netage = $week."W";
      } else {
        $netage = $week."W";
      }
    } elsif($mnth_total >= 4 && $mnth_total <= 24) {
      $netage = $mnth_total."M";
    } elsif($age >= 2 && $age < 18) {
      $netage = $age."Y";
      if($mnth == 1) {
        $netage .= " ".$mnth."Month";
      } elsif($mnth > 1) {
        $netage .= " ".$mnth."Months";
      } else { }
    } elsif($age >= 18) {
      $netage = $age."Y $mnth M";
    } else { }
  } else {
    $netage = $days." Days";
  }
  return $netage;
}

#
# Check Duplicate Nodes
#

sub check_duplicate_nodes {
  my $self = shift;

  my $result = $self->{_dbs}->resultset('FamilyProfile')->search({
    -and => [
        first_name => { like => $self->get_first_name },
        last_name  => { like => $self->get_last_name  }
      ]
  });

  if($result == 1){
    return 1;
  }
  else {
    return 0;
  }
}

1;
