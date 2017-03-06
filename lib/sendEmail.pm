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
    _pass => shift
  };

  bless $self, $class;

  return $self;
}

sub send_email {
  my $self = shift;

  my $email = Email::Simple::create(
    header => [
      To      => $self->{_to},
      From    => $self->{from},
      Subject => 'Account Verification Email From LinkinBridges.'
    ],
    body => _get_body_message(),
  );

  sendmail($email);
}

sub _get_body_message {
  my $message = "Click on the below link to verify your account.\n".
                 'http://localhost:5000/verification/'.$self->{_to}.'/'.
                 md5_base64($password).'/verifynow';
  return $message;
}
