# Shoal

Group data by columns and make computation such as `sum`

## Usage

Create the data frame object from your collection of object

```4d
$collection:=New collection(\
New object("letter"; "A"; "value"; 1); New object("letter"; "B"; "value"; 2); New object("letter"; "C"; "value"; 3); \
New object("letter"; "A"; "value"; 4); New object("letter"; "B"; "value"; 5); New object("letter"; "C"; "value"; 6))

$dataFrame:=shoal.frame($collection)
```

Then group by a chosen column and apply aggregate functions

```4d
$result:=$dataFrame.groupBy("letter").agg($F.sum("value"); $F.max("value").as("maxValue"))
```

```json
{
 "A": {"value":5, "maxValue":4},
 "B": {"value":7, "maxValue":5},
 "C": {"value":9, "maxValue":6}
}
```

with `$F` the functions builder that you can instanciate one time

```4d
$F:=shoal.functions()
```

## List of functions

- $F.sum
- $F.sumDistinct
- $F.col
- $F.set
- $F.avg (or $F.mean)  
- $F.count
- $F.countDistinct
- $F.min
- $F.max
- $F.first
- $F.last

## column name alias

Use `as` to rename the column in result. Mandatory if you make multiple computations for the same column.

```4d
 .agg($F.sum("value").as("SumOfValue)
```

## TODO

- support selection? (with or without using `toCollection`)
- more functions (standard deviation and variance, skewness, kurtosis, ...)
- multiple columns group by
