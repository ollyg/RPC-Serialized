#
# $HeadURL: https://svn.oucs.ox.ac.uk/people/oliver/pub/librpc-serialized-perl/trunk/lib/RPC/Serialized/AuthzHandler.pm $
# $LastChangedRevision: 1281 $
# $LastChangedDate$
# $LastChangedBy: oliver $
#
package RPC::Serialized::AuthzHandler;

use strict;
use warnings FATAL => 'all';

sub new {
    my $class = shift;

    return bless {}, $class;
}

sub check_authz {
    my $self = shift;
    return 1;
}

1;

