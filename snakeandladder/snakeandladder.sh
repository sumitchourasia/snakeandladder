value=100
function InitializeBoard()
{
        local i=0;
        for ((i=0; i<10 ;i++ ))
        do
                if [ "$(($i % 2))" -eq "0" ]
                then
                        for(( j=0;j<10;j++ ))
                        do
                                board[$i,$j]=$value
                                #echo -e "${board[$i,$j]} \c"
                                value=$(( $value - 1 ))
                        done
                else
                        for (( j=9;j>=0;j-- ))
                        do
                                board[$i,$j]=$value
                                value=`expr $value - 1`
                        done
                fi
        done
}

