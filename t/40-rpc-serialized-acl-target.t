#!/usr/bin/perl
#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/t/40-rpc-serialized-acl-target.t $
# $LastChangedRevision: 1323 $
# $LastChangedDate: 2007-07-09 17:10:19 +0100 (Mon, 09 Jul 2007) $
# $LastChangedBy: oliver $
#

use strict;
use warnings FATAL => 'all';

use Test::More tests => 16;

use_ok('RPC::Serialized::ACL::Target');
can_ok( 'RPC::Serialized::ACL::Target', 'new' );
can_ok( 'RPC::Serialized::ACL::Target', 'name' );
can_ok( 'RPC::Serialized::ACL::Target', 'match' );

eval { RPC::Serialized::ACL::Target->new() };
isa_ok( $@, 'RPC::Serialized::X::Application' );
is( $@->message, 'Target name not specified' );

my $tgt = RPC::Serialized::ACL::Target->new('ALL');
isa_ok( $tgt, 'RPC::Serialized::ACL::Target' );
is( $tgt->name(), 'ALL' );
ok( $tgt->match() );
ok( $tgt->match('foo') );

$tgt = RPC::Serialized::ACL::Target->new('foo');
isa_ok( $tgt, 'RPC::Serialized::ACL::Target' );
is( $tgt->name, 'foo' );
ok( $tgt->match('foo') );
ok( not $tgt->match('bar') );
ok( not $tgt->match('food') );
ok( not $tgt->match() );
