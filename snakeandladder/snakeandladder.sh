#!/bin/bash
declare -A board[10,10]
#set -x
# snake and ladder program implementation
echo "welcome to snake and ladder game"


function InitializeBoard()
{
	value=100
	for (( i=0;i<10;i++ ))
	do
		for(( j=0;j<10;j++ ))
		do
		board[$i,$j]=$value
		value=$(($value - 1))
		done
	done
}


function PrintBoard()
{
        for (( i=0;i<10;i++ ))
        do
                if [ "$i" -eq "9" ]
                then
                         for ((j=0;j<10;j++))
                         do
                                echo -e " ${board[$i,$j]}  \c "
                         done
                else
                        for ((j=0;j<10;j++))
                        do
                        echo -e " ${board[$i,$j]} \c "
                        done
                fi
                echo " "
                echo " "
        done
}

function InitializePlayerPostion()
{
        currentposition=0
        return $currentposition
}



function GenerateRandom()
{
        random=$(($RANDOM % 6))
        random=$(($random + 1))
        return $random
}

function RollTheDie()
{
        GenerateRandom
        randomoutput=$?
        return $randomoutput
}




function CaseStatement()
{
	i=0
	while [ $i -lt 9 ]
	do
	GenerateRandom
	option=$(( $random % 3 ))
	case $option in 
		0)
			echo "do nothing"
			;;
		1)

			echo "Ladder"
			;;
		2)
			echo "snake"
			;;
	esac
	i=$(($i + 1 ))
done
}


