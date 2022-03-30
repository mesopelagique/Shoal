Class constructor($field : Text; $asValue : Text)
	If (Count parameters:C259>0)
		This:C1470.field:=$field
		If (Count parameters:C259>1)
			This:C1470.asValue:=$asValue
		Else 
			This:C1470.asValue:=$field
		End if 
	End if 
	
	// change final name
Function as($newName : Text)->$this : Object
	This:C1470.asValue:=$newName
	$this:=This:C1470
	
	// MARK: static functions
	
/* sum function: will sum the values */
Function sum($col : Text)->$function : Object
	$function:=cs:C1710.SumFunction.new($col)
	
/* sumDistinct function: will sum distinct values */
Function sumDistinct($col : Text)->$function : Object
	$function:=cs:C1710.SumDistinctFunction.new($col)
	
/* col function: will return a collection of values */
Function col($col : Text)->$function : Object
	$function:=cs:C1710.ColFunction.new($col)
	
/* set function: will return a collection of distinct values */
Function set($col : Text)->$function : Object
	$function:=cs:C1710.ColDistinctFunction.new($col)
	
/* avg function: will make an average of the values */
Function avg($col : Text)->$function : Object
	$function:=cs:C1710.AvgFunction.new($col)
	
/* mean function: alias for avg */
Function mean($col : Text)->$function : Object
	$function:=cs:C1710.AvgFunction.new($col)
	
/* count function: will count defined values */
Function count($col : Text)->$function : Object
	$function:=cs:C1710.CountFunction.new($col)
	
/* countDistinct function: will count distinct defined values */
Function countDistinct($col : Text)->$function : Object
	$function:=cs:C1710.CountDistinctFunction.new($col)
	
/* min function: will find the minimum value */
Function min($col : Text)->$function : Object
	$function:=cs:C1710.MinFunction.new($col)
	
/* max function: will find the maximum value */
Function max($col : Text)->$function : Object
	$function:=cs:C1710.MaxFunction.new($col)
	
/* first function: return the first if any */
Function first($col : Text)->$function : Object
	$function:=cs:C1710.FirstFunction.new($col)
	
/* last function: return the last if any */
Function last($col : Text)->$function : Object
	$function:=cs:C1710.LastFunction.new($col)
	
	
	// TODO: kurtosis, skeweness, variance, standards deviation