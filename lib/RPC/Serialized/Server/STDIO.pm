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

# ABSTRACT: Run a simple RPC server on STDIN and STDOUT

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

=head1 THANKS

This module is a derivative of C<YAML::RPC>, written by C<pod> and Ray Miller,
at the University of Oxford Computing Services. Without their brilliant
creation this system would not exist.

=cut
