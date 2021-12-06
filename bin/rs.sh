#!/bin/bash

YEAR=`date +%Y`
DAY=$1
if (( ${#DAY} == 1 )) ; then DAY="0${DAY}" ; fi
DAY=${DAY:-`date +%d`}
if (( $((10#$DAY)) < 1 )) ; then
    echo "wrong day number"
    exit
fi
if (( $((10#$DAY)) > 25 )) ; then
    echo "wrong day number"
    exit
fi

echo -n "part 1: "
./obj/aoc_${DAY}a ${DAY}/short.txt

echo -n "part 2: "
./obj/aoc_${DAY}b ${DAY}/short.txt
