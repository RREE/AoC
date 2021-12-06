#!/bin/bash

YEAR=`date +%Y`
DAY=$1
if (( ${#DAY} == 1 )) ; then DAYS="0${DAY}" ; fi
DAY=${DAY:-`date +%d`}
if (( $((10#$DAY)) < 1 )) ; then
    echo "wrong day number"
    exit
fi
if (( $((10#$DAY)) > 25 )) ; then
    echo "wrong day number"
    exit
fi


SESSION="53616c7465645f5fc447270a6ec6d3c2526d95f19c4da9b326f1c52fd4f930f8121bd9b4b782a0bf735d2f64fa3ef945"
URL="https://adventofcode.com/${YEAR}/day/${DAY}/input"


if [ ! -f ${DAYS}/input.txt ] ; then
    mkdir -p ${DAYS}
    curl -v $URL --cookie "session=${SESSION}" -o ${DAYS}/input.txt
fi
