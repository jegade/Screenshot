
package PhantomJS;

use strict;
use warnings;
use FindBin;
use File::Temp qw/tempfile/;
use Parallel::Jobs;

my $xvfb    = "/usr/bin/Xvfb";
my $phantom = "$FindBin::Bin/../phantomjs/bin/phantomjs";
my $script  = "$FindBin::Bin/../scripts/screenshot.js";

=head2 new

    Start xvfb process

=cut

sub new {

    my $display = $$;
    $ENV{DISPLAY} = ":" . $display;

    my $width    = 1024;
    my $height   = 768;
    my $color    = 24;
    my $xvfb_pid = Parallel::Jobs::start_job( $xvfb, ":" . $display, "-nolisten", "tcp", "-screen", 0, $width . "x" . $height . "x" . $color );

    return bless {};
}

=head2 screenshot

    Start screenshot

=cut

sub screenshot {

    my ( $self, $url ) = @_;
    my $format = 'png';
    my ( $fh, $tmp ) = tempfile( "screenshot_XXXXXXXX", TMPDIR => 1, SUFFIX => "." . $format );
    system $phantom, $script, $url, $tmp;
    return $tmp;
}

