#!/usr/bin/perl
#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/t/40-rpc-serialized-acl-operation.t $
# $LastChangedRevision: 1323 $
# $LastChangedDate: 2007-07-09 17:10:19 +0100 (Mon, 09 Jul 2007) $
# $LastChangedBy: oliver $
#

use strict;
use warnings FATAL => 'all';

use Test::More tests => 16;

use_ok('RPC::Serialized::ACL::Operation');
can_ok( 'RPC::Serialized::ACL::Operation', 'new' );
can_ok( 'RPC::Serialized::ACL::Operation', 'name' );
can_ok( 'RPC::Serialized::ACL::Operation', 'match' );

eval { RPC::Serialized::ACL::Operation->new() };
isa_ok( $@, 'RPC::Serialized::X::Application' );
is( $@->message, 'Operation name not specified' );

my $op = RPC::Serialized::ACL::Operation->new('ALL');
isa_ok( $op, 'RPC::Serialized::ACL::Operation' );
is( $op->name(), 'ALL' );
ok( $op->match() );
ok( $op->match('foo') );

$op = RPC::Serialized::ACL::Operation->new('foo');
isa_ok( $op, 'RPC::Serialized::ACL::Operation' );
is( $op->name, 'foo' );
ok( $op->match('foo') );
ok( not $op->match('bar') );
ok( not $op->match('food') );
ok( not $op->match() );
