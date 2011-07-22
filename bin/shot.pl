
use FindBin;
use File::Temp qw/tempfile/;
use Parallel::Jobs;

my $xvfb    = "/usr/bin/Xvfb";
my $phantom = "$FindBin::Bin/../phantomjs/bin/phantomjs";
my $script  = "$FindBin::Bin/../scripts/screenshot.js";

my $display = $$;

my $url = shift;

warn $url;

my $width  = 1024;
my $height = 768;
my $color  = 24;
my $format = 'png';

my ( $fh, $tmp ) = tempfile( "screenshot_XXXXXXXX", TMPDIR => 1, SUFFIX => "." . $format );

my $xvfb_pid = Parallel::Jobs::start_job(   $xvfb, ":" . $display, "-screen", 0, $width . "x"  . $height . "x"  . $color );

$ENV{DISPLAY} = ":".$display;

system $phantom,$script, $url, $tmp;

kill 9, $xvfb_pid;

print $tmp;
