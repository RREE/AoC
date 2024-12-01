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


SESSION="53616c7465645f5f95a26df40e2c6a34c183d12178eed5d7088c62328ff946200882e846914d0f81381630bf393ae9fc2092a90ac51bcbdc3cedc072b05bb5d2"

URL="https://adventofcode.com/${YEAR}/day/${DAY}/input"
echo $URL

if [ ! -f ${DAYS}/input.txt ] ; then
    mkdir -p ${DAYS}
    curl $URL --cookie "session=${SESSION}" -o ${YEAR}/${DAYS}/input.txt
fi
