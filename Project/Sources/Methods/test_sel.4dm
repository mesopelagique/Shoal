//%attributes = {}

// init db
Begin SQL
	DELETE FROM Test;
End SQL

var $collection : Collection
$collection:=New collection:C1472(\
New object:C1471("letter"; "A"; "value"; 1; "toCol"; 1; "toAvg"; 1); \
New object:C1471("letter"; "B"; "value"; 2; "toCol"; 2; "toAvg"; 2; "toCount"; 2); \
New object:C1471("letter"; "C"; "value"; 3; "toCol"; 3; "toAvg"; 3); \
New object:C1471("letter"; "A"; "value"; 4; "toCol"; 4; "toAvg"; 4); \
New object:C1471("letter"; "B"; "value"; 5; "toCol"; 5; "toAvg"; 5); \
New object:C1471("letter"; "C"; "value"; 6; "toCol"; 6; "toAvg"; 6))

ds:C1482.Test.fromCollection($collection)

// do the test

var $F; $result; $selection : Object

$F:=shoal.functions()

$selection:=ds:C1482.Test.all()

$result:=shoal.frame($selection).groupBy("letter").agg(\
$F.sum("value"); \
$F.sumDistinct("value").as("sumDistinct"); \
$F.col("toCol"); \
$F.set("toCol").as("aSet"); \
$F.avg("toAvg"); \
$F.count("toCount"); \
$F.countDistinct("toCol").as("distinctCount"); \
$F.max("value").as("maxOfValue"); \
$F.min("toCol").as("minToCol"); \
$F.first("toCol").as("firstToCol"); \
$F.last("toCol").as("lastToCol"))

ASSERT:C1129(OB Entries:C1720($result).length=3; "Invalid number of group")

var $key : Text
For each ($key; $result)
	
	ASSERT:C1129(OB Keys:C1719($result[$key]).length=11; "Invalid number of computation for group "+$key)
	
End for each 
