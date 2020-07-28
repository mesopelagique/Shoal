Class extends AggFunction

Function call
	C_COLLECTION:C1488($1)
	C_VARIANT:C1683($0)
	If ($1.length>0)
		$0:=$1[$1.length-1][This:C1470.field]
	Else 
		$0:=Null:C1517
	End if 