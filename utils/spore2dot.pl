#!/usr/bin/env perl

use strict;
use warnings;

use JSON;
use IO::All;
use Pod::Usage;

pod2usage(1) unless scalar(@ARGV) > 0;

my @specs;
foreach (@ARGV) {
    my $content < io $_;
    push @specs, JSON::decode_json($content);
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
        if ($desc->{optional_payload}) {
            print "\\[";
            print ", " unless $first;
            print "payload\\]";
            $first = 0;
        }
        if ($desc->{unattended_params} || $spec->{unattended_params}) {
            print ", " unless $first;
            print "...";
        }
        print ")";
        print " &otimes;" if $desc->{authentication} || $spec->{authentication};
        print " DEPRECATED" if $desc->{deprecated};
        print "\\l";
        if ($ENV{SPORE_DETAILS}) {
            print "&nbsp;&nbsp;&nbsp;", $desc->{method}, " ", $desc->{path}, "\\l";
            for my $h (sort keys %{$desc->{headers}}) {
                print "&nbsp;&nbsp;&nbsp;", $h, ": ", $desc->{headers}->{$h}, "\\l";
            }
            for my $f (sort keys %{$desc->{'form-data'}}) {
                print "&nbsp;&nbsp;&nbsp;form-data \\\"", $f, "\\\" ", $desc->{'form-data'}->{$f}, "\\l";
            }
            my $status = $desc->{expected_status} || $spec->{expected_status};
            print "&nbsp;&nbsp;&nbsp;", join(', ', @{$status}), "\\l" if $status;
        }
    }
    print "}\"];\n\n";

    my $note = $spec->{description};
    if ($note && $ENV{SPORE_NOTES}) {
        $note =~ s/\n/\\n/g;
        print "    \"__note__", $name, "\"\n";
        print "        [label=\"", $note, "\" shape=note];\n\n";

        print "    \"", $name, "\" -> \"__note__", $name, "\"\n";
        print "        [arrowhead = none, arrowtail = none, style = dashed];\n\n";
    }
    my $doc = $spec->{meta}->{documentation};
    if ($doc && $ENV{SPORE_NOTES}) {
        $doc =~ s/\n/\\n/g;
        print "    \"__doc__", $name, "\"\n";
        print "        [label=\"", $doc, "\" shape=note];\n\n";

        print "    \"", $name, "\" -> \"__doc__", $name, "\"\n";
        print "        [arrowhead = none, arrowtail = none, style = dashed];\n\n";
    }
}
print "}\n";

__END__

=head1 NAME

spore2dot

=head1 SYNOPSIS

spore2dot.pl api1.json [api2.json, ...] > api.dot

=cut
