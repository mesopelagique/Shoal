

Class constructor($data : Variant; $by : Collection)
	This:C1470.data:=$data
	This:C1470.by:=$by
	
Function split($now : Boolean)->$this : Object
	This:C1470.splitKeys:=This:C1470.data.distinct(This:C1470.by[0])  // for the moment accept only one TODO accept create multigroup
	If (Count parameters:C259>0)  // need sort order before! or in parameters
		If ($now)
			This:C1470.splitValues:=New object:C1471()
			var $key : Text
			var $group : Variant
			For each ($key; This:C1470.splitKeys)
				$group:=This:C1470.data.query(This:C1470.by[0]+" = :1"; $key)
				If (This:C1470.sortOrder#Null:C1517)
					$group:=$group.orderBy(This:C1470.sortOrder)
				End if 
				This:C1470.splitValues[String:C10($key)]:=$group
			End for each 
		End if 
	End if 
	$this:=This:C1470
	
Function orderBy($sortOrder : Variant)->$this : Object
	This:C1470.sortOrder:=$sortOrder
	$this:=This:C1470
	
Function agg()->$result : Object
	$result:=New object:C1471()
	C_OBJECT:C1216(${1})  // agg functions
	
	var $group : Variant
	var $i : Integer
	var $key : Text
	
	If (This:C1470.splitKeys=Null:C1517)
		This:C1470.split()
	End if 
	
	For each ($key; This:C1470.splitKeys)
		
		// split
		If (This:C1470.splitValues=Null:C1517)
			$group:=This:C1470.data.query(This:C1470.by[0]+" = :1"; $key)
			If (This:C1470.sortOrder#Null:C1517)
				$group:=$group.orderBy(This:C1470.sortOrder)
			End if 
		Else 
			$group:=This:C1470.splitValues[$key]
		End if 
		
		// combine the computation
		$result[String:C10($key)]:=New object:C1471()
		For ($i; 1; Count parameters:C259)
			$result[String:C10($key)][${$i}.asValue]:=${$i}.call($group)  // apply
		End for 
		
	End for each 
	
	// MARK: some shortcut for one col
	
Function sum($col : Text; $newName : Text)->$result : Object
	$result:=This:C1470.agg(cs:C1710.SumFunction.new($col).as(Count parameters:C259>1 ? $newName : ("sum ("+$col+")")))
	
/* sumDistinct function: will sum distinct values */
Function sumDistinct($col : Text; $newName : Text)->$result : Object
	$result:=This:C1470.agg(cs:C1710.SumDistinctFunction.new($col).as(Count parameters:C259>1 ? $newName : ("sumDistinct ("+$col+")")))
	
/* avg function: will make an average of the values */
Function avg($col : Text; $newName : Text)->$result : Object
	$result:=This:C1470.agg(cs:C1710.AvgFunction.new($col).as(Count parameters:C259>1 ? $newName : ("avg ("+$col+")")))
	
/* mean function: will make an average of the values */
Function mean($col : Text; $newName : Text)->$result : Object
	$result:=This:C1470.agg(cs:C1710.AvgFunction.new($col).as(Count parameters:C259>1 ? $newName : ("mean ("+$col+")")))
	
/* count function: will count defined values */
Function count($col : Text; $newName : Text)->$result : Object
	$result:=This:C1470.agg(cs:C1710.CountFunction.new($col).as(Count parameters:C259>1 ? $newName : ("count ("+$col+")")))
	
/* countDistinct function: will count distinct defined values */
Function countDistinct($col : Text; $newName : Text)->$result : Object
	$result:=This:C1470.agg(cs:C1710.CountDistinctFunction.new($col).as(Count parameters:C259>1 ? $newName : ("countDistinct ("+$col+")")))
	
/* min function: will find the minimum value */
Function min($col : Text; $newName : Text)->$result : Object
	$result:=This:C1470.agg(cs:C1710.MinFunction.new($col).as(Count parameters:C259>1 ? $newName : ("min ("+$col+")")))
	
/* max function: will find the maximum value */
Function max($col : Text; $newName : Text)->$result : Object
	$result:=This:C1470.agg(cs:C1710.MaxFunction.new($col).as(Count parameters:C259>1 ? $newName : ("max ("+$col+")")))
	
/* first function: return the first if any */
Function first($col : Text; $newName : Text)->$result : Object
	$result:=This:C1470.agg(cs:C1710.FirstFunction.new($col).as(Count parameters:C259>1 ? $newName : ("first ("+$col+")")))
	
/* last function: return the last if any */
Function last($col : Text; $newName : Text)->$result : Object
	$result:=This:C1470.agg(cs:C1710.LastFunction.new($col).as(Count parameters:C259>1 ? $newName : ("last ("+$col+")")))
	