package getVaccination;

use strict;
use warnings;

use Data::Dumper;

use lib "lib/login";

use login::MyHealth::Schema;


sub new {
  my $class = shift;

  my $self = {
    _dbh => shift,
  };

  bless $self, $class;

# Returning $self Variable
  return $self;
}

#
# Get the Vaccination for Profile Member
#
sub get_vaccination {

  my ($self, $user, $member_id) = @_;
  my %vaccination;

  my $schedule = $self->{_dbh}->prepare(
          "SELECT vaccination_date, vaccination_id 
          from vaccination_schedule 
          where family_profile_id = ?"
  );

  $schedule->execute($member_id) or die $DBI::errstr;

  while (my @row = $schedule->fetchrow_array()) {
    $vaccination{$member_id}{$row[1]} = {
      vaccination_id   => $row[1],
      vaccination_date => $row[0]
    };
  }

#Return control to the main function
  return \%vaccination;
}

1;
