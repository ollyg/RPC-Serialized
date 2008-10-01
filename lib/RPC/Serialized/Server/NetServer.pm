#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/lib/RPC/Serialized/Server/NetServer.pm $
# $LastChangedRevision: 1337 $
# $LastChangedDate: 2007-07-11 15:17:56 +0100 (Wed, 11 Jul 2007) $
# $LastChangedBy: oliver $
#
package RPC::Serialized::Server::NetServer;

use strict;
use warnings FATAL => 'all';

use base 'Net::Server::PreFork';
use base 'Class::Accessor::Fast::Contained';

use IO::Handle;
use RPC::Serialized::Server;
use RPC::Serialized::Config;

__PACKAGE__->mk_accessors(qw/params rs/);

sub new {
    my $class = shift;
    my $params = RPC::Serialized::Config->parse(@_);

    my $self = $class->SUPER::new( $params->net_server );
    $self->params(scalar $params);

    return $self;
}

sub default_values {
    return $_[0]->params->net_server;
}

sub child_init_hook {
    my $self = shift;

    $self->rs( RPC::Serialized::Server->new($self->params) );

    return $self;
}

sub post_accept_hook {
    my $self = shift;

    $self->rs->ifh( IO::Handle->new_from_fd( STDIN->fileno, "r" ) );
    $self->rs->ofh( IO::Handle->new_from_fd( STDOUT->fileno, "w" ) );
    $self->rs->ofh->autoflush(1);

    return $self;
}

sub process_request {
    my $self = shift;

    return $self->rs->process;
}

1;

__END__

=head1 NAME

RPC::Serialized::Server::NetServer - Run an RPC server using Net::Server

=head1 SYNOPSIS

 use RPC::Serialized::Server::NetServer;
 
 my $s = RPC::Serialized::Server::NetServer->new({
     net_server => { port => 1234 },
 });
 
 # note that $s isa Net::Server::PreFork, not an RPC::Serialized

 s->run;
     # server process is now looping and waiting for RPC (like Apache prefork)
     # the default port number for Net::Server is 20203
 
 
 # alternatively, if you have an external configuration file which
 # Config::Any can load, try the following:
 
 $s = RPC::Serialized::Server::NetServer->new('/path/to/config/file');
 
 # you can also combine config file and hash reference arguments

=head1 DESCRIPTION

This module provides a bridge between L<RPC::Serialized> and L<Net::Server>,
meaning you can easily run an RPC server without installing any additional
daemonizing tools onto your system. The module sets up a basic PreFork server,
which runs much like Apache in PreFork mode, and you can override any of the
default configuration to C<Net::Server>.

It is strongly recommended that you at least once read through the
L<Net::Server> manual page and the L<Net::Server::PreFork> manual page, to
familiarize yourself with the configuration options. You do not need to worry
much about the client connection processing or hooks, because that is dealt
with inside of this module.

=head1 CONFIGURATION

Most of the defaults for C<Net::Server> have been left alone, because they are
reasonably sane and easy to override using the syntax shown in L</SYOPSIS>,
above. Here are the non-standard settings:

=over 4

=item C<log_level> is set to C<4>

This means you get a little more detail from the parent C<Net::Server> process
about its child handlers, for instance when they are started.

=item C<syslog_facility> is set to C<local1>

This is merely so that logging messages from this application are available
separately to your other standard system logs. Most good Syslog daemons (e.g.
C<syslog-ng> can flexibly handle each facility.

=back

=head2 Things you might want to configure

By default the server will remain in the foregrount, and not fork or detach
from its parent process to become a daemon. Check the C<background> and
C<setsid> options if you would like a proper background daemon running.

The logging output will go to STDERR, so to change this set the C<log_file>
option. The C<Net::Server> manual page describes the values available.

For performance tweaking, you might want to alter some of the
C<Net::Server::PreFork> settings. Again, see the manual page for that module
for further details.

=head1 RUNNING THE SERVER

Once you have instantiated a new server object using C<new()>, there is just
one method call to make to begin the processing loop:

 $s->run;

This will fork the child handlers, and begin running as a server. Note that
this is a method on the C<Net::Server> object and not C<RPC::Serialized>; it
wraps the C<process()> call normally issued to that module in other servers.

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

