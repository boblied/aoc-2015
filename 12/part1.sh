perl -lanE 'say $_ for m/-?\d+/g' $* | awk '{s+=$0}END{print s}'
