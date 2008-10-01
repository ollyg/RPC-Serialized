#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/lib/RPC/Serialized/Client.pm $
# $LastChangedRevision: 1323 $
# $LastChangedDate: 2007-07-09 17:10:19 +0100 (Mon, 09 Jul 2007) $
# $LastChangedBy: oliver $
#
package RPC::Serialized::Client;

use strict;
use warnings FATAL => 'all';

use base 'RPC::Serialized';

use RPC::Serialized::Exceptions;

our $AUTOLOAD;

sub call {
    my $self = shift;
    my $call = shift;

    # this is where we would hack around with the RPC protocol
    # although not the on-the-wire stuff, which is in Serialized.pm
    $self->send( { CALL => $call, ARGS => \@_ } );
    my $reply = $self->recv;

    if ( $reply->{EXCEPTION} ) {
        my $class = $reply->{EXCEPTION}->{CLASS};

        throw_proto 'Invalid or missing CLASS'
            unless $class and $class =~ /^RPC::Serialized::X(::.+)?$/;

        my $message = $reply->{EXCEPTION}->{MESSAGE} || "";
        $class->throw($message);
    }

    return $reply->{RESPONSE};
}

sub AUTOLOAD {
    my $self = shift;

    throw_app 'Object method called on class'
        unless ref($self);

    ( my $call = $AUTOLOAD ) =~ s/^.*:://;
    $self->call( $call, @_ );
}

1;

