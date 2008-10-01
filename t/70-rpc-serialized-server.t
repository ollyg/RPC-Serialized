#!/usr/bin/perl
#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/t/70-rpc-serialized-server.t $
# $LastChangedRevision: 1297 $
# $LastChangedDate: 2007-07-03 20:23:20 +0100 (Tue, 03 Jul 2007) $
# $LastChangedBy: oliver $
#

use strict;
use warnings;

use Test::More tests => 13;

use_ok('RPC::Serialized::Server');
can_ok( 'RPC::Serialized::Server', 'new' );
can_ok( 'RPC::Serialized::Server', 'log' );
can_ok( 'RPC::Serialized::Server', 'log_call' );
can_ok( 'RPC::Serialized::Server', 'log_response' );
can_ok( 'RPC::Serialized::Server', 'handler' );
can_ok( 'RPC::Serialized::Server', 'authz_handler' );
can_ok( 'RPC::Serialized::Server', 'recv' );
can_ok( 'RPC::Serialized::Server', 'subject' );
can_ok( 'RPC::Serialized::Server', 'authorize' );
can_ok( 'RPC::Serialized::Server', 'dispatch' );
can_ok( 'RPC::Serialized::Server', 'exception' );
can_ok( 'RPC::Serialized::Server', 'process' );
