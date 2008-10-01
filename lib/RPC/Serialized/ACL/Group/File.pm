#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/lib/RPC/Serialized/ACL/Group/File.pm $
# $LastChangedRevision: 1281 $
# $LastChangedDate: 2007-07-02 17:09:10 +0100 (Mon, 02 Jul 2007) $
# $LastChangedBy: oliver $
#
package RPC::Serialized::ACL::Group::File;

use strict;
use warnings FATAL => 'all';

use base 'RPC::Serialized::ACL::Group';

use IO::File;
use UNIVERSAL;
use RPC::Serialized::Exceptions;

sub new {
    my $class = shift;
    my $uri   = shift;

    defined $uri and UNIVERSAL::isa( $uri, 'URI::file' )
        or throw_app 'Missing or invalid URI';

    my $path = $uri->file
        or throw_app "Can't determine path from URI " . $uri->as_string;

    return bless {
        PATH => $path,
    }, $class;
}

sub path {
    my $self = shift;
    return $self->{PATH};
}

sub is_member {
    my $self = shift;
    my $name = shift;

    my $path = $self->path;
    my $fh   = IO::File->new( $path, O_RDONLY )
        or throw_system "Failed to open $path: $!";

    while (<$fh>) {
        s/#.*$//;
        s/^\s+//;
        s/\s+$//;
        next unless length($_);
        return 1 if $_ eq $name;
    }

    return 0;
}

1;

