package MyHealthLogger;

use strict;
use warnings;

use Log::Log4perl;

our @EXPORT_OK = qw<$log>;
use parent qw<Exporter>;

my $conf = 'conf/log.conf';

Log::Log4perl::init($conf);

our $log = Log::Log4perl->get_logger();

$log->info('#######################');
$log->info('MyHealth Web Services Started.');
$log->info("Logging Start For Session.");

1;

__END__

Package MyHealthLogger is to initiate the logging for MyHealth Application.

$log variable is declared as our instead of my in order make it available across
all the modules.
