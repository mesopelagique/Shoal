
// Convert grouped result into a DataFrame
// /!\ it's better to request a result as data frame before to keep column data type and name, see `flatten()` before `agg`
Function asDataFrame($colName : Text)->$dataFrame : cs:C1710.DataFrame
	$dataFrame:=cs:C1710.DataFrame.new(New collection:C1472)
	var $row : Object
	var $value : Text
	For each ($value; This:C1470)
		$row:=OB Copy:C1225(This:C1470[$value])
		$row[$colName]:=$value  // will be string, flatten before to keep data type!!! (could add new parameter to cast it)
		$dataFrame.data.push($row)
	End for each 
	
	// Convert grouped result into a DataFrame
	// /!\ it's better to request a result as data frame before to keep column data type, see `flatten()` before `agg`
Function flatten()->$dataFrame : cs:C1710.DataFrame
	$dataFrame:=This:C1470.asDataFrame()
	
	