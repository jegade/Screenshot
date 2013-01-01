
package PhantomJS;

use strict;
use warnings;
use FindBin;
use File::Temp qw/tempfile/;

my $phantom = "$FindBin::Bin/phantomjs";
my $script  = "$FindBin::Bin/../scripts/screenshot.js";

=head2 new

    Start xvfb process

=cut

sub new {

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

