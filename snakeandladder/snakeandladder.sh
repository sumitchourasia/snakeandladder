#!/bin/bash
declare -A board[10,10]
#set -x
# snake and ladder program implementation
echo "welcome to snake and ladder game"

function InitializeBoard()
{
        value=100
        for (( i=9;i>=0;i-- ))
        do
                if [ "$(($i % 2 ))" -eq "0" ]
                then
                         for ((j=9;j>=0;j--))
                         do
                                board[$i,$j]="$value"
                                value=$(( $value - 1 ))
                         done
                else
                        for ((j=0;j<10;j++))
                        do
                                board[$i,$j]="$value"
                                value=$(( $value - 1 ))
                        done
                fi
                done
}

function PrintBoard()
{
        for (( i=9;i>=0;i-- ))
        do
                for(( j=0;j<10;j++ ))
                do
                        if [ "$i" -eq "0" ]
                        then
                                echo -e "  ${board[$i,$j]}   \c"
                        else
                                echo -e "  ${board[$i,$j]}  \c"
                        fi
                done
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
        option=$(($random % 11))
	
	if [ "$option" -eq "0" ]
	then
		option=0
	elif [ "$(($option % 5))" -eq "0" ]
	then
		option=2
	else
		option=1
	fi

        case $option in
                0)
                        echo "do nothing"
                        ;;
                1)
                        echo "ladder"
                        ladder
                        PrintBoard
                        ;;
                2)
			echo "snake"
			Snake
			PrintBoard
                        ;;

        esac
                k=$(($k + 1))
        done
}


function ladder()
{
        RollTheDie
        die=$?
        die=$(($die % 6))
        die=$(($die + 1))
	if [ "$(($currentposition + $die ))" -gt "100" ]
        then
                echo "move is not allowed"
                return 0
        fi
	previousposition=$currentposition
        currentposition=$(( $currentposition + $die ))
	i=$(($currentposition / 10 ))
        j=$(($currentposition % 10 ))
        if [ "$j" -eq "0" ]
        then

                if [ "$(($i % 2))" -eq "0" ]
                then
                         i=$(( $i - 1))
                else
                         i=$(( $i - 1 ))
                         j=9
                fi
        else
                if [ "$(( $i % 2 ))" -eq "0" ]
                then
                j=$(( $j - 1 ))
                else
                        j=$(( 9 - $j + 1 ))
                fi
        fi
        echo "currentpostion : $previousposition"
        echo "new position  : $currentposition"
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
                if [ "$(($pi % 2))" -eq "0" ]
                then
                         pi=$(( $i - 1))
                else
                         pi=$(( $i - 1 ))
                         pj=9
                fi
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

function Snake()
{
	RollTheDie
        die=$?
        die=$(($die % 6))
        die=$(($die + 1))
	if [ "$(($currentposition - $die))" -lt "0" ] 
	then
		echo "move is not allowed"
		return 0
	fi
        previousposition=$currentposition
        currentposition=$(( $currentposition - $die ))
        i=$(($currentposition / 10 ))
        j=$(($currentposition % 10 ))

        if [ "$j" -eq "0" ]
        then
                if [ "$(($i % 2))" -eq "0" ]
                then
                         i=$(( $i - 1))
                else
                         i=$(( $i - 1 ))
                         j=9
                fi
        else
                if [ "$(( $i % 2 ))" -eq "0" ]
                then
                j=$(( $j - 1 ))
                else
                        j=$(( 9 - $j + 1 ))
                fi
        fi
        echo "currentpostion : $previousposition"
        echo "new position  : $currentposition"
        board[$i,$j]="p1"
        PutPrevious

}

InitializeBoard
 PrintBoard
 InitializePlayerPostion
 CaseStatement


