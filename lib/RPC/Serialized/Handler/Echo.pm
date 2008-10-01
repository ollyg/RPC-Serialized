#
# $HeadURL: https://svn.oucs.ox.ac.uk/people/oliver/pub/librpc-serialized-perl/trunk/lib/RPC/Serialized/Handler/Echo.pm $
# $LastChangedRevision: 1281 $
# $LastChangedDate$
# $LastChangedBy: oliver $
#
package RPC::Serialized::Handler::Echo;

use strict;
use warnings FATAL => 'all';

use base 'RPC::Serialized::Handler';

sub invoke {
    my $self = shift;
    return [@_];
}

1;

