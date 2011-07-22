use Dancer;

use File::Slurp;
use FindBin qw($Bin);
use lib "$Bin/../lib";

use PhantomJS;

my $phantom = PhantomJS->new;

# Route with placeholder
get '/api/screenshot' => sub {

    my $self = shift;
    my $url  = param 'url';
    my $key  = param 'key';

    my $tmp = $phantom->screenshot($url);

    if (-e $tmp && -s $tmp > 0) {

        send_file( $tmp, system_path => 1 );

    } else {

        send_error( "Server error", 501 );
    }
};

# Start the Mojolicious command system
dance;
