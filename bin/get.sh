#!/bin/bash

YEAR=`date +%Y`
DAY=$1
DAY=${DAY:-`date +%d`}
if (( $((10#$DAY)) < 1 )) ; then
    echo "wrong day number"
    exit
fi
if (( $((10#$DAY)) > 25 )) ; then
    echo "wrong day number"
    exit
fi
if (( ${#DAY} == 1 )) ; then
    DAYS="0${DAY}"
else
    DAYS=${DAY}
fi


SESSION="53616c7465645f5fc5bac67576de7caa41c0c6daf503ce7ea2d9b4d9f049559b40c10a3161dbfdf27967c635d094d1167b07cf762ca74bf19f0f161b1f5147a1"
URL="https://adventofcode.com/${YEAR}/day/${DAY}/input"


if [ ! -f ${DAYS}/input.txt ] ; then
    mkdir -p ${DAYS}
    curl $URL --cookie "session=${SESSION}" -o ${YEAR}/${DAYS}/input.txt
fi
