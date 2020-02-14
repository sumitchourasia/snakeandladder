function InitializeBoard()
{


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
