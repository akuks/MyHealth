package MyHealth;
use Dancer2;

#Custom Packages
use login::userlogin;
use login::updateProfile;
use login::MyHealth::Schema;
use relationship::relationship;

use Data::Dumper;

set serializer => 'JSON';

# Version of Application
our $VERSION = '0.1';

#Database Login is Defined
my ($db) = userlogin->new();

# At present the logger is not setup. Will introduce logger soon
#print Dumper($db->{_dbs});

=head1 Name
Name of the Package: MyHealth

=head2 Description

=head3 Routes

=cut

get '/' => sub {
    return {message => 'Hello There'};
};

get '/hello' => sub {
  return {next_message => 'Hello Rest API'};
};

# To check the existing of User in the database.
get '/checkuser/:user/:password' => sub  {

  my $output = $db->checkuser(
                   params->{user},
                   params->{password}
               );

# $output have two values:
#  1. If User Exist => return generateed sessionKey
#  2. If User doesn't exist => 0

  return {user_Exist => $output};
};

# To get User Login and sessionKey
get '/login/safe/:user/:sessionKey' => sub {

#
# Checking if the session Key passed is equal to the session key generated
# If not then it will return 'Invalid Session Key' Message to the client
#

  if($db->{params->{user}}->{sessionKey} ne params->{sessionKey}) {
    return {login_session_key => 'Invalid Session Key'};
  }

  my $login_key = $db->create_db_session(
                            params->{user},
                            params->{sessionKey}
                          );
  return {
    login_session_key => $login_key
  };
};

# To create User Login
post '/login/newuser/:user/:password' => sub {
  my $new_user = $db->create_new_user(
                   params->{user},
                   params->{password}
                 );
return {message => $new_user};
  if (defined $new_user){
    return {message => $new_user};
  }
  else {
    return {message => 'Unable to create '.params->{user}.'.'};
  }
};

#
# This API will be used to update the User Profile
#
post '/login/user/update/:user/:values' => sub {

  if (! $db->{params->{user}}->{login_session_key}) {

    return {
      ERROR_1104 => 'Invalid API Query as User is not logged in.'
    };
  }

  my @values = split(/\&/, params->{values});
  chomp(@values);

  if (scalar(@values) != 12){
    return { ERROR_1105 => 'Invalid Number of Elements. '};
  }

  my %login;
  $login{login_id} = $db->get_login_id(params->{user});

  if(!$login{login_id}) {
    return { ERROR_1105 => 'User Doesn\'t Exist.'};
  }

# To make passing variable as hash reference :)
  my $login = \%login::;

  #print Dumper($db->{_dbs});

  my $update = updateProfile->new($db->{_dbs}, $login->{login_id});

  $update->set_login_id($login{login_id});
  $update->set_first_name($values[0]);
  $update->set_middle_name($values[1]) if $values[1];
  $update->set_last_name($values[2]);
  $update->set_gender($values[3]);
  $update->set_dob($values[4]);
  $update->set_blood_group($values[5]);
  $update->set_weight($values[6]);
  $update->set_height($values[7]);
  $update->set_mobile($values[8]);
  $update->set_aadhar($values[9]) if $values[9];
  $update->set_address($values[10]) if $values[10];
  $update->set_pincode($values[11])if $values[11];

  my $msg = $update->insert_in_db();

  return {
          values => $update->{_toUpdate}
        };

};
#
# Add family Members
#
post '/addrelative/:user/:value' => sub {

##################

  if (! $db->{params->{user}}->{login_session_key}) {

    return {
      ERROR_1104 => 'Invalid API Query as User is not logged in.'
    };
  }
##############



  return {
      values => 'Returned'
  };
};

post '/forgotpassword/:user' => sub {
  my $reset_password = $db->reset_password(params->{user});

  return {fp_message => 'New Password is sent to your registered Email ID.'}
};

get '/logout/:user' => sub {

  if ($db->{params->{user}}){
    undef $db->{params->{user}};

    return { logout_message => 'User Logged Out succesfully'  };
  }
  else{
    return {logout_message => 'Session Expired Or User does not exist.'};
  }
};

# get the relationship and their ID's
get '/relationship' => sub {
  #Check for
  my $relation = relationship->new($db->{_dbs});

  return {Relation => $relation->{_relation}};
};

# Catch Invalid REST API Call. If user calls invalid API, User will get the
# ERROR_404 Message.
any qr{.*} => sub {
  status 'not_found';
  return { ERROR_404 => 'Invalid API. !!!' };
};

true;
