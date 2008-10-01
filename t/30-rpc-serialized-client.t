#!/usr/bin/perl
#
# $HeadURL: https://svn.oucs.ox.ac.uk/people/oliver/pub/librpc-serialized-perl/trunk/t/30-rpc-serialized-client.t $
# $LastChangedRevision: 1281 $
# $LastChangedDate$
# $LastChangedBy: oliver $
#

use strict;
use warnings;

use Test::More tests => 2;

use_ok('RPC::Serialized::Client');
can_ok( 'RPC::Serialized::Client', 'call' );
