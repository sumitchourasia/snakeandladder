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
        p1currentposition=0
	p2currentposition=0
	p1previousposition=0
	p2previousposition=0
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
	times=0
        while [ $p1currentposition -lt 100 -a $p2currentposition -lt 100 ]
        do
        GenerateRandom
        random=$?
        option=$(($random % 11))

	if [ "$option" == "0" ]
        then
                option=0
        elif [ "$(($option % 5))" == "0" ]
        then
                option=2
        else
                option=1
        fi
	times=$(( $times + 1 ))
     
	case $option in
                0)
                        echo "do nothing"
                        ;;
                1)
                        echo "ladder"
			p1previousposition=$p1currentposition
			echo "ladder , p1currentposition = $p1currentposition ,player = p1"
			ladder $p1currentposition "p1" 
			p1currentposition=$?
			echo "p1previousposition : $p1previousposition"
			echo "p1currentposition : $p1currentposition"
			echo "p2previousposition : $p2previousposition"
                        echo "p2currentposition : $p2currentposition"
			echo "putlader player = p1 , p1previousposition = $p1previousposition "
			PutPrevious "p1" $p1previousposition
                        PrintBoard
				
			p2previousposition=$p2currentposition
			echo "ladder , p2currentposition = $p2currentposition ,player = p2"
			ladder $p2currentposition "p2"
                        p2currentposition=$?
			echo "p1previousposition : $p1previousposition"
                        echo "p1currentposition : $p1currentposition"
			echo "p2previousposition : $p2previousposition"
                        echo "p2currentposition : $p2currentposition"
			echo "putlader player = p2 , p1previousposition = $p2previousposition "
			PutPrevious "p2" $p2previousposition
                        PrintBoard
                        ;;
                2)
			echo "snake"
                        p1previousposition=$p1currentposition
                        echo "snake , p1currentposition = $p1currentposition ,player = p1"
                        Snake $p1currentposition "p1"
                        p1currentposition=$?
                        echo "p1previousposition : $p1previousposition"
                        echo "p1currentposition : $p1currentposition"
                        echo "p2previousposition : $p2previousposition"
                        echo "p2currentposition : $p2currentposition"
                        echo "putlader player = p1 , p1previousposition = $p1previousposition "
                        PutPrevious "p1" $p1previousposition
                        PrintBoard

                        p2previousposition=$p2currentposition
                        echo "snake , p2currentposition = $p2currentposition ,player = p2"
                        Snake $p2currentposition "p2"
                        p2currentposition=$?
                        echo "p1previousposition : $p1previousposition"
                        echo "p1currentposition : $p1currentposition"
                        echo "p2previousposition : $p2previousposition"
                        echo "p2currentposition : $p2currentposition"
                        echo "putlader player = p2 , p1previousposition = $p2previousposition "
                        PutPrevious "p2" $p2previousposition
                        PrintBoard
                        ;;
        esac
        done
	echo "total number of times is : $times "
	echo " congratulatioins  ${board[9,0]} won!!! "
	

}

function ladder()
{
	echo "inside ladder"
	currentposition=$1
	player=$2
	echo "player : $player"
	echo "current position : $currentposition"
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
	echo " i = $i and j = $j "
	#echo "before if for player check"
	#if [ "$player" == "p1" ]
	#then
	#	p1previousposition=$previousposition
	#	echo " assigend value = p1previousposition : $p1previousposition"
#
#	else
#		p2previousposition=$previousposition
#		echo " assigend value =  p2previousposition : $p2previousposition "
#
#	fi

	if [ "${board[$i,$j]}" == "p1" -a "$player" == "p2" ]
	then
		board[$i,$j]="p1,p2"

	elif [ "${board[$i,$j]}" == "p2" -a "$player" == "p1" ]
	then
	 	 board[$i,$j]="p1,p2"
	else
		 board[$i,$j]=$player
	fi
        #PutPrevious $player $previousposition

	return $currentposition
}

function PutPrevious()
{
	player=$1
	previousposition=$2
        if [ "$previousposition" == "0" ]
        then
                previousposition=1
        fi
        pi=$(($previousposition / 10 ))
        pj=$(($previousposition % 10 ))
        echo "previous position : $previousposition"
        if [ "$pj" == "0" ]
        then
                if [ "$pi" == "0" ]
                then
                        pi=1
                fi
                if [ "$(($pi % 2))" == "0" ]
                then
                         pi=$(( $i - 1))
                else
                         pi=$(( $i - 1 ))
                         pj=9
                fi
        else
                if [ "$(($pi % 2))" == "0" ]
                then
                pj=$(( $pj - 1 ))
                else
                        pj=$(( 9 - $pj + 1 ))
                fi
        fi
        echo " pi and pj :  $pi , $pj"
	
	if [ "${board[$pi,$pj]}" == "p1,p2" ] 
	then
		if [ "$player" == "p1" ]
		then
			board[$pi,$pj]=p2
		else
			board[$pi,$pj]=p1
		fi
	else
		 board[$pi,$pj]=$previousposition
			
	fi
}

function Snake()
{
	currentposition=$1
        player=$2
        echo "player : $player"
        echo "current position : $currentposition"

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

        if [ "$j" == "0" ]
        then
                if [ "$(($i % 2))" == "0" ]
                then
                         i=$(( $i - 1))
                else
                         i=$(( $i - 1 ))
                         j=9
                fi
        else
                if [ "$(( $i % 2 ))" == "0" ]
                then
                j=$(( $j - 1 ))
                else
                        j=$(( 9 - $j + 1 ))
                fi
        fi
	
	echo "i = $i and j = $j"
	if [ "${board[$i,$j]}" == "p1" -a "$player" == "p2" ]
        then
                board[$i,$j]="p1,p2"

        elif [ "${board[$i,$j]}" == "p2" -a "$player" == "p1" ]
        then
                 board[$i,$j]="p1,p2"
        else
                 board[$i,$j]=$player
        fi
  	return $currentposition
}

InitializeBoard
PrintBoard
InitializePlayerPostion
CaseStatement

