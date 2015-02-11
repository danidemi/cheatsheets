## Java & XML

### Programmatically check XML validity against an XSD

Code

	public static void main(String[] args) {
		
		// the document being validated
		String xml = "<doc></doc>";
		
		try {
			
			// the xsd
			URL schemaFile = new URL("http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd");
			
			// the xml as Source
			Source xmlSource = new StreamSource(new ByteArrayInputStream(xml.getBytes()));
			
			// a schema factory
			SchemaFactory schemaFactory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
			
			// obtain the schema from the schema factory
			Schema schema = schemaFactory.newSchema(schemaFile);
			
			// get a validator and use it to validate the source
			Validator validator = schema.newValidator();
			validator.validate(xmlSource);
			
			System.out.println(xmlSource.getSystemId() + " is valid");
			
		} catch (SAXException e) {
			
			System.out.println(xml + " is NOT valid");
			System.out.println("Reason: " + e.getLocalizedMessage());
			
		} catch (IOException e) {
			
			e.printStackTrace();
			
		}
	}
