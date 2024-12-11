#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code 2015 Day 14 Part 1 "Reindeer Olympics" 
#=============================================================================

use v5.40;
use FindBin qw($Bin); use lib "$FindBin::Bin/../../lib"; use AOC;
AOC::setup;

use List::Util qw/min max/;

$logger->info("START");

my $TIME = 2503;

my %Reindeer;
while (<>)
{
    next unless m/can fly/;
    my ($name, $speed, $fly, $rest) = m/(\w+)\D+(\d+)\D+(\d+)\D+(\d+)/;
    say "$name, $speed, $fly, $rest";
    $Reindeer{$name} = { speed=>$speed, fly=>$fly, rest=>$rest };
}

# Example: Dancer fly 27 km/s for 5, then rests 132
# Cycle is 137 seconds, in 2505 seconds there are 18 full cycles and 37 seconds more
# 18*27=486 km + 27 = 513 km

for my $r( keys %Reindeer )
{
    my ($speed, $fly, $rest) = @{$Reindeer{$r}}{qw(speed fly rest) };
    my $period = $fly+$rest;
    my $cycles = int($TIME / $period);
    my $remain = $TIME % $period;

    $Reindeer{$r}{distance} = $speed * $fly * $cycles + min($fly, $remain) * $speed;
}

my @Distance = map { $Reindeer{$_}{distance} } keys %Reindeer;

say "WINNER: ", max @Distance;

$logger->info("FINISH");

