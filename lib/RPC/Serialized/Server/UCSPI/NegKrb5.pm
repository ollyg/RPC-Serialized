#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/lib/RPC/Serialized/Server/UCSPI/NegKrb5.pm $
# $LastChangedRevision: 1321 $
# $LastChangedDate: 2007-07-08 22:39:39 +0100 (Sun, 08 Jul 2007) $
# $LastChangedBy: oliver $
#
package RPC::Serialized::Server::UCSPI::NegKrb5;

use strict;
use warnings FATAL => 'all';

use base 'RPC::Serialized::Server::UCSPI';

use RPC::Serialized::Exceptions;

sub new {
    my $class  = shift;
    my $params = RPC::Serialized::Config->parse(@_);

    my $self = $class->SUPER::new($params);
    $self->{KRB5_REALM} = $params->me->{krb5_realm};

    return $self;
}

# FIXME should be an accessor?
sub krb5_realm {
    my $self = shift;
    if (@_) {
        $self->{KRB5_REALM} = shift;
    }
    return $self->{KRB5_REALM};
}

sub subject {
    my $self   = shift;

    my $rprinc = $ENV{NEGKRB5REMOTEPRINC}
        or throw_authz 'NEGKRB5REMOTEPRINC not set';

    my $realm = $self->{KRB5_REALM};
    ( my $subject = $rprinc ) =~ s/\@\Q$realm\E$//
        or throw_authz "Realm for principal $rprinc not recognized";

    return $subject;
}

1;

