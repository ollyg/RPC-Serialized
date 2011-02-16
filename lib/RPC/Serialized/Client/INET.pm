package RPC::Serialized::Client::INET;

use strict;
use warnings FATAL => 'all';

use base 'RPC::Serialized::Client';

use IO::Socket::INET;
use RPC::Serialized::Config;
use RPC::Serialized::Exceptions;

sub new {
    my $class = shift;
    my $params = RPC::Serialized::Config->parse(@_);

    my $socket = IO::Socket::INET->new($params->io_socket_inet)
        or throw_system "Failed to create socket: $!";

    return $class->SUPER::new(
        $params, {rpc_serialized => {ifh => $socket, ofh => $socket}},
    );
}

1;

# ABSTRACT: IPv4 socket RPC client

=head1 SYNOPSIS

 use RPC::Serialized::Client::INET;
  
 my $c = RPC::Serialized::Client::INET->new({
     io_socket_inet => {PeerPort => 20203},
 });
  
 my $result = $c->remote_sub_name(qw/ some data /);
     # remote_sub_name gets mapped to an invocation on the RPC server
     # it's best to wrap this in an eval{} block

=head1 DESCRIPTION

This module allows you to communicate with an L<RPC::Serialized> server over
IPv4 Internet Domain sockets.

What you need to know is that the options to this module are those you would
normally pass to an instance of L<IO::Socket::INET>, so check out the manual
page for that to see what features are available. As in the L</SYNOPSIS>
example above, pass the options in a hash reference mapped to the key
C<io_socket_inet>.

For further information on how to pass these settings into C<RPC::Serialized>,
and make RPC calls against the server, please see the L<RPC::Serialized>
manual page.

=head1 THANKS

This module is a derivative of C<YAML::RPC>, written by C<pod> and Ray Miller,
at the University of Oxford Computing Services. Without their brilliant
creation this system would not exist.

=cut
