

Class constructor
	C_VARIANT:C1683($1)
	This:C1470.data:=$1  // support collection, TODO support selection (without translate? need functions)
	
Function groupBy
	C_OBJECT:C1216($0)
	C_TEXT:C284(${1})
	C_COLLECTION:C1488($by)
	$by:=New collection:C1472()
	C_LONGINT:C283($i)
	For ($i; 1; Count parameters:C259)
		$by.push(${$i})
	End for 
	$0:=cs:C1710.GroupBy.new(This:C1470.data; $by)