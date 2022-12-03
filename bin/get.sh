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


SESSION="53616c7465645f5fd891783967c6b6923ab57aaff96d91ba4bbef18bddb0e3281e35315ce9966aafcd44a0a3e6f6a9c136f0fda8093dcae8af6050a221d44528"
URL="https://adventofcode.com/${YEAR}/day/${DAY}/input"


if [ ! -f ${DAYS}/input.txt ] ; then
    mkdir -p ${DAYS}
    curl $URL --cookie "session=${SESSION}" -o 2022/${DAYS}/input.txt
fi
