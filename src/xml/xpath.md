## XPath

### Expressions

* `nodename`
	* Selects all nodes with the name "nodename"
* `/`
	* Selects from the root node
* `//`
	* Selects nodes in the document from the current node that match the selection no matter where they are 
* `.`
	* Selects the current node
* `..`
	* Selects the parent of the current node
* `@`
	* Selects attributes
* `*` 
	* Matches any element node
* `@*`
	* Matches any attribute node
* node()
	* Matches any node of any kind
* <expression1>|<expression2>
	* Selects the nodes that match expression1 and the ones that match expression2

### Predicates

* /bookstore/book[1] 
* /bookstore/book[last()]
* /bookstore/book[last()-1]
* /bookstore/book[position()<3]
* //title[@lang]
	* Selects all the title elements that have an attribute named lang
* //title[@lang='en']
* /bookstore/book[price>35.00]
* /bookstore/book[price>35.00]/title
