#
# $HeadURL: https://svn.oucs.ox.ac.uk/people/oliver/pub/librpc-serialized-perl/trunk/lib/RPC/Serialized/Handler.pm $
# $LastChangedRevision: 1326 $
# $LastChangedDate$
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

