#!/usr/bin/env perl

use strict;
use warnings;

use JSON;
use IO::All;
use Pod::Usage;

pod2usage(1) unless scalar(@ARGV) > 0;

my @specs;
foreach (@ARGV) {
    push @specs, read_from_json($_);
}

print << 'DOT';
digraph {

    node [shape=record];
    edge [arrowhead = odot, arrowtail = none];
DOT

my $has_interface = scalar(@specs) > 1;
if ($has_interface) {
    my $top = $specs[0]->{name};
    print "    \"", $top, "\"\n";
    print "        [label=\"{\\N}\"];\n\n";
    foreach my $spec (@specs) {
        my $name = $spec->{meta}->{module} || $spec->{name};
        print "    \"", $top, "\" -> \"", $name, "\"\n\n";
    }

}

my %meth;
foreach my $spec (@specs) {
    my $name = $spec->{meta}->{module} || $spec->{name};
    print "    \"", $name, "\"\n";
    print "        [label=\"{";
    print "&laquo;interface&raquo;\\n" if ($has_interface);
    print "\\N|";
    for my $name (sort keys %{$spec->{methods}}) {
        die "duplicated $name" if exists $meth{$name};
        $meth{$name} = 1;
        my $desc = $spec->{methods}->{$name};
        print $name, "(";
        my $first = 1;
        if ($desc->{required_payload}) {
            print "payload";
            $first = 0;
        }
        for (@{$desc->{required_params}}) {
            print ", " unless $first;
            print $_;
            $first = 0;
        }
        if ($desc->{optional_params}) {
            print " " unless $first;
        }
        for (@{$desc->{optional_params}}) {
            print "\\[";
            print ", " unless $first;
            print $_, "\\]";
            $first = 0;
        }
        print ")";
        print " &otimes;" if $desc->{authentication};
        print "\\l";
    }
    print "}\"];\n\n";
}
print "}\n";

sub read_from_json {
    my ($fname) = @_;

    my $content < io $fname;
    return JSON::decode_json($content);
}

__END__

=head1 NAME

spore2dot

=head1 SYNOPSIS

spore2dot.pl api1.json [api2.json, ...] > api.dot

=cut
