#!/usr/bin/perl
#
# $HeadURL: https://svn.oucs.ox.ac.uk/people/oliver/pub/librpc-serialized-perl/trunk/t/35-rpc-serialized-client-negkrb5.t $
# $LastChangedRevision: 1281 $
# $LastChangedDate$
# $LastChangedBy: oliver $
#

use strict;
use warnings;

use Test::More tests => 1;

SKIP: {
    skip( "Cannot load IO::Socket::NegKrb5", 1 )
        unless eval { require IO::Socket::NegKrb5 };
    use_ok('RPC::Serialized::Client::NegKrb5');
}
