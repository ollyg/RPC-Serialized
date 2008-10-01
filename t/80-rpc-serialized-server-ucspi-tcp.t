#!/usr/bin/perl
#
# $HeadURL: https://svn.oucs.ox.ac.uk/people/oliver/pub/librpc-serialized-perl/trunk/t/80-rpc-serialized-server-ucspi-tcp.t $
# $LastChangedRevision: 1281 $
# $LastChangedDate$
# $LastChangedBy: oliver $
#

use strict;
use warnings;

use Test::More tests => 1;

use_ok('RPC::Serialized::Server::UCSPI::TCP');
