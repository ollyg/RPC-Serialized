#
# $HeadURL: https://svn.oucs.ox.ac.uk/people/oliver/pub/librpc-serialized-perl/trunk/lib/RPC/Serialized/Client/INET.pm $
# $LastChangedRevision: 1326 $
# $LastChangedDate$
# $LastChangedBy: oliver $
#
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

__END__

=head1 NAME

RPC::Serialized::Client::INET - IPv4 socket RPC client

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

=head1 AUTHOR

Oliver Gorwits C<< <oliver.gorwits@oucs.ox.ac.uk> >>

This module is a derivative of C<YAML::RPC>, written by C<pod> and Ray Miller,
at the University of Oxford Computing Services. Without their brilliant
creation this system would not exist.

=head1 COPYRIGHT & LICENSE

Copyright (c) The University of Oxford 2007. All Rights Reserved.

This program is free software; you can redistribute it and/or modify it under
the terms of version 2 of the GNU General Public License as published by the
Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
St, Fifth Floor, Boston, MA 02110-1301 USA

=cut

