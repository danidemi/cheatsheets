# Spring-Data MongoDB



# Main Annotations
Main annotations
* @Document
    * A Class that should be managed as a record in MongoDB.
* @Id
    * The field that is used as ‘id‘ in MongoDB.
* @Indexed
    * A field that should be indexed.
* @DBRef
    * Instead of the property, saves a reference to that property.



# Convention Based Mapping

MongoMappingConverter has a few conventions for mapping objects to documents when no additional mapping metadata is provided.
The conventions are:
* The short Java class name is mapped to the collection name in the following manner.
The class ‘com.bigbank.SavingsAccount’ maps to ‘savingsAccount’ collection name.

* All nested objects are stored as nested objects in the document and not as DBRefs

* The converter will use any Spring Converters registered with it to override the default mapping of object
properties to document field/values.

* _The fields_ of an object are used to convert to and from fields in the document. Public JavaBean properties are not used.

* You can have a single non-zero argument constructor whose constructor argument names match top level field names of
document, that constructor will be used.
Otherwise the zero arg constructor will be used. if there is more than one non-zero argument constructor an exception will be thrown.



## References

* [Java/MongoDB mappings](http://docs.spring.io/spring-data/mongodb/docs/current/reference/html/#mapping-conventions)
* [Issue Tracking](https://jira.spring.io/browse/DATAMONGO/?selectedTab=com.atlassian.jira.jira-projects-plugin:summary-panel)
