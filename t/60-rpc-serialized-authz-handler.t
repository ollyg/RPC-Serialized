#!/usr/bin/perl
#
# $HeadURL$
# $LastChangedRevision: 1281 $
# $LastChangedDate: 2007-07-02 17:09:10 +0100 (Mon, 02 Jul 2007) $
# $LastChangedBy: oliver $
#

use strict;
use warnings FATAL => 'all';

use Test::More tests => 6;

use_ok('RPC::Serialized::AuthzHandler');
can_ok( 'RPC::Serialized::AuthzHandler', 'new' );
can_ok( 'RPC::Serialized::AuthzHandler', 'check_authz' );

my $ah = RPC::Serialized::AuthzHandler->new();
isa_ok( $ah, 'RPC::Serialized::AuthzHandler' );
ok( $ah->check_authz() );
ok( $ah->check_authz( 'foo', 'create', 'bar' ) );
