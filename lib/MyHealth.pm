package MyHealth;
use Dancer2;

use login::userlogin;
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

# This API will be used to update the User Profile
post '/login/user/update/:user/:values' => sub {
  if (! $db->{params->{user}}->{login_session_key}) {
    return {
      ERROR_ => 'Invalid API Query as User is not logged in ot not valid.'
    };
  }

  my @values = split(/\&/, params->{values});

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
