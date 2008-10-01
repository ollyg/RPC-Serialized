#!/usr/bin/perl
#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/examples/client.pl $
# $LastChangedRevision: 1330 $
# $LastChangedDate: 2007-07-10 22:02:16 +0100 (Tue, 10 Jul 2007) $
# $LastChangedBy: oliver $
#

use strict;
use warnings FATAL => 'all';

use Readonly;
use RPC::Serialized::Client::UNIX;

Readonly my $SOCKET => '/var/run/rpc-serialized-example-server.socket';

my $c = RPC::Serialized::Client::UNIX->new($SOCKET);

eval {
    my $res = $c->echo(qw(a b c d));
    print "echo: " . join( ":", @$res ) . "\n";
};
warn "$@\n" if $@;

eval {
    my $now = $c->localtime;
    print "Localtime: $now\n";
};
warn "$@\n" if $@;
