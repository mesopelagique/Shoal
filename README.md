# Shoal

Split your data into separate groups to perform computations such as `sum`, `min`, `max`, `count`, etc.... for better analysis.

## Usage

Create the data frame object from a collection of object or an entity selection:

```4d
$collection:=New collection(\
New object("letter"; "A"; "value"; 1); New object("letter"; "B"; "value"; 2); New object("letter"; "C"; "value"; 3); \
New object("letter"; "A"; "value"; 4); New object("letter"; "B"; "value"; 5); New object("letter"; "C"; "value"; 6))

$dataFrame:=shoal.frame($collection)
```

Then group by choosing a column and apply aggregate functions:

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

with `$F` the functions builder that you can instanciate one time.

```4d
$F:=shoal.functions()
```

## List of functions

- $F.sum: the sum
- $F.sumDistinct: the sum of distinct element
- $F.min: the minimum
- $F.max: the maximum
- $F.avg (or $F.mean): the average

- $F.first: the first element
- $F.last: the last element

- $F.count: the number of not NULL element
- $F.countDistinct: the number of distinct and not NULL element
- $F.col: all values
- $F.set: distinct values

## column name alias

Use `as` to rename the column in result. Mandatory if you make multiple computations for the same column.

```4d
 .agg($F.sum("value").as("SumOfValue)
```

## Install

### With [kaluza-cli](https://mesopelagique.github.io/kaluza-cli/) on macOS

Inside your database root path using the terminal

```bash
# kaluza init # (if never done before)
kaluza install mesopelagique/Shoal
```

## TODO

- [X] support selection
- [ ] more functions (standard deviation and variance, skewness, kurtosis, ..., first not null, last not null) = implement it or request to be implemented by 4D (with more efficiency)
- [ ] multiple columns group by
- [ ] result into a collection instead of object (ie. have different way to output grouped data)

![logo](logo.png)
