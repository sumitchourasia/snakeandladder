
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

