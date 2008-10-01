#!/usr/bin/perl
#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/t/30-rpc-serialized-client.t $
# $LastChangedRevision: 1281 $
# $LastChangedDate: 2007-07-02 17:09:10 +0100 (Mon, 02 Jul 2007) $
# $LastChangedBy$
#

use strict;
use warnings;

use Test::More tests => 2;

use_ok('RPC::Serialized::Client');
can_ok( 'RPC::Serialized::Client', 'call' );
