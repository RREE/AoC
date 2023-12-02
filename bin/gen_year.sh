#!/bin/bash

YEAR=`date +%Y`
for ((DAY=1; DAY <= 24; DAY++)); do

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

    echo ${DAYS}

    [[ -d  ${YEAR}/${DAYS} ]] || mkdir -p ${YEAR}/${DAYS}

    T="${YEAR}/${DAYS}/aoc_${DAYS}_a.adb"

    if [[ ! -f $T ]]; then
        touch $T
        echo "with Ada.Text_IO;             use Ada.Text_IO;" >> $T
        echo "with Ada.Integer_Text_IO;     use Ada.Integer_Text_IO;" >> $T
        echo "with Aoc_Helper;              use Aoc_Helper;" >> $T
        echo "" >> $T
        echo "procedure AoC_${DAYS}_A is" >> $T
        echo "" >> $T
        echo "begin" >> $T
        echo "   Open_Input;" >> $T
        echo "" >> $T
        echo "   while not End_Of_File (Input) loop" >> $T
        echo "      declare" >> $T
        echo "         Line : String := Get_Line(Input);" >> $T
        echo "      begin" >> $T
        echo "         null;" >> $T
        echo "      end;" >> $T
        echo "   end loop;" >> $T
        echo "" >> $T
        echo "   Put_Line (\"Result: \");" >> $T
        echo "" >> $T
        echo "end AoC_${DAYS}_A;" >> $T
    else
        echo "Datei $T bereits vorhanden, nicht überschrieben"  
    fi
done


# if [ ! -f ${DAYS}/input.txt ] ; then
#     mkdir -p ${DAYS}
#     curl $URL --cookie "session=${SESSION}" -o ${YEAR}/${DAYS}/input.txt
# fi
