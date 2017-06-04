package sendEmail;

use strict;
use Email::Sender::Simple qw(sendmail);
use Email::Simple;
use Email::Simple::Creator;
use Digest::MD5 qw(md5_base64);

#
# Just to Send Account Verification Email.
# Nothing Serious in this Package.
# (^ ^)
#  (-)
#

sub new {
  my $class = shift;

  my $self = {
    _to   => shift,
    _from => shift,
  };

  bless $self, $class;

  return $self;
}

sub send_email {
  my $self = shift;

  my $email = Email::Simple->create(
    header => [
      To      => $self->{_to},
      From    => $self->{_from},
      Subject => 'Account Verification Email From LinkinBridges.'
    ],
    body => _get_body_message(),
  );

  sendmail($email);
}

sub _get_body_message {
  my $self = shift;

  my $password;
  my $message = "Click on the below link to verify your account.\n".
                 'http://localhost:5000/verification/'.$self->{_to}.'/'.
                 md5_base64($password).'/verifynow';
  return $message;
}

sub send_reset_password {
  my $self = shift;

  my $code = 1000 + int (rand(9999 - 1000));

  my $email = Email::Simple->create(
    header => [
      To      => $self->{_to},
      From    => $self->{_from},
      Subject => 'Password Reset Verification Code.'
    ],
    body => 'Hi User,

    Your Verification Code To Reset Password is : '. $code.
    '

    Regards,
    Team Linkin Bridges

    NOTE: Please do not reply to this email',
  );

  sendmail($email);

  return $code;
}

1;
