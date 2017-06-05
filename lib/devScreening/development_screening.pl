#!/usr/bin/perl

use strict;
use warnings;

use Date::Calc qw/Days_in_Month/;
use DBI;

use Data::Dumper;



=head1 Name development_screening.pl

usage: perl development_screening.pl

Updated in the CronJob and will be run once in a day under /etc/cron.d/

=cut

#loading configuration file
my $conf = do ('../conf/db.conf');

my ($sth, $dbh, $qth);
my (%result, %question_timing);

# Database Connection String
$dbh = DBI->connect(
            'DBI:mysql:'.$conf->{database},
            $conf->{username},
            $conf->{password},
            {AutoCommit => 0},
            {RaiseError => 1}
  ) || die "Could not connect to database: $DBI::errstr";

$sth = $dbh->prepare('SELECT family_profile_id, login_id, dob,
                      gender FROM MyHealth_DB.family_profile');

$qth = $dbh->prepare('SELECT * FROM MyHealth_DB.question_timing');

$sth->execute();
$qth->execute();

#
# $row[0] => Age In Months
# $row[1] => Question ID
#

while (my @row = $qth->fetchrow_array()){
  $question_timing{$row[1]}{$row[0]} = $row[1];
}

#
# $row[1] => User Login ID
# $row[0] => Family User ID
# $row[2] => Date Of Birth
# $row[3] => Gender
#
# %result hash Structure
# $result{user_login_id}{family_profile_id}{date_of_birth}
# $result{user_login_id}{family_profile_id}{gender}
# $result{user_login_id}{family_profile_id}{family_id},
# $result{user_login_id}{family_profile_id}{age_in_months}
#

while (my @row = $sth->fetchrow_array()) {

  # age_in_months upto one decimal Place
  my $age_in_months = sprintf "%.1f", calculate_Age_in_months($row[2]);

  if ($question_timing{$age_in_months}) {
    my @question_ID;
    foreach my $ques_id (keys $question_timing{$age_in_months}){
      push @question_ID, $ques_id;
    }

#
# Check DB to prevent the duplicates
#
    check_dev_screen_qid ($row[0], \@question_ID);

# Skip the Loop IF
    next if (scalar(@question_ID) == 0);

    $result{$row[1]}{$row[0]} = {
      dob           => $row[2],
      gender        => $row[3],
      family_id     => $row[0],
      age_in_months => $age_in_months,
      question_ids  => @question_ID,
    };
  }
}

print Dumper(\%result);

update_development_tracker_db(\%result);

#print Dumper(\%question_timing);

#
# This Subroutine is to calculate the age in Months
#

sub calculate_Age_in_months {
  my $dob = shift;

  my ($birth_year, $birth_month, $birth_day) = split(/-/, $dob);

  my @date = localtime(time);

  my $days_in_month = eval { Days_in_Month( $birth_year, $birth_month) };

  my $current_months =((($date[5] + 1900) * 12) + ($date[4] + 1) +
                    ($date[3] / eval { Days_in_Month( $date[5], $date[4] + 1)}));

  my $total_months = $birth_year * 12 + $birth_month
                                      + ($birth_day/$days_in_month);

  return ($current_months - $total_months);
}

sub update_development_tracker_db {
  my $res = shift;

  my $dsth = $dbh->prepare(
                "INSERT INTO MyHealth_DB.development_screening_tracker
                (family_id, question_id)
                values
                (?, ?)"
             );

  foreach my $user_id (keys %$res) {
    foreach my $fam_id (keys %{$res->{$user_id}}){

      if (ref($res->{$user_id}->{$fam_id}->{question_ids}) eq 'ARRAY' ) {
        foreach my $qid ( @ { $res->{$user_id}->${fam_id}->question_ids}) {
          $dsth->execute($fam_id, $qid) or die $DBI::errstr;
        }
      }
      else {
        $dsth->execute($fam_id, $res->{$user_id}->{$fam_id}->{question_ids})
                 or die $DBI::errstr;
      }
    }
    $dsth->finish();
    $dbh->commit or die $DBI::errstr;
  }
  return;
}

sub check_dev_screen_qid {
  my ($fam_id, $ques_ref) = @_;

  my $dsth = $dbh->prepare("SELECT family_id, question_id
                    FROM MyHealth_DB.development_screening_tracker
                    WHERE family_id = ? and question_id = ?"
                   );

  foreach my $ques_id (@$ques_ref) {

    $dsth->execute($fam_id, $ques_id);

    if($dsth->rows > 0){
      print "Family ID : $fam_id and Question $ques_id : already there";
      print "No need to update\n";
      @$ques_ref = grep { $_ != $ques_id } @$ques_ref;
    }
    else {
      print "Family ID : $fam_id and Question : $ques_id needs to be updated \n";
    }
  }
  return;
}

package screeningLogger;

1;
