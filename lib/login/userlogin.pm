package userlogin;

use strict;
use warnings;

use lib "lib/login";
use Digest::MD5 qw(md5_base64);

use Data::Dumper;
use Time::Piece;

use login::MyHealth::Schema;

=head1 Name
Package Name: userlogin

=head1 Description
To check the existence Of User
To create new User
To create session ID for the users;

=head2 Method 1 _initialize
- Read the Configuration File.
- Setup the connection with the MySql Database and return the
  control to the main program.
- DB connection will setup once the web server starts up.

=head2 Method 1 _initialize Description
  It is an internal Sub routine to read the configuration file and setup the
  datebase connection.
  and store the connection value in the $self->{_dbs} hash variable.
  Once the database connection is setup. $self->{_confDetails} hash variable is
  undef to free the moemory to use for another Perl function ot variable.
=cut

sub new {
  my $class = shift;
  my $self = {};

  bless $self, $class;

# Call the _initialize subroutine
  $self->_initialize;

  return ($self);
}

#
sub _initialize {
  my $self = shift;
  $self->{_conf} = 'conf/db.conf';

# Load on Configuration File
  $self->{_confDetails} = do($self->{_conf});

  die "Error parsing config file: $@" if $@;
  die "Error reading config file: $!"
        unless defined $self->{_confDetails};

# Setup the connection with the MySql Database.
  $self->{_dbs} = MyHealth::Schema->connect(
      'dbi:mysql:database='.$self
                       ->{_confDetails}
                       ->{database},
       $self->{_confDetails}->{username},
       $self->{_confDetails}->{password}
  ) or die 'Can\'t connect to database', "\n";

  undef $self->{_confDetails};
  undef $self->{_conf} ;

  return $self;
}

#Check the existence of User in the database
sub checkuser {

  my ($self, $user, $password) = @_;

  my $user_result = $self->{_dbs}->resultset('Login');

  my $result = $user_result->find({
    email    => $user,
    password => md5_base64($password)
  });

  if (defined $result){
    $self->{$user}->{sessionKey} = md5_base64($password);
    return $self->{$user}->{sessionKey};
  }
  else{
    return 0;
  }
}

# Create a Session in Database
sub create_db_session {
  my ($self, $user, $sessionKey) = @_;

  my $session = md5_base64($user.$sessionKey);
  chomp($session);

  undef $self->{$user}->{sessionKey} if $session;

  $self->{$user}->{login_session_key} = $session if $session;
  return $session;
}

# Create New User
sub create_new_user {
  my ($self, $user, $password) = @_;

# Double Check if User already exist in DB.
  my $output = $self->checkuser($user, $password);

  if ($output ne 0){
    print "output : ", $output;
    return ('Fatal Error, User Already Exist in database');
  }

  my $timestamp = _get_mySql_timestamp();

  my $new_user = $self->{_dbs}->resultset('Login')->create({
    email      => $user,
    password   => md5_base64($password),
    created_at => $timestamp,
    updated_at => $timestamp
  });

  return ('Congrats the User '.$user.' has been created');
}

# To get the timestamp
sub _get_mySql_timestamp {

  my $date = localtime->ymd;
  my $time = localtime->hms;

  return $date.' '.$time;

}

# To be Updated Later
sub reset_password {
  my ($self, $user) = @_;

  return;
}

# To get login ID
sub get_login_id {
  my ($self, $user) = @_;

  my $login_id = $self->{_dbs}->resultset('Login')->find({
    email  => $user
  });

  return $login_id->login_id;
}

1;

__END__
