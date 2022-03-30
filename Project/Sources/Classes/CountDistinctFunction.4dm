
Class extends AggFunction

Function call($colOrSel : Variant)->$result : Variant
	$result:=$colOrSel.distinct(This:C1470.field).length  // XXX could be speed up if collection provide it...