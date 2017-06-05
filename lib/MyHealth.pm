package MyHealth;
use Dancer2;

#Custom Packages
use login::userlogin;
use login::updateProfile;
use login::familyProfile;

use login::MyHealth::Schema;
use relationship::relationship;
use vaccination::getVaccination;
use devScreening::devScreening;
use sendEmail;

use database::dbConnection;

use MyHealthLogger qw($log);

use Data::Dumper;

set serializer => 'JSON';

# Version of Application
our $VERSION = '0.1';

#Database Login is Defined
my ($db) = userlogin->new();

#
# Database Login Alternate
# This will be Changed in future and should be merge with the 
# DBIx::Class. 
#
my ($dbh) = dbConnection->new();

if ($db and $dbh) {
  $log->info('DB Connection Ok');
}
else {
  $log->info('Error in DB Connection');
}


# At present the logger is not setup. Will introduce logger soon
#print Dumper($db->{_dbs});
#print Dumper($dbh);

=head1 Name
Name of the Package: MyHealth

=head2 Description

=head3 Routes

=cut

# To cehck Email ID is registered with Application

get '/checkuser/:user/' => sub {
  my $output = $db->checkemail(
                   params->{user}
              );
# $output have two values:
#  1. If User Exist => return generateed sessionKey
#  2. If User doesn't exist => 0

  return {user_Exist => $output};
} ;

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

#
# Forgot Password API
#
post '/forgotpassword/:user/reset_password' => sub {
  my $reset_password = $db->reset_password(params->{user});

  if ($reset_password) {
    my $mail = sendEmail->new(params->{user},
                              'noreply@linkinbridges.com');
    my $verification_code = $mail->send_reset_password();

    $dbh->update_user_verification_code($verification_code, params->{user});

    return {
      fp_message => 'Verification Code is Sent to your registered Email ID.',
      verification_Code => $verification_code
    };
  }
  else {
    fp_message => 'Invalid Request!!! :()'
  }
};

#
# Update Password in DB
#
post '/updatePassword/:user/:code/:pass1/:pass2' => sub {

# If passwords are not Matched

  if (params->{pass1} ne params->{pass2}) {
    return {
      pass_mismatch_error => 'Password Doesn\'t Match'
    };
  }

  my $code_sent_verification = $dbh->verify_user_code(params->{code});

#
# If user enters invalid Verification Code sent 
#
  if (!$code_sent_verification){
    return {
      code_mismatch_error => 'Verification Code Mismatch'
    };
  }

  my $reset = $dbh->update_user_password(
                        params->{user}, 
                        params->{pass1}
                );

  return { reset_message => 'Password Reset Succesfully'} if $reset; # if password reset succesfull
  return { reset_message => 0}; # if password Reset Fails

};

# To create User Login
post '/login/newuser/:user/:password' => sub {
  my $new_user = $db->create_new_user(
                   params->{user},
                   params->{password}
                 );

  if (defined $new_user){
    my $verification_email = sendEmail->new(
         params->{user},
         'noreply@linkinbridges.com',
         params->{password},
    );

    $verification_email->send_email;

    return {
      message => $new_user.' is Created.',
      email_message => 'Verification Email has been sent to your Account.'
    };
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
          values => $update
        };

};

#
# Add family Members
#
post '/family/:user/:values' => sub {

##################

  if (! $db->{params->{user}}->{login_session_key}) {

    return {
      ERROR_1104 => 'Invalid API Query as User is not logged in.'
    };
  }
##############

  my @values = split(/\&/, params->{values});
  chomp(@values);

  print "Number of Elements : ", scalar(@values), "\n";

  if (scalar(@values) != 10){
    return { ERROR_1105 => 'Invalid Number of Elements. '};
  }

  my %login;
  $login{login_id} = $db->get_login_id(params->{user});

  if(!$login{login_id}) {
    return { ERROR_1105 => 'User Doesn\'t Exist.'};
  }

  # To make passing variable as hash reference :)
  my $login = \%login::;

  my $family = familyProfile->new(
                       $db->{_dbs},
                       $login->{login_id}
                  );

  $family->set_login_id($login{login_id});
  $family->set_first_name($values[0]);
  $family->set_middle_name($values[1]) if $values[1];
  $family->set_last_name($values[2]);
  $family->set_gender($values[3]);
  $family->set_dob($values[4]);
  $family->set_blood_group($values[5]);
  $family->set_weight($values[6]);
  $family->set_height($values[7]);
  $family->set_aadhar($values[8]) if $values[8];
  $family->set_relationship_id($values[9]);

#
# Check for Duplicate family Members
#

  my $dup = $family->check_duplicate_nodes;

  if ($dup == 1){
    return {values => 1};
  }

  my $msg = $family->insert_in_db();

  $log->info($values[0].' '.$values[3].' Member to be Added');
  $log->info('Family Member Added For User '.$login->{login_id});

  return {
          values => $msg->{_user}
        };
};

#
# Get Family Details
# Relation Between User ID and Family ID
#

get '/family/:user/:id' => sub {

  ##################

    if (! $db->{params->{user}}->{login_session_key}) {

      return {
        ERROR_1104 => 'Invalid API Query as User is not logged in.'
      };
    }
  ##############

  my $family = familyProfile->new(
                       $db->{_dbs},
                       params->{id}
                  );

  my $family_details = $family->get_family_details;

  return { Family_Details => $family_details};
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

#get Vaccination and its ID

get '/vaccination' => sub {
  my $vaccination = getVaccination->new($db->{_dbs});

  return {Vaccination => $vaccination->{_vaccination}};
};

# To be updated
get '/getVaccinationSchedule' => sub {

  my $v_schedule = do('conf/vaccination.conf');

  return {
    VSchedule => $v_schedule
  };
};

post '/postVaccinationSchedule/:user' => sub {

  return {
    schedule => 'Schedule Updated'
  };
};

#
# Get the answers of the Question from the Application.
# Updated
#

post '/devscreening/:user/:familyid/:questionid/:response' => sub {

  ##################

    if (! $db->{params->{user}}->{login_session_key}) {

      return {
        ERROR_1104 => 'Invalid API Query as User is not logged in.'
      };
    }
  ##############

  my %login;
  $login{login_id} = $db->get_login_id(params->{user});

  if(!$login{login_id}) {
    return { ERROR_1105 => 'User Doesn\'t Exist.'};
  }

  # To make passing variable as hash reference :)
  my $login = \%login::;

  if (params->{response} != 1 or params->{response} != 0) {
    return {
      ERROR_INVALID_RESPONSE => 'Only 0 or 1 are Valid Value)'
     };
  }

  my $family = devScreening->new(
                       $db->{_dbs},
                       $login->{login_id}
                  );

  $family->set_familyid(params->{familyid});
  $family->set_questionid(params->{questionid});
  $family->set_response(params->{response});

  $family->set_status;

  my $status = $family->update_development_tracker;

  return {
    Message   => 'Response Updated',
    Screening => $family->{_user},
    Status    => $status
  };
};

#
# Get Dev Screening Results
#

get '/devscreening/details/:user/:familyid' => sub {
  ##################

    if (! $db->{params->{user}}->{login_session_key}) {

      return {
        ERROR_1104 => 'Invalid API Query as User is not logged in.'
      };
    }
  ##############

  my %login;
  $login{login_id} = $db->get_login_id(params->{user});

  if(!$login{login_id}) {
    return { ERROR_1105 => 'User Doesn\'t Exist.'};
  }

  # To make passing variable as hash reference :)
  my $login = \%login::;

  if (params->{response} != 1 or params->{response} != 0) {
    return {
      ERROR_INVALID_RESPONSE => 'Only 0 or 1 are Valid Value)'
     };
  }

  my $family = devScreening->new(
                       $db->{_dbs},
                       $login->{login_id}
                  );
  $family->get_screening_details;

  return {
    ScreeningDetails => $family->{_user}->{screening}
  };
};

post '/updatefamily/:answers' => sub {

};

# Catch Invalid REST API Call. If user calls invalid API, User will get the
# ERROR_404 Message.
any qr{.*} => sub {
  status 'not_found';
  return { ERROR_404 => 'Invalid API. !!!' };
};

true;
