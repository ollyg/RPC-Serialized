#!/usr/bin/perl
#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/t/90-rpc-serialized-client-server.t $
# $LastChangedRevision: 1359 $
# $LastChangedDate: 2007-07-23 21:12:25 +0100 (Mon, 23 Jul 2007) $
# $LastChangedBy: oliver $
#

use strict;
use warnings;

use Test::More tests => 11;

use IO::Pipe;

use_ok('RPC::Serialized::Server');
use_ok('RPC::Serialized::Client');

my $server_in  = IO::Pipe->new() or die "Failed to create input pipe: $!";
my $server_out = IO::Pipe->new() or die "Failed to create output pipe: $!";

my $pid = fork();
defined $pid or die "Fork failed: $!";
if ( $pid == 0 ) {    # child
    $server_in->reader();
    $server_out->writer();
    my $s = RPC::Serialized::Server->new({
        rpc_serialized => {ifh => $server_in, ofh => $server_out},
    });
    $s->handler( 'echo', 'RPC::Serialized::Handler::Echo' );
    $s->process();
    exit 0;
}

# Block introduced to test that server sees eof and terminates process() loop
# when client goes out of scope
{
    $server_in->writer();
    $server_out->reader();
    my $c = RPC::Serialized::Client->new({
        rpc_serialized => {ifh => $server_out, ofh => $server_in}
    });
    isa_ok( $c, 'RPC::Serialized::Client' );
    my @args = qw(a b c d);
    my $res = eval { $c->echo(@args) };
    ok( ! $@, "Died in rpc call: $@" );
    ok( eq_array( $res, \@args ) );
    @args = ( 1, 2, 3, 4, 'a', 'b', 'c', 'd' );
    $res = eval { $c->echo(@args) };
    ok( ! $@ );
    ok( eq_array( $res, \@args ) );
    eval { $c->foo( 1, 2, 3 ) };
    isa_ok( $@, 'RPC::Serialized::X::Application' );
    is( $@->message, 'No handler for foo' );
}

is( waitpid( $pid, 0 ), $pid );
is( $?, 0 );
