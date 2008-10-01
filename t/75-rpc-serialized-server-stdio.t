#!/usr/bin/perl
#
# $HeadURL$
# $LastChangedRevision: 1281 $
# $LastChangedDate: 2007-07-02 17:09:10 +0100 (Mon, 02 Jul 2007) $
# $LastChangedBy: oliver $
#

use Test::More tests => 6;

use_ok('RPC::Serialized::Server::STDIO');

my $s = RPC::Serialized::Server::STDIO->new();
isa_ok( $s, 'RPC::Serialized::Server::STDIO' );
isa_ok( $s, 'RPC::Serialized::Server' );
isa_ok( $s, 'RPC::Serialized' );
is( $s->ifh->fileno, fileno(STDIN) );
is( $s->ofh->fileno, fileno(STDOUT) );
