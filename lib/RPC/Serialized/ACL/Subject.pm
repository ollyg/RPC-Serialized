#
# $HeadURL: https://svn.oucs.ox.ac.uk/people/oliver/pub/librpc-serialized-perl/trunk/lib/RPC/Serialized/ACL/Subject.pm $
# $LastChangedRevision: 1281 $
# $LastChangedDate$
# $LastChangedBy: oliver $
#
package RPC::Serialized::ACL::Subject;

use strict;
use warnings FATAL => 'all';

use RPC::Serialized::Exceptions;

sub new {
    my $class = shift;
    my $name  = shift;

    throw_app 'Subject name not specified'
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
    my $self    = shift;
    my $subject = shift;

    return 1 if $self->name eq 'ALL';
    return (defined $subject and $subject eq $self->name);
}

1;

