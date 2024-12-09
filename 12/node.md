# Advent of Code 2015 Day 12
[JSAbacacusFramework.io]([https://adventofcode.com/2015/day/12)

## Part 1
Use Perl RE to extract numbers.

## Part 2:
Input is in JSON format.

- Fail 1). No regex. Requires finding matching braces and brackets in nested cases.

- Fail 2). Text::Balanced looks useful, but couldn't get it to work.

- Fail 3). Played with jq, but too much learning curve.

Use the JSON module to load the file into a deeply nested hash.
Ref::Util tells us when we're looking at hashes or arrays or scalars.
Usa a depth-first-search stack strategy to go through the structure.
