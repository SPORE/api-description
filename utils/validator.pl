#!/usr/bin/env perl

use strict;
use warnings;

use JSON;
use IO::All;
use Data::Rx;
use Getopt::Long;
use Pod::Usage;

GetOptions(
    'help|?'        => \my $help,
    'schema=s'      => \my $schema,
    'description=s' => \my $desc,
) or pod2usage(1);

pod2usage(1) if $help;
pod2usage(1) unless $schema && $desc;

my $rx = Data::Rx->new;

my $schema_val = $rx->make_schema( read_from_json($schema) );
my $res = $schema_val->check(read_from_json($desc));

if ($res) {
    print "ok - $desc is a valid description\n";
}
else{
    print "nok - $desc is not a valid description\n";
}

sub read_from_json {
    my ($file) = @_;

    my $schema < io $file;
    my $schema_json = JSON::decode_json($schema);
    $schema_json;
}

__END__

=head1 NAME

validator - valid JSON against Rx schema

=head1 SYNOPSIS

validator.pl --schema spore_validation.rx --description api.json

=cut
