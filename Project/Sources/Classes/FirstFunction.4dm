Class extends AggFunction

Function call($colOrSel : Variant)->$result : Variant
	
	If (Value type:C1509($colOrSel)=Is collection:K8:32)
		If ($colOrSel.length>0)
			$result:=$colOrSel[0][This:C1470.field]
		Else 
			$result:=Null:C1517
		End if 
	Else 
		$result:=$colOrSel.first()
		If ($result#Null:C1517)
			$result:=$result[This:C1470.field]
		End if 
	End if 