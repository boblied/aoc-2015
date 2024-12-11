#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code 2015 Day 13 Part 2 "Knights of the Dinner Table"
#=============================================================================

use v5.40;
use FindBin qw($Bin); use lib "$FindBin::Bin/../../lib"; use AOC;
AOC::setup;

$logger->info("START");

my %Affinity;

while (<>)
{
    chomp;
    my ($p1, $sign, $amount, $p2) = m/(\w+) would (lose|gain) (\d+) happiness units by sitting next to (\w+)/;
    $amount = ( $sign eq "gain" ? 1 : -1 ) * $amount;
    $logger->info("$p1\t$amount\t-> $p2");
    $Affinity{$p1}{$p2} = $amount;
}

my @Name = keys %Affinity;

push @Name, "Robert";

for (@Name )
{
    $Affinity{$_}{'Robert'} = $Affinity{Robert}{$_} = 0;
}

use Algorithm::Permute;
my $p = Algorithm::Permute->new([ @Name ]);

my $best = 0;
while (my @seating = $p->next )
{
    $logger->trace("PERM: ", join(", ", @seating));
    my $aff = calculate(\%Affinity, @seating);
    $best = $aff if $aff > $best;
}
say "BEST: $best";

use Data::Dumper; $Data::Dumper::Sortkeys=1; $Data::Dumper::Indent=0;
$logger->trace("Affinity:\n", Dumper(\%Affinity) );

$logger->info("FINISH");

sub calculate($affinity, @people)
{
    my $score = 0;
    my @delta = (0) x @people;
    for my $seat ( 0 .. $#people )
    {
        my $left  = ($seat - 1) % @people;
        my $right = ($seat + 1) % @people;
        my $person = $people[$seat];
        my $joker = $people[$left];
        my $clown = $people[$right];

        $delta[$seat] = $affinity->{$person}{$joker} + $affinity->{$person}{$clown};
    }
    use List::Util qw/sum/;
    $score = sum @delta;
    $logger->debug("SCORE=$score for [@people]");
    return $score;
}
