#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/lib/RPC/Serialized/AuthzHandler.pm $
# $LastChangedRevision: 1281 $
# $LastChangedDate: 2007-07-02 17:09:10 +0100 (Mon, 02 Jul 2007) $
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

