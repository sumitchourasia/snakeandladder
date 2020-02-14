
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

