#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code 2015 Day 11 Part 1 
#=============================================================================

use v5.40;
use FindBin qw($Bin); use lib "$FindBin::Bin/../../lib"; use AOC;
AOC::setup;

use Data::Dumper; $Data::Dumper::Sortkeys=1;

$logger->info("START");

# Omit i,l, and o
my @DIGIT = ( qw( a b c d e f g h j k m n p q r s t u v w x y z) );
my %VAL   = ( map { $DIGIT[$_] => $_ } 0 .. $#DIGIT );
my $BASE = scalar(@DIGIT);

$logger->info("BASE=$BASE");

sub asNumber($pass)
{
    my @digit = reverse split(//, $pass);
    my $pow = 0;
    my $v = 0;
    for my ($pow, $d) (indexed @digit)
    {
        $v += $VAL{$d} * ($BASE**$pow);
    }
    return $v;
}

sub toString($n)
{
    use integer;
    my $s;
    while ( $n != 0 )
    {
        $s .= $DIGIT[$n % $BASE];
        $n = int($n/$BASE);
    }
    return scalar(reverse($s));
}


# $logger->debug( "VAL: ", Data::Dumper->new([\%VAL])->Dump());

my $Password = shift // 'cqjxjnds';

say "$Password = ", my $n = asNumber($Password);
say "$n => ", toString($n);

for ($n .. $n+10)
{
    say "$_: ", toString($_);
}

$logger->info("FINISH");
