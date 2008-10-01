#
# $HeadURL: https://svn.oucs.ox.ac.uk/people/oliver/pub/librpc-serialized-perl/trunk/lib/RPC/Serialized/Client/NegKrb5.pm $
# $LastChangedRevision: 1308 $
# $LastChangedDate$
# $LastChangedBy: oliver $
#
package RPC::Serialized::Client::NegKrb5;

use strict;
use warnings FATAL => 'all';

use base 'RPC::Serialized::Client';

use IO::Socket::NegKrb5;
use RPC::Serialized::Config;
use RPC::Serialized::Exceptions;

sub new {
    my $class  = shift;
    my $params = RPC::Serialized::Config->parse(@_);

    my $socket = IO::Socket::NegKrb5->new($params->io_socket_negkrb5)
        or throw_system "Failed to create socket: $!";

    return $class->SUPER::new(
        $params, {rpc_serialized => {ifh => $socket, ofh => $socket}},
    );
}

1;

