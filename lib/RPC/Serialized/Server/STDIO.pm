#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/lib/RPC/Serialized/Server/STDIO.pm $
# $LastChangedRevision: 1326 $
# $LastChangedDate: 2007-07-10 21:41:52 +0100 (Tue, 10 Jul 2007) $
# $LastChangedBy: oliver $
#
package RPC::Serialized::Server::STDIO;

use strict;
use warnings FATAL => 'all';

use base 'RPC::Serialized::Server';

use IO::Handle;

sub new {
    my $class = shift;

    my $ifh = IO::Handle->new_from_fd( STDIN->fileno, "r" );
    my $ofh = IO::Handle->new_from_fd( STDOUT->fileno, "w" );

    $ofh->autoflush(1);

    return $class->SUPER::new(
        @_, {rpc_serialized => {ifh => $ifh, ofh => $ofh}},
    );
}

1;

__END__

=head1 NAME

RPC::Serialized::Server::STDIO - Run a simple RPC server on STDIN and STDOUT

=head1 SYNOPSIS

 use RPC::Serialized::Server::STDIO;
 
 # set up the new server
 my $s = RPC::Serialized::Server::STDIO->new;
 
 # begin a single-process loop handling requests on STDIN and STDOUT
 $s->process;

=head1 DESCRIPTION

This module provides a very simple way to run an RPC server. It uses the STDIN
and STDOUT filehandles to read and write RPC calls and responses.

One use for this module is for testing; you can run a simple server as shown
in the L</SYNOPSIS> above, and test handlers by just typing CALLs into STDIN.

The more common use is that this modules serves as a base class from which to
derive a more useful interface. The various C<UCSPI> server modules do this.

There is no additional server configuration necessary, although you can of
course supply arguments to C<new()> as described in the L<RPC::Serialized>
manual page.

To start the server, issue the following command:

 $s->process;

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

