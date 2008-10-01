#!/usr/bin/perl
#
# $HeadURL: https://svn.oucs.ox.ac.uk/people/oliver/pub/librpc-serialized-perl/trunk/t/35-rpc-serialized-client-stdio.t $
# $LastChangedRevision: 1281 $
# $LastChangedDate$
# $LastChangedBy: oliver $
#

use Test::More tests => 5;

use_ok('RPC::Serialized::Client::STDIO');

my $c = RPC::Serialized::Client::STDIO->new();
isa_ok( $c, 'RPC::Serialized::Client::STDIO' );
isa_ok( $c, 'RPC::Serialized::Client' );
is( $c->ifh->fileno, fileno(STDIN) );
is( $c->ofh->fileno, fileno(STDOUT) );
