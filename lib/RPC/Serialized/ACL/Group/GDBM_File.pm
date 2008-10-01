#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/lib/RPC/Serialized/ACL/Group/GDBM_File.pm $
# $LastChangedRevision: 1281 $
# $LastChangedDate: 2007-07-02 17:09:10 +0100 (Mon, 02 Jul 2007) $
# $LastChangedBy: oliver $
#
package RPC::Serialized::ACL::Group::GDBM_File;

use strict;
use warnings FATAL => 'all';

use base 'RPC::Serialized::ACL::Group::File';

use GDBM_File;
use RPC::Serialized::Exceptions;

sub hash {
    my $self = shift;

    unless ( $self->{HASH} ) {
        my $path = $self->path;

        my %hash;
        tie( %hash, 'GDBM_File', $path, GDBM_READER, 0 )
            or throw_system "Failed to open GDBM file $path: $!";

        $self->{HASH} = \%hash;
    }

    return $self->{HASH};
}

sub is_member {
    my $self = shift;
    my $name = shift;
    return exists $self->hash->{$name};
}

1;

