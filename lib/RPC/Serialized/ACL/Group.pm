#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/lib/RPC/Serialized/ACL/Group.pm $
# $LastChangedRevision: 1326 $
# $LastChangedDate: 2007-07-10 21:41:52 +0100 (Tue, 10 Jul 2007) $
# $LastChangedBy: oliver $
#
package RPC::Serialized::ACL::Group;

use strict;
use warnings FATAL => 'all';

use URI;
use Readonly;
use RPC::Serialized::Exceptions;

Readonly my %schemes => (
    'file' => sub {
        my $uri = shift;

        return 'RPC::Serialized::ACL::Group::GDBM_File'
            if $uri->file =~ /\.gdbm$/;

        return 'RPC::Serialized::ACL::Group::File';
    }
);

sub new {
    my $proto = shift;
    my $str   = shift
        or throw_app 'URI not specified';

    my $uri = URI->new($str)
        or throw_app "Failed to parse URI '$str'";

    my $scheme = $uri->scheme
        or throw_app "Failed to parse scheme from URI '$str'";

    my $map = $schemes{$scheme}
        or throw_app "Unsupported URI scheme '$scheme'";

    my $class = $map->($uri);
    eval "require $class"
        or throw_system "Failed to load '$class': $!";

    return $class->new($uri);
}

sub is_member {
    my $self = shift;
    my $name = shift;
    return;
}

sub match {
    my $self = shift;
    my $name = shift;
    return defined($name) && $self->is_member($name);
}

1;

