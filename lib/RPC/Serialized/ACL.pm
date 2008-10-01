#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/lib/RPC/Serialized/ACL.pm $
# $LastChangedRevision: 1281 $
# $LastChangedDate: 2007-07-02 17:09:10 +0100 (Mon, 02 Jul 2007) $
# $LastChangedBy: oliver $
#
package RPC::Serialized::ACL;

use strict;
use warnings FATAL => 'all';

use RPC::Serialized::ACL::Operation;
use RPC::Serialized::ACL::Subject;
use RPC::Serialized::ACL::Target;

use constant DECLINE => 0;
use constant DENY    => 1;
use constant ALLOW   => 2;

sub new {
    my $class = shift;
    my %args  = @_;
    my $self;

    if ( defined $args{operation} and ref $args{operation} ) {
        $self->{OPERATION} = $args{operation};
    }
    else {
        $self->{OPERATION}
            = RPC::Serialized::ACL::Operation->new( $args{operation} );
    }
    if ( defined $args{subject} and ref $args{subject} ) {
        $self->{SUBJECT} = $args{subject};
    }
    else {
        $self->{SUBJECT} = RPC::Serialized::ACL::Subject->new( $args{subject} );
    }
    if ( defined $args{target} and ref $args{target} ) {
        $self->{TARGET} = $args{target};
    }
    else {
        $self->{TARGET} = RPC::Serialized::ACL::Target->new( $args{target} );
    }
    if ( defined $args{action} and $args{action} eq 'allow' ) {
        $self->{ACTION} = ALLOW;
    }
    else {
        $self->{ACTION} = DENY;
    }

    return bless $self, $class;
}

sub operation {
    my $self = shift;
    $self->{OPERATION};
}

sub subject {
    my $self = shift;
    $self->{SUBJECT};
}

sub target {
    my $self = shift;
    $self->{TARGET};
}

sub action {
    my $self = shift;
    $self->{ACTION};
}

sub check {
    my $self = shift;
    my ( $subject, $operation, $target ) = @_;

    return DECLINE
        unless $self->operation->match($operation)
        and $self->subject->match($subject)
        and $self->target->match($target);

    return $self->action();
}

1;

