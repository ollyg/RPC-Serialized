#!/usr/bin/perl
#
# $HeadURL$
# $LastChangedRevision: 1281 $
# $LastChangedDate: 2007-07-02 17:09:10 +0100 (Mon, 02 Jul 2007) $
# $LastChangedBy: oliver $
#

use Test::More tests => 5;

use_ok('RPC::Serialized::Client::STDIO');

my $c = RPC::Serialized::Client::STDIO->new();
isa_ok( $c, 'RPC::Serialized::Client::STDIO' );
isa_ok( $c, 'RPC::Serialized::Client' );
is( $c->ifh->fileno, fileno(STDIN) );
is( $c->ofh->fileno, fileno(STDOUT) );
