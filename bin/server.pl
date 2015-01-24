#!/usr/bin/env perl

use Dancer;

set server => '127.0.0.1';

use FindBin qw($Bin);
use lib "$Bin/../lib";

use PhantomJS;
use Time::Out qw(timeout);

my $phantom = PhantomJS->new;

# Route with placeholder
get '/api/screenshot' => sub {

    my $self = shift;
    my $url  = param 'url';
    my $key  = param 'key';

    my $meta;

    eval {

        timeout 30 => sub { $meta = $phantom->screenshot($url) };

    };

    print STDERR $@ if $@;

    if ($meta) {

        header('Content-Type' => 'application/json; charset=utf8');
        return to_json($meta,{utf8 => 1, pretty => 1});

    } else {

        send_error( "Server error", 501 );
    }
};

# Start the Dancer command system
dance;
