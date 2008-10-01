#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/lib/RPC/Serialized/Handler/Localtime.pm $
# $LastChangedRevision: 1281 $
# $LastChangedDate: 2007-07-02 17:09:10 +0100 (Mon, 02 Jul 2007) $
# $LastChangedBy: oliver $
#
package RPC::Serialized::Handler::Localtime;

use strict;
use warnings FATAL => 'all';

use base 'RPC::Serialized::Handler';

sub invoke {
    my $self = shift;
    my $time = shift;

    $time = time unless defined $time;
    return scalar localtime($time);
}

1;

