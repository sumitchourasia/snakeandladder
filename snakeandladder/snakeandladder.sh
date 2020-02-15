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
        k=0
        while [ $k -lt 15 ]
        do
        GenerateRandom
        random=$?
        option=$(($random % 3))
        case $option in
                1)
                        echo "do nothing"
                        ;;
                2)
                        echo "ladder"
                        ladder
                        PrintBoard
                        ;;
                3)
                        echo "snake"
                        ;;

        esac
                k=$(($k + 1))
        done
}

function ladder()
{ 
	RollTheDie
	die=$?
	die=$(( $die % 6 ))
	die=$(($die + 1))
	previousposition=$currentposition
	currentposition=$(( $currentposition + $die ))
	i=$(($currentposition / 10 ))
	j=$(($currentposition % 10 ))
	if [ "$j" -eq "0" ]
	then
		i=$(( $i - 1 ))
		j=9
	else
		if [ "$(( $i % 2 ))" -eq "0" ]
		then
		j=$(( $j - 1 ))
		else
			j=$(( 9 - $j + 1 ))
		fi
	fi
	echo "current position  : $currentposition"
	board[$i,$j]="p1"
	PutPrevious
}

function PutPrevious()
{
 	if [ "$previousposition" -eq "0" ]
	then
		previousposition=1
	fi
	pi=$(($previousposition / 10 ))
        pj=$(($previousposition % 10 ))
	echo "previous position : $previousposition"

	if [ "$pj" -eq "0" ]
        then	
		if [ "$pi" -eq "0" ]
		then
			pi=1
		fi
                pi=$(( $pi - 1 ))
                pj=9
        else
                if [ "$(($pi % 2))" -eq "0" ]
                then
                pj=$(( $pj - 1 ))
                else
                        pj=$(( 9 - $pj + 1 ))
                fi
        fi
	echo " pi and pj :  $pi , $pj"
	board[$pi,$pj]=$previousposition
}

InitializeBoard
PrintBoard
InitializePlayerPostion
CaseStatement
