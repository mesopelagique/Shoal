
// Create my data frame
// @param $data: collection or selection
Class constructor($data : Variant)
	This:C1470.data:=$data
	
Function groupBy($byCol : Text)->$result : Object
	If (Count parameters:C259>1)
		// experimental, not implemented yet
		C_TEXT:C284(${1})
		var $by : Collection
		$by:=New collection:C1472()
		var $i : Integer
		For ($i; 1; Count parameters:C259)
			$by.push(${$i})
		End for 
	Else 
		$by:=New collection:C1472($byCol)
	End if 
	$result:=cs:C1710.GroupBy.new(This:C1470; $by)
	If (This:C1470.sortOrder#Null:C1517)
		$result.orderBy(This:C1470.sortOrder)
	End if 
	
Function orderBy($sortOrder : Variant)->$this : Object
	// apply some sort operation
	This:C1470.data.orderBy($sortOrder)
	
	// and keep it also for all group by
	This:C1470.sortOrder:=$sortOrder
	
	$this:=This:C1470
	
	// MARK: get some info
	
Function get isEmpty()->$empty : Boolean
	// TODO: check type of data?
	$empty:=This:C1470.data.length=0
	
Function get length()->$length : Integer
	$length:=This:C1470.data.length
	
Function get shape()->$shape : Object
	$shape:=New object:C1471("rows"; This:C1470.data.length; "cols"; This:C1470.columnNames.length)
	
Function get columnNames()->$columns : Collection
	Case of 
		: (Value type:C1509(This:C1470.data)=Is collection:K8:32)
			If (This:C1470._columnNames#Null:C1517)  // as a cache or to force it, like csv header
				$columns:=This:C1470._columnNames
			Else 
				$columns:=New collection:C1472
				var $datum : Object
				For each ($datum; This:C1470.data)
					$columns:=$columns.combine(OB Keys:C1719($datum)).distinct()  // OPTI: combine only new?
				End for each 
			End if 
		Else   // selection ?
			$columns:=OB Keys:C1719(This:C1470.data.getDataClass())
	End case 
	
Function query($query : Text; $value : Variant)->$rows : Collection
	// TODO: support more $values (see selection and collection)
	$rows:=This:C1470.data.query($query; $value)
	
Function containsColumn($colName : Text)->$contains : Boolean
	Case of 
		: (Value type:C1509(This:C1470.data)=Is collection:K8:32)
			var $datum : Object
			For each ($datum; This:C1470.data)
				If (OB Keys:C1719($datum).contains($colName))
					$contains:=True:C214
					return 
				End if 
			End for each 
		Else   // selection ?
			$contains:=OB Keys:C1719(This:C1470.data.getDataClass()).contains($colName)
	End case 
	
	// MARK: export
	
	// Generates a data frame that summarizes the columns of the data frame.
Function summary()->$newDataFrame : cs:C1710.DataFrame
	// TODO: allow to limit colums names with parametes
	
	var $result : Collection
	$result:=New collection:C1472
	var $column : Text
	var $row : Object
	var $onError : Text
	$onError:=Method called on error:C704
	For each ($column; This:C1470.columnNames)
		
		$row:=New object:C1471("column"; $column)
		
		ON ERR CALL:C155("ignore")
		$row.average:=This:C1470.data.average($column)  // it throw for selection, not collection
		ON ERR CALL:C155($onError)
		// TODO: kurtosis, skeweness, variance, standards deviation
		$row.min:=This:C1470.data.min($column)
		$row.max:=This:C1470.data.max($column)
		$row.countDistinct:=This:C1470.data.distinct($column).length  // OPTI: use a count distinct
		$result.push($row)
		
	End for each 
	
	$newDataFrame:=cs:C1710.DataFrame.new($result)
	
	
	// to a CSV Format
	//Function writeCSV($to : 4D.File; $options : Object)
	