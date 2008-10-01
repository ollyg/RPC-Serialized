#!/usr/bin/perl
#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/t/40-rpc-serialized-acl-subject.t $
# $LastChangedRevision: 1323 $
# $LastChangedDate: 2007-07-09 17:10:19 +0100 (Mon, 09 Jul 2007) $
# $LastChangedBy: oliver $
#

use strict;
use warnings FATAL => 'all';

use Test::More tests => 16;

use_ok('RPC::Serialized::ACL::Subject');
can_ok( 'RPC::Serialized::ACL::Subject', 'new' );
can_ok( 'RPC::Serialized::ACL::Subject', 'name' );
can_ok( 'RPC::Serialized::ACL::Subject', 'match' );

eval { RPC::Serialized::ACL::Subject->new() };
isa_ok( $@, 'RPC::Serialized::X::Application' );
is( $@->message, 'Subject name not specified' );

my $subj = RPC::Serialized::ACL::Subject->new('ALL');
isa_ok( $subj, 'RPC::Serialized::ACL::Subject' );
is( $subj->name(), 'ALL' );
ok( $subj->match() );
ok( $subj->match('foo') );

$subj = RPC::Serialized::ACL::Subject->new('foo');
isa_ok( $subj, 'RPC::Serialized::ACL::Subject' );
is( $subj->name, 'foo' );
ok( $subj->match('foo') );
ok( not $subj->match('bar') );
ok( not $subj->match('food') );
ok( not $subj->match() );
