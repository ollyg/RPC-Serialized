#
# $HeadURL: https://svn.oucs.ox.ac.uk/people/oliver/pub/librpc-serialized-perl/trunk/lib/RPC/Serialized/Server/UCSPI/TCP.pm $
# $LastChangedRevision: 1326 $
# $LastChangedDate: 2008-10-01 16:16:56 +0100 (Wed, 01 Oct 2008) $
# $LastChangedBy: oliver $
#
package RPC::Serialized::Server::UCSPI::TCP;

use strict;
use warnings FATAL => 'all';

use base 'RPC::Serialized::Server::UCSPI';

use RPC::Serialized::Exceptions;

sub subject {
    my $self = shift;

    my $remote = $ENV{TCPREMOTEINFO}
        or throw_authz 'TCPREMOTEINFO not set';

    return $remote;
}

1;

__END__

=head1 NAME

RPC::Serialized::Server::UCSPI::TCP - RPC server managed by DJB's ucspi-tpc

=head1 SYNOPSIS

 use RPC::Serialized::Server::UCSPI::TCP;
 
 # set up the new server
 my $s = RPC::Serialized::Server::UCSPI::TCP->new;
 
 # begin a single-process loop handling requests on STDIN and STDOUT
 $s->process;

=head1 DESCRIPTION

This module provides an extension to L<RPC::Serialized> which enhances support
for Dan Bernstein's C<ucspi-tcp> network services system.

In C<ucspi>-land, servers communicate using Standard Input and Standard
Output, so things are very simple. His services system takes care of setting
up a listening network socket, and forking off child handlers. Those child
handlers are simple setup scripts just like that shown in the L</SYNOPSIS>
above.

Within the C<examples> directory of this distribution, there is an example
C<tcpserver> startup script which uses this module.

There is no additional server configuration necessary, although you can of
course supply arguments to C<new()> as described in the L<RPC::Serialized>
manual page.

This module provides support for using the C<TCPREMOTEINFO> environment
variable in the call authorization phase of C<RPC::Serialized>. Although not
well documented, this is fully working and there are example scripts in this
distribution.

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

