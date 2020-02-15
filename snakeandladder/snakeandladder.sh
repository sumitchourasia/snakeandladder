
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
	temp=$(( $currentposition + $die ))
	previousposition=$currentposition
	i=$(($temp / 10 ))
	j=$(( $temp % 10 ))
	
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
	echo "currentpostion : $currentposition"
	currentposition=$temp
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

