

Class constructor
	If (Count parameters:C259>0)
		This:C1470.field:=$1
		This:C1470.asValue:=$1
	End if 
	
	// change final name
Function as
	C_TEXT:C284($1)
	C_OBJECT:C1216($0)
	This:C1470.asValue:=$1
	$0:=This:C1470
	
/*
MARK: functions
*/
	
/* sum function: will sum the values */
Function sum
	C_TEXT:C284($1)
	$0:=cs:C1710.SumFunction.new($1)
	
/* sumDistinct function: will sum distinct values */
Function sumDistinct
	C_TEXT:C284($1)
	$0:=cs:C1710.SumDistinctFunction.new($1)
	
/* col function: will return a collection of values */
Function col
	C_TEXT:C284($1)
	$0:=cs:C1710.ColFunction.new($1)
	
/* set function: will return a collection of distinct values */
Function set
	C_TEXT:C284($1)
	$0:=cs:C1710.ColDistinctFunction.new($1)
	
/* avg function: will make an average of the values */
Function avg
	C_TEXT:C284($1)
	$0:=cs:C1710.AvgFunction.new($1)
	
/* mean function: alias for avg */
Function mean
	C_TEXT:C284($1)
	$0:=cs:C1710.AvgFunction.new($1)
	
/* count function: will count defined values */
Function count
	C_TEXT:C284($1)
	$0:=cs:C1710.CountFunction.new($1)
	
/* countDistinct function: will count distinct defined values */
Function countDistinct
	C_TEXT:C284($1)
	$0:=cs:C1710.CountDistinctFunction.new($1)
	
/* min function: will find the minimum value */
Function min
	C_TEXT:C284($1)
	$0:=cs:C1710.MinFunction.new($1)
	
/* max function: will find the maximum value */
Function max
	C_TEXT:C284($1)
	$0:=cs:C1710.MaxFunction.new($1)
	
/* first function: return the first if any */
Function first
	C_TEXT:C284($1)
	$0:=cs:C1710.FirstFunction.new($1)
	
/* last function: return the last if any */
Function last
	C_TEXT:C284($1)
	$0:=cs:C1710.LastFunction.new($1)
	
	
	// TODO kurtosis, skeweness, variance, standards deviation