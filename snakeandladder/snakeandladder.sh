function CaseStatement()
{
	times=0
        while [ $currentposition -lt 100 ]
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
	times=$(( $times + 1 ))
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
        done
	echo "total number of times : $times"
}
