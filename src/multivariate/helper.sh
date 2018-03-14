#!/usr/bin/env bash

# a helper bash script to clean up the original downloaded CPU spec

function rawData() {
    echo "
Intel Core i7-7700K 93,471x	99%	99%	$422
AMD Ryzen-5 1600 40,691x	81%	95%	$270
Intel Core i5-7600K 33,990x	95%	106%	$315
AMD Ryzen-7 1700 29,360x	85%	87%	$393
Intel Core i7-8700K 26,983x	111%	104%	$499
AMD Ryzen-5 1600X 14,962x	86%	100%	$285
Intel Core i5-8600K 9,925x	105%	113%	$343
AMD Ryzen-3 1200 5,836x	69%	106%	$134
Intel Core i5-8400 4,622x	92%	111%	$256
Intel Core i3-8100 2,735x	81%	116%	$163
Intel Core i9-7900X 2,188x	113%	73%	$1,333
" > /tmp/_
}

function run() {
    awk '
BEGIN {
    FS = " "
    printf("#Model    Popularity   Performance  Value  Price\n")
}
NF > 2 {
    printf("%s/%s/%s", $1, $2, $3)
    printf("   %s ", gensub(/,|x/, "", "g", $4))
    rest = sprintf("%s   %s   %s", $5, $6, $7)
    printf("   %s ", gensub(/%|$/, "", "g", rest))
    printf("\n")
}
' /tmp/_
}

rawData
run
