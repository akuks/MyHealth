package dbConnection;

use strict;
use warnings;

use DBI;
use Digest::MD5 qw(md5_base64);

use MyHealthLogger qw<$log>;

sub new {
    my $class = shift;

    my $self = {};

    $self->{_conf} = do ('conf/db.conf');

    $self->{_dsn} = 'DBI:mysql:database='.$self->{_conf}->{database};

    $self->{_dbh} = DBI->connect($self->{_dsn}, 
                                 $self->{_conf}->{username}, 
                                 $self->{_conf}->{password},
                                 {
                                     AutoCommit => 0,
                                     RaiseError => 1,
                                 } 
                    ) or die $DBI::errstr;

    bless $self, $class;

    return $self;
}

sub update_user_verification_code {
    my ($self, $verification_code, $user) = @_;

#
# Check if the Verification Code is already in the database
#
    my $sth = $self->{_dbh}->prepare(
        "select code, user_email from user_verification_code 
        where user_email = ?"
    );
#Execute the Above Query
    $sth->execute($user) or die $DBI::errstr;

    if ($sth->rows > 0) {
        $log->info("Verification Code Already Sent for the User $user");
        $log->info("Needs to update the old Verification Code for $user");
        $log->info("Updating the Old Verification Code for $user");

        my $sth_u = $self->{_dbh}->prepare(
            "DELETE from user_verification_code where user_email = ? "
        );
        $sth_u->execute($user) or die $DBI::errstr;
        $log->info('Entries Deleted from the user_verification_code table');
        $log->info('Number of Entries Deleted for '.$user.' '.$sth_u->rows);

        $sth_u->finish();
        $self->{_dbh}->commit or die $DBI::errstr;
    }
    
    my $sth_i = $self->{_dbh}->prepare(
            "INSERT INTO user_verification_code 
            (code, user_email) 
            values (?, ?)"
        );
#
# Insert Verification code into the Database
#
    $sth_i->execute($verification_code, $user) or die $DBI::errstr;
    $sth_i->finish();
    $self->{_dbh}->commit or die $DBI::errstr;

    $log->info($verification_code.' Inserted into the database for '.$user);

    return;
}

#
#Verify the Code provided by the user
#
sub verify_user_code {
    my ($self, $code) = @_;

    my $sth = $self->{_dbh}->prepare(
        "select code, user_email from user_verification_code 
        where code = ?"
    );

    $sth->execute($code) or die $DBI::errstr;

    if ($sth->rows == 1) {
        return 1;
    }
    return 0;
}

#
# Update Password in Database
#

sub update_user_password {
  my ($self, $user, $pass) = @_;

  my $user_result = $self->{_dbh}->prepare(
      "SELECT email from login where email = ?"
  );

  $user_result->execute($user);

  if ($user_result->rows == 0 or $user_result->rows > 1){
    $log->info("No User found or may be more than one User are created");
    return 0;
  }
  else {
    my $update_user = $self->{_dbh}->prepare(
        "UPDATE login SET password = ?"
    );

    $update_user->execute(md5_base64($pass));

    $update_user->finish();
    $self->{_dbh}->commit or die $DBI::errstr;
    
    return 1;
  }

  return;
}

1;
__END__