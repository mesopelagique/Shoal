

Class constructor
	C_VARIANT:C1683($1)
	C_COLLECTION:C1488($2)
	This:C1470.data:=$1
	This:C1470.by:=$2
	
	This:C1470.split()
	
Function split
	C_OBJECT:C1216($0)  // This
	C_BOOLEAN:C305($1)  // split now?
	
	// If(This.splitKeys#Null) ??
	This:C1470.splitKeys:=This:C1470.data.distinct(This:C1470.by[0])  // for the moment accept only one TODO accept create multigroup
	If (Count parameters:C259>0)
		If ($1)
			This:C1470.splitValues:=New object:C1471()
			C_TEXT:C284($key)
			For each ($key; This:C1470.splitKeys)
				This:C1470.splitValues[String:C10($key)]:=This:C1470.data.query(This:C1470.by[0]+" = :1"; $key)
			End for each 
		End if 
	End if 
	$0:=This:C1470
	
Function agg
	C_OBJECT:C1216($result; $0)
	$result:=New object:C1471()
	C_OBJECT:C1216(${1})  // agg functions
	
	C_VARIANT:C1683($group)
	C_LONGINT:C283($i)
	C_TEXT:C284($key)
	For each ($key; This:C1470.splitKeys)
		
		// split
		If (This:C1470.splitValues=Null:C1517)
			$group:=This:C1470.data.query(This:C1470.by[0]+" = :1"; $key)
		Else 
			$group:=This:C1470.splitValues[$key]
		End if 
		
		// combine the computation
		$result[String:C10($key)]:=New object:C1471()
		For ($i; 1; Count parameters:C259)
			$result[String:C10($key)][${$i}.asValue]:=${$i}.call($group)  // apply
		End for 
		
	End for each 
	
	$0:=$result
	