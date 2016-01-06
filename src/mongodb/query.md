# Query

Select all docs.

	db.inventory.find( {} )

Select all with type = snacks.

	{ type: "snacks" }

Select all with type either 'snacks' or 'food'.

	{ type: { $in: [ 'food', 'snacks' ] } }

Price less than 9.95

	{ type: 'food', price: { $lt: 9.95 } }

Or

	{ $or: [ { qty: { $gt: 100 } }, { price: { $lt: 9.95 } } ] }

And combined with or

	{ 
		type: 'food',
		$or: [ { qty: { $gt: 100 } }, { price: { $lt: 9.95 } } ]
	}

Embedded documents

	{
		producer:
		{
			company: 'ABC123',
			address: '123 Street'
		}
	}

# Query Selectors

## Comparison

* $eq
	* Matches values that are equal to a specified value.
* $gt	
	* Matches values that are greater than a specified value.
* $gte	
	* Matches values that are greater than or equal to a specified value.
* $lt	
	* Matches values that are less than a specified value.
* $lte	
	* Matches values that are less than or equal to a specified value.
* $ne	
	* Matches all values that are not equal to a specified value.
* $in	
	* Matches any of the values specified in an array.
* $nin	
	* Matches none of the values specified in an array.

## Logical
* $or	
	* Joins query clauses with a logical OR returns all documents that match the conditions of either clause.
* $and	
	* Joins query clauses with a logical AND returns all documents that match the conditions of both clauses.
* $not	
	* Inverts the effect of a query expression and returns documents that do not match the query expression.
* $nor	
	* Joins query clauses with a logical NOR returns all documents that fail to match both clauses.

## Element

* $exists	
	* Matches documents that have the specified field.

* $type	
	* Selects documents if a field is of the specified type.

## Array

* $all	
	* Matches arrays that contain all elements specified in the query.

* $elemMatch	
	* Selects documents if element in the array field matches all the specified $elemMatch conditions.

* $size	
	* Selects documents if the array field is a specified size.


## References

<https://docs.mongodb.org/manual/>
<https://docs.mongodb.org/manual/reference/operator/query/elemMatch/>
