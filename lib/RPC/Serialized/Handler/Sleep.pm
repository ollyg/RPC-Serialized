#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/lib/RPC/Serialized/Handler/Sleep.pm $
# $LastChangedRevision: 1322 $
# $LastChangedDate: 2007-07-08 22:45:12 +0100 (Sun, 08 Jul 2007) $
# $LastChangedBy: oliver $
#
package RPC::Serialized::Handler::Sleep;

use strict;
use warnings FATAL => 'all';

use base 'RPC::Serialized::Handler';

sub invoke {
    my $self = shift;
    my $seconds = shift;
    return [] if $seconds !~ m/^\d+$/;
    sleep $seconds;
    return [$seconds];
}

1;

