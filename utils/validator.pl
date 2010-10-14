#!/usr/bin/env perl

use strict;
use warnings;

use JSON;
use IO::All;
use Data::Rx;
use Getopt::Long;

GetOptions(
    'schema=s'      => \my $schema,
    'description=s' => \my $desc,
);

my $rx = Data::Rx->new;

my $schema_val = $rx->make_schema( read_from_json($schema) );
my $res = $schema_val->check(read_from_json($desc));

if ($res) {
    print "ok - $desc is a valide description\n;"
}else{
    print "nok - $desc is not a valide description\n";
}

sub read_from_json {
    my ($file) = @_;

    my $schema < io $file;
    my $schema_json = JSON::decode_json($schema);
    $schema_json;
}
