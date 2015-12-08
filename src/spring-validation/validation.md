# Validation

## Big Picture

Validation as business logic ? Yes and no. 
* Validation should not be tied to the web tier, 
* should be easy to localize 
* it should be possible to plug in any validator available. 

Spring has come up with a `Validator` interface that is both basic and eminently usable in every layer of an application.

`DataBinder` allows user input to be dynamically bound to the domain model of an application.

The `Validator` and the `DataBinder` make up the validation package.

 
A `Validator` validates an object and store the outcome in an `Error` object.

	org.springframework.validation.Validator
		supports(Class) // Can this Validator validate instances of the supplied Class?
		validate(Object, org.springframework.validation.Errors) // Validates the given object and in case of validation errors, registers those with the given Errors object
		
You can implement a `Validator` leveraging the `ValidationUtils`.  
		
	public class PersonValidator implements Validator {
	
	    /**
	     * This Validator validates *just* Person instances
	     */
	    public boolean supports(Class clazz) {
	        return Person.class.equals(clazz);
	    }
	
	    public void validate(Object obj, Errors e) {
	        ValidationUtils.rejectIfEmpty(e, "name", "name.empty");
	        Person p = (Person) obj;
	        if (p.getAge() < 0) {
	            e.rejectValue("age", "negativevalue");
	        } else if (p.getAge() > 110) {
	            e.rejectValue("age", "too.darn.old");
	        }
	    }
	}
	
`MessageCodesResolver` and `DefaultMessageCodesResolver` are typically used to resolve error codes.
	
Validator for embedded complex properties.

    public void validate(Object target, Errors errors) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstName", "field.required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "surname", "field.required");
        Customer customer = (Customer) target;
        try {
            errors.pushNestedPath("address");
            ValidationUtils.invokeValidator(this.addressValidator, customer.getAddress(), errors);
        } finally {
            errors.popNestedPath();
        }
    }
    

# JSR-303 Bean Validation API

	public class PersonForm {
	
	    @NotNull
	    @Size(max=64)
	    private String name;
	
	    @Min(0)
	    private int age;
	
	}
	
You need a `JSR-303 Validator` to validate instances of this class.