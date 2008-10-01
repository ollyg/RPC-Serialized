#!/usr/bin/perl
#
# $HeadURL: https://svn.oucs.ox.ac.uk/networks/src/debian/packages/libr/librpc-serialized-perl/trunk/t/22-rpc-serialized-debug.t $
# $LastChangedRevision: 1359 $
# $LastChangedDate: 2007-07-23 21:12:25 +0100 (Mon, 23 Jul 2007) $
# $LastChangedBy$
#

use strict;
use warnings;

use Test::More tests => 16;

use Data::Serializer;

use_ok('RPC::Serialized');
can_ok( 'RPC::Serialized', 'ifh' );
can_ok( 'RPC::Serialized', 'ofh' );
can_ok( 'RPC::Serialized', 'send' );
can_ok( 'RPC::Serialized', 'recv' );

SKIP: {
skip( "Cannot load IO::String", 11 )
    unless eval {require IO::String };

my $in  = IO::String->new();
my $out = IO::String->new();
# has to use something which is in the Perl core dist
my $ds  = Data::Serializer->new(
    serializer => 'Data::Dumper',
    encoding   => 'b64',
);

my $t = RPC::Serialized->new({
    rpc_serialized => {
        ifh => $in, ofh => $out,
        debug => 1,
    },
    data_serializer => {
        serializer => 'Data::Dumper',
        encoding   => 'b64',
        portable   => 0, # should be overridden to 1
    },
});

isa_ok( $t, 'RPC::Serialized' );
ok( $t->ifh );
ok( $t->ofh );

eval { $t->send( [] ) };
isa_ok( $@, 'RPC::Serialized::X::Protocol' );
is( $@->message, 'Data not a hash reference' );

my $h = { a => 1, b => 2, c => 3 };
my $h_rpc;
{
    $h_rpc = $ds->raw_serialize($h);
}

ok( $t->send($h), 'Sending data' );
is( ${ $out->string_ref }, "$h_rpc\n...\n" );
print quotemeta ${ $out->string_ref };
print quotemeta "$h_rpc\n...\n";

${ $in->string_ref } = "$h_rpc\n...\n";
$in->setpos(0);
my $data = $t->recv;
ok( defined $data );
ok( eq_hash( $h, $data ) );

${ $in->string_ref } = "-\n--\n~?~?!...\n";
$in->setpos(0);
eval { $data = $t->recv };
isa_ok( $@, 'RPC::Serialized::X::Protocol' );
like( $@->message, qr/^Data::Serializer error:/ );

}
