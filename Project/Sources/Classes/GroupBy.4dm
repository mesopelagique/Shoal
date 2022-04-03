Class constructor($dataFrame : cs:C1710.DataFrame; $by : Collection; $flatten : Boolean)
	This:C1470.dataFrame:=$dataFrame
	This:C1470.by:=$by
	This:C1470.isFlat:=Bool:C1537($flatten)
	
Function get data()->$data : Variant
	$data:=This:C1470.dataFrame.data
	
Function get columnNames()->$cols : Collection
	$cols:=This:C1470.dataFrame.columnNames
	
	// MARK: - private
Function _split($now : Boolean)->$this : Object
	This:C1470.splitKeys:=This:C1470.data.distinct(This:C1470.by[0])  // TODO: for the moment accept only one TODO accept create multigroup
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
	
	// MARK: - setup 
	
	// Set an order for group, useful for `first` and `last`
Function orderBy($sortOrder : Variant)->$this : Object
	This:C1470.sortOrder:=$sortOrder
	$this:=This:C1470
	
Function flatten()->$this : Object
	This:C1470.isFlat:=True:C214
	$this:=This:C1470
	
Function resultAsDataFrame()->$this : Object
	$this:=This:C1470.flatten()
	
	// MARK: - aggregate 
	
	// Aggregate data using all `AggFunction` passed as parameters
	// parameters $functions...   list of aggregate functions associated to columns
	// return: a `GroupedResult` or a `DataFrame` if `flatten`(or `resultAsDataFrame`) called before
Function agg()->$result : Object
	C_OBJECT:C1216(${1})  // agg functions
	
	$result:=This:C1470.isFlat ? cs:C1710.DataFrame.new(New collection:C1472) : cs:C1710.GroupedResult.new()
	
	var $group : Variant
	var $i : Integer
	var $key : Text
	var $row : Object
	
	If (This:C1470.splitKeys=Null:C1517)
		This:C1470._split()
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
		If (This:C1470.isFlat)
			$row:=New object:C1471(This:C1470.by[0]; $key)
			$result.data.push($row)
		Else 
			$row:=New object:C1471()
			$result[String:C10($key)]:=$row
		End if 
		
		For ($i; 1; Count parameters:C259)
			$row[${$i}.asValue]:=${$i}.call($group)  // apply
		End for 
		
	End for each 
	
	// MARK: some shortcut for one col
	
/* sums function: will sum values of `$col` for each group */
Function sums($col : Text; $newName : Text)->$result : Object
	If (Count parameters:C259=0)
		$result:=This:C1470.agg.apply(This:C1470; This:C1470.columnNames.map("NewClass"; cs:C1710.SumFunction))
	Else 
		$result:=This:C1470.agg(cs:C1710.SumFunction.new($col).as(Count parameters:C259>1 ? $newName : ("sum ("+$col+")")))
	End if 
	
/* sumsDistinct function: will sum distinct values of `$col` for each group */
Function sumsDistinct($col : Text; $newName : Text)->$result : Object
	If (Count parameters:C259=0)
		$result:=This:C1470.agg.apply(This:C1470; This:C1470.columnNames.map("NewClass"; cs:C1710.SumDistinctFunction))
	Else 
		$result:=This:C1470.agg(cs:C1710.SumDistinctFunction.new($col).as(Count parameters:C259>1 ? $newName : ("sumDistinct ("+$col+")")))
	End if 
	
/* averages function: will make an average of the values of `$col` for each group */
Function averages($col : Text; $newName : Text)->$result : Object
	If (Count parameters:C259=0)
		$result:=This:C1470.agg.apply(This:C1470; This:C1470.columnNames.map("NewClass"; cs:C1710.AvgFunction))
	Else 
		$result:=This:C1470.agg(cs:C1710.AvgFunction.new($col).as(Count parameters:C259>1 ? $newName : ("avg ("+$col+")")))
	End if 
	
/* means function: will make an average of the values of `$col` for each group (same as averages) */
Function means($col : Text; $newName : Text)->$result : Object
	If (Count parameters:C259=0)
		$result:=This:C1470.agg.apply(This:C1470; This:C1470.columnNames.map("NewClass"; cs:C1710.AvgFunction))
	Else 
		$result:=This:C1470.agg(cs:C1710.AvgFunction.new($col).as(Count parameters:C259>1 ? $newName : ("mean ("+$col+")")))
	End if 
	
/* counts function: will count defined values of `$col` for each group */
Function counts($col : Text; $newName : Text)->$result : Object
	If (Count parameters:C259=0)
		$result:=This:C1470.agg.apply(This:C1470; This:C1470.columnNames.map("NewClass"; cs:C1710.CountFunction))
	Else 
		$result:=This:C1470.agg(cs:C1710.CountFunction.new($col).as(Count parameters:C259>1 ? $newName : ("count ("+$col+")")))
	End if 
	
/* countsDistinct function: will count distinct defined values of `$col` for each group */
Function countsDistinct($col : Text; $newName : Text)->$result : Object
	If (Count parameters:C259=0)
		$result:=This:C1470.agg.apply(This:C1470; This:C1470.columnNames.map("NewClass"; cs:C1710.CountDistinctFunction))
	Else 
		$result:=This:C1470.agg(cs:C1710.CountDistinctFunction.new($col).as(Count parameters:C259>1 ? $newName : ("countDistinct ("+$col+")")))
	End if 
	
/* minimums function: will find the minimum value of `$col` for each group */
Function minimums($col : Text; $newName : Text)->$result : Object
	If (Count parameters:C259=0)
		$result:=This:C1470.agg.apply(This:C1470; This:C1470.columnNames.map("NewClass"; cs:C1710.MinFunction))
	Else 
		$result:=This:C1470.agg(cs:C1710.MinFunction.new($col).as(Count parameters:C259>1 ? $newName : ("min ("+$col+")")))
	End if 
	
/* maximums function: will find the maximum value of `$col` for each group */
Function maximums($col : Text; $newName : Text)->$result : Object
	If (Count parameters:C259=0)
		$result:=This:C1470.agg.apply(This:C1470; This:C1470.columnNames.map("NewClass"; cs:C1710.MaxFunction))
	Else 
		$result:=This:C1470.agg(cs:C1710.MaxFunction.new($col).as(Count parameters:C259>1 ? $newName : ("max ("+$col+")")))
	End if 
	
/* first function: return the first ones if any of `$col` for each group */
Function first($col : Text; $newName : Text)->$result : Object
	If (Count parameters:C259=0)
		$result:=This:C1470.agg.apply(This:C1470; This:C1470.columnNames.map("NewClass"; cs:C1710.FirstFunction))
	Else 
		$result:=This:C1470.agg(cs:C1710.FirstFunction.new($col).as(Count parameters:C259>1 ? $newName : ("first ("+$col+")")))
	End if 
	
/* last function: return the last if any of `$col` for each group */
Function last($col : Text; $newName : Text)->$result : Object
	If (Count parameters:C259=0)
		$result:=This:C1470.agg.apply(This:C1470; This:C1470.columnNames.map("NewClass"; cs:C1710.LastFunction))
	Else 
		$result:=This:C1470.agg(cs:C1710.LastFunction.new($col).as(Count parameters:C259>1 ? $newName : ("last ("+$col+")")))
	End if 
	