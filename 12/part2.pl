#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# Advent of Code 2015 Day 12 Part 2 
#=============================================================================

use v5.40;
use JSON;
use Ref::Util qw(is_ref is_hashref is_arrayref is_scalarref);

my $text = q(The {part in braces} followed by {another});

my $json = from_json(<>);

sub checkRed($h)
{
    my $sum = 0;
    my $depth = "";

    my @stack;
    push @stack, $h;
    while ( my $ref = pop @stack )
    {
        if ( is_hashref($ref) )
        {
            $sum += redHash($ref, \@stack);
        }
        elsif ( is_arrayref($ref) )
        {
            $sum += redArray($ref, \@stack);
        }
    }

    say $sum;
}

sub redHash($hash, $stack)
{
    use List::Util qw/sum any/;

    return 0 if any { !is_ref($_) && $_ eq "red" } values %$hash;

    my $sum = sum grep { !is_ref($_) && $_ =~ m/^-?\d+/ } values %$hash;

    push @$stack, $_ for  grep { is_ref($_) } values %$hash;

    return $sum;
}

sub redArray($arr, $stack)
{
    my $sum = 0;
    for my $thing ( $arr->@* )
    {
        if ( is_ref($thing) )
        {
            push @$stack, $thing;
        }
        elsif ( $thing =~ m/^-?\d+$/ )
        {
            $sum += $thing;
            say "ADD  $thing";
        }
    }
    return $sum;
}

checkRed($json);
