#
# $HeadURL: https://svn.oucs.ox.ac.uk/people/oliver/pub/librpc-serialized-perl/trunk/lib/RPC/Serialized/ACL/Target.pm $
# $LastChangedRevision: 1281 $
# $LastChangedDate$
# $LastChangedBy: oliver $
#
package RPC::Serialized::ACL::Target;

use strict;
use warnings FATAL => 'all';

use RPC::Serialized::Exceptions;

sub new {
    my $class = shift;
    my $name  = shift;

    throw_app 'Target name not specified'
        unless defined $name;

    return bless {
        NAME => $name,
    }, $class;
}

sub name {
    my $self = shift;
    return $self->{NAME};
}

sub match {
    my $self   = shift;
    my $target = shift;

    return 1 if $self->name eq 'ALL';
    return (defined $target and $target eq $self->name);
}

1;

