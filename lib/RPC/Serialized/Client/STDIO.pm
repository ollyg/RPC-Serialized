#
# $HeadURL: https://svn.oucs.ox.ac.uk/people/oliver/pub/librpc-serialized-perl/trunk/lib/RPC/Serialized/Client/STDIO.pm $
# $LastChangedRevision: 1326 $
# $LastChangedDate: 2008-10-01 16:16:56 +0100 (Wed, 01 Oct 2008) $
# $LastChangedBy: oliver $
#
package RPC::Serialized::Client::STDIO;

use strict;
use warnings FATAL => 'all';

use base 'RPC::Serialized::Client';

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

RPC::Serialized::Client::STDIO - RPC client using Standard I/O

=head1 SYNOPSIS

 use RPC::Serialized::Client::STDIO;
  
 my $c = RPC::Serialized::Client::STDIO->new;
  
 my $result = $c->remote_sub_name(qw/ some data /);
     # remote_sub_name gets mapped to an invocation on the RPC server
     # it's best to wrap this in an eval{} block

=head1 DESCRIPTION

This module allows you to communicate with an L<RPC::Serialized> server over
Standard Input and Standard Output.

You would not normally use this module directly, except perhaps for testing.
It might be more useful as a base class upon which to build another more
useful client.

For further information on how to pass settings into C<RPC::Serialized>, and
make RPC calls against the server, please see the L<RPC::Serialized> manual
page.

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

