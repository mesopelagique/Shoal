

Class constructor
	C_VARIANT:C1683($1)
	C_COLLECTION:C1488($2)
	This:C1470.data:=$1
	This:C1470.by:=$2
	
	This:C1470.split()
	
Function split
	$result:=New object:C1471()
	This:C1470.splitKeys:=This:C1470.data.distinct(This:C1470.by[0])  // for the moment accept only one TODO accept create multigroup
	
Function agg
	C_OBJECT:C1216($result; $0)
	$result:=New object:C1471()
	C_OBJECT:C1216(${1})  // agg functions
	
	For each ($key; This:C1470.splitKeys)
		
		// split
		$col:=This:C1470.data.filter("FieldIs"; This:C1470.by[0]; $key)  // this op could be done inside split or only here if needed
		
		// combine the computation
		$result[$key]:=New object:C1471()
		For ($i; 1; Count parameters:C259)
			$result[$key][${$i}.asValue]:=${$i}.call($col)  // apply
		End for 
		
	End for each 
	
	$0:=$result
	