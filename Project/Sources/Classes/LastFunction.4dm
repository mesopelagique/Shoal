Class extends AggFunction

Function call
	C_VARIANT:C1683($1)  // col or sel
	C_VARIANT:C1683($0)
	If (Value type:C1509($1)=Is collection:K8:32)
		If ($1.length>0)
			$0:=$1[$1.length-1][This:C1470.field]
		Else 
			$0:=Null:C1517
		End if 
	Else 
		$0:=$1.last()
		If ($0#Null:C1517)
			$0:=$0[This:C1470.field]
		End if 
	End if 