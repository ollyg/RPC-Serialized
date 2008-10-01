#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/lib/RPC/Serialized/Handler.pm $
# $LastChangedRevision: 1326 $
# $LastChangedDate: 2007-07-10 21:41:52 +0100 (Tue, 10 Jul 2007) $
# $LastChangedBy: oliver $
#
package RPC::Serialized::Handler;

use strict;
use warnings FATAL => 'all';

sub invoke {
    my $self = shift;
    return;
}

sub target {
    my $self = shift;
    return undef;
}

1;

