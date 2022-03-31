//%attributes = {}
var $collection : Collection
var $ƒ; $result : Object
$ƒ:=shoal.functions()

// MARK: setup data frame
$collection:=New collection:C1472(\
New object:C1471("letter"; "A"; "value"; 1; "toCol"; 1; "toAvg"; 1); \
New object:C1471("letter"; "B"; "value"; 2; "toCol"; 2; "toAvg"; 2; "toCount"; 2); \
New object:C1471("letter"; "C"; "value"; 3; "toCol"; 3; "toAvg"; 3); \
New object:C1471("letter"; "A"; "value"; 4; "toCol"; 4; "toAvg"; 4); \
New object:C1471("letter"; "B"; "value"; 5; "toCol"; 5; "toAvg"; 5); \
New object:C1471("letter"; "C"; "value"; 6; "toCol"; 6; "toAvg"; 6))

var $frame : cs:C1710.DataFrame
$frame:=shoal.frame($collection)

// MARK: get some infos

ASSERT:C1129(Not:C34($frame.isEmpty))
ASSERT:C1129($frame.shape.rows=6)
ASSERT:C1129($frame.shape.cols=5)

var $summary : cs:C1710.DataFrame
$summary:=$frame.summary()

ASSERT:C1129($summary.shape.rows=5)  // nb of columns

// MARK: apply a group by
$result:=$frame.groupBy("letter").agg(\
$ƒ.sum("value"); \
$ƒ.sumDistinct("value").as("sumDistinct"); \
$ƒ.col("toCol"); \
$ƒ.set("toCol").as("aSet"); \
$ƒ.avg("toAvg"); \
$ƒ.count("toCount"); \
$ƒ.countDistinct("toCol").as("distinctCount"); \
$ƒ.max("value").as("maxOfValue"); \
$ƒ.min("toCol").as("minToCol"); \
$ƒ.first("toCol").as("firstToCol"); \
$ƒ.last("toCol").as("lastToCol"))

ASSERT:C1129(OB Entries:C1720($result).length=3; "Invalid number of group")

var $key : Text
For each ($key; $result)
	
	ASSERT:C1129(OB Keys:C1719($result[$key]).length=11; "Invalid number of computation for group "+$key)
	
End for each 

$result:=$result.asDataFrame("letter")
ASSERT:C1129($result.length=3; "Invalid number of group")

var $row : Object
For each ($row; $result.data)
	
	ASSERT:C1129(OB Keys:C1719($row).length=12; "Invalid number of computation for group "+$row["letter"])
	
End for each 

// MARK: apply a group by but flatten

$result:=$frame.groupBy("letter").flatten().agg(\
$ƒ.sum("value"); \
$ƒ.sumDistinct("value").as("sumDistinct"); \
$ƒ.col("toCol"); \
$ƒ.set("toCol").as("aSet"); \
$ƒ.avg("toAvg"); \
$ƒ.count("toCount"); \
$ƒ.countDistinct("toCol").as("distinctCount"); \
$ƒ.max("value").as("maxOfValue"); \
$ƒ.min("toCol").as("minToCol"); \
$ƒ.first("toCol").as("firstToCol"); \
$ƒ.last("toCol").as("lastToCol"))

ASSERT:C1129($result.length=3; "Invalid number of group")

var $row : Object
For each ($row; $result.data)
	
	ASSERT:C1129(OB Keys:C1719($row).length=12; "Invalid number of computation for group "+$row["letter"])
	
End for each 

// MARK: test each functions one by one

$result:=$frame.groupBy("letter").sums("value"; "sum")
ASSERT:C1129(OB Entries:C1720($result).length=3; "Invalid number of group")

ASSERT:C1129($result["A"]["sum"]=(1+4))
ASSERT:C1129($result["B"]["sum"]=(2+5))
ASSERT:C1129($result["C"]["sum"]=(3+6))

$result:=$frame.groupBy("letter").flatten().sums("value"; "sum")
ASSERT:C1129($result.length=3; "Invalid number of group")

ASSERT:C1129($result.query("letter = :1"; "A")[0]["sum"]=(1+4))
ASSERT:C1129($result.query("letter = :1"; "B")[0]["sum"]=(2+5))
ASSERT:C1129($result.query("letter = :1"; "C")[0]["sum"]=(3+6))

$result:=$frame.groupBy("letter").sumsDistinct("value"; "sumDistinct")
ASSERT:C1129(OB Entries:C1720($result).length=3; "Invalid number of group")

ASSERT:C1129($result["A"]["sumDistinct"]=(1+4))
ASSERT:C1129($result["B"]["sumDistinct"]=(2+5))
ASSERT:C1129($result["C"]["sumDistinct"]=(3+6))

$result:=$frame.groupBy("letter").averages("value"; "avg")
ASSERT:C1129(OB Entries:C1720($result).length=3; "Invalid number of group")

ASSERT:C1129($result["A"]["avg"]=((1+4)/2))
ASSERT:C1129($result["B"]["avg"]=((2+5)/2))
ASSERT:C1129($result["C"]["avg"]=((3+6)/2))

$result:=$frame.groupBy("letter").minimums("value"; "min")
ASSERT:C1129(OB Entries:C1720($result).length=3; "Invalid number of group")

ASSERT:C1129($result["A"]["min"]=1)
ASSERT:C1129($result["B"]["min"]=2)
ASSERT:C1129($result["C"]["min"]=3)

$result:=$frame.groupBy("letter").maximums("value"; "max")
ASSERT:C1129(OB Entries:C1720($result).length=3; "Invalid number of group")

ASSERT:C1129($result["A"]["max"]=4)
ASSERT:C1129($result["B"]["max"]=5)
ASSERT:C1129($result["C"]["max"]=6)

$result:=$frame.groupBy("letter").first("value"; "first")
ASSERT:C1129(OB Entries:C1720($result).length=3; "Invalid number of group")

ASSERT:C1129($result["A"]["first"]=1)
ASSERT:C1129($result["B"]["first"]=2)
ASSERT:C1129($result["C"]["first"]=3)

$result:=$frame.groupBy("letter").last("value"; "last")
ASSERT:C1129(OB Entries:C1720($result).length=3; "Invalid number of group")

ASSERT:C1129($result["A"]["last"]=4)
ASSERT:C1129($result["B"]["last"]=5)
ASSERT:C1129($result["C"]["last"]=6)

$result:=$frame.groupBy("letter").orderBy("toCol desc").first("value"; "first")
ASSERT:C1129(OB Entries:C1720($result).length=3; "Invalid number of group")

ASSERT:C1129($result["A"]["first"]=4)
ASSERT:C1129($result["B"]["first"]=5)
ASSERT:C1129($result["C"]["first"]=6)

$result:=$frame.groupBy("letter").orderBy("toCol desc").last("value"; "last")
ASSERT:C1129(OB Entries:C1720($result).length=3; "Invalid number of group")

ASSERT:C1129($result["A"]["last"]=1)
ASSERT:C1129($result["B"]["last"]=2)
ASSERT:C1129($result["C"]["last"]=3)

$result:=$frame.groupBy("letter").counts("value"; "count")
ASSERT:C1129(OB Entries:C1720($result).length=3; "Invalid number of group")

ASSERT:C1129($result["A"]["count"]=2)
ASSERT:C1129($result["B"]["count"]=2)
ASSERT:C1129($result["C"]["count"]=2)

$result:=$frame.groupBy("letter").countsDistinct("value"; "countDistinct")
ASSERT:C1129(OB Entries:C1720($result).length=3; "Invalid number of group")

ASSERT:C1129($result["A"]["countDistinct"]=2)
ASSERT:C1129($result["B"]["countDistinct"]=2)
ASSERT:C1129($result["C"]["countDistinct"]=2)
