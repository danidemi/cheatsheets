# Hibernate 5.x

Hibernate Validator 5.x is the reference implementation Bean Validation 1.1!

# Big Picture

Add constraints to classes through 
* annotation 
* [XML defined cosntraints](https://docs.jboss.org/hibernate/validator/5.0/reference/en-US/html/chapter-xml-configuration.html#section-mapping-xml-constraints)

# Message Interpolation

## Bundles As Sources Of The Errors

Resource bundle `ValidationMessages` in classpath.

More in general...

* `ValidationMessages.properties`
* `ValidationMessages_en_US.properties`
* `ValidationMessages_<Locale#getDefault()>.properties`

For instance, this is how the `@CreditCardNumber` is defined, its default message descriptor is `{org.hibernate.validator.constraints.CreditCardNumber.message}` which will be resolved in the bundle.
 
	public @interface CreditCardNumber {
		String message() default "{org.hibernate.validator.constraints.CreditCardNumber.message}";

Examples of message bundles 

`/org/hibernate/validator/ValidationMessages.properties`

	javax.validation.constraints.AssertFalse.message = must be false
	javax.validation.constraints.AssertTrue.message  = must be true
	javax.validation.constraints.DecimalMax.message  = must be less than ${inclusive == true ? 'or equal to ' : ''}{value}
	javax.validation.constraints.DecimalMin.message  = must be greater than ${inclusive == true ? 'or equal to ' : ''}{value}
	javax.validation.constraints.Digits.message      = numeric value out of bounds (<{integer} digits>.<{fraction} digits> expected)
	javax.validation.constraints.Future.message      = must be in the future
	javax.validation.constraints.Max.message         = must be less than or equal to {value}
	javax.validation.constraints.Min.message         = must be greater than or equal to {value}
	javax.validation.constraints.NotNull.message     = may not be null
	javax.validation.constraints.Null.message        = must be null
	javax.validation.constraints.Past.message        = must be in the past
	javax.validation.constraints.Pattern.message     = must match "{regexp}"
	javax.validation.constraints.Size.message        = size must be between {min} and {max}
	
	org.hibernate.validator.constraints.CreditCardNumber.message        = invalid credit card number
	org.hibernate.validator.constraints.EAN.message                   = invalid {type} barcode
	org.hibernate.validator.constraints.Email.message                   = not a well-formed email address
	org.hibernate.validator.constraints.Length.message                  = length must be between {min} and {max}
	org.hibernate.validator.constraints.LuhnCheck.message               = The check digit for ${validatedValue} is invalid, Luhn Modulo 10 checksum failed
	org.hibernate.validator.constraints.Mod10Check.message              = The check digit for ${validatedValue} is invalid, Modulo 10 checksum failed
	org.hibernate.validator.constraints.Mod11Check.message              = The check digit for ${validatedValue} is invalid, Modulo 11 checksum failed
	org.hibernate.validator.constraints.ModCheck.message                = The check digit for ${validatedValue} is invalid, ${modType} checksum failed
	org.hibernate.validator.constraints.NotBlank.message                = may not be empty
	org.hibernate.validator.constraints.NotEmpty.message                = may not be empty
	org.hibernate.validator.constraints.ParametersScriptAssert.message  = script expression "{script}" didn't evaluate to true
	org.hibernate.validator.constraints.Range.message                   = must be between {min} and {max}
	org.hibernate.validator.constraints.SafeHtml.message                = may have unsafe html content
	org.hibernate.validator.constraints.ScriptAssert.message            = script expression "{script}" didn't evaluate to true
	org.hibernate.validator.constraints.URL.message                     = must be a valid URL
	
	org.hibernate.validator.constraints.br.CNPJ.message                 = invalid Brazilian corporate taxpayer registry number (CNPJ)
	org.hibernate.validator.constraints.br.CPF.message                  = invalid Brazilian individual taxpayer registry number (CPF)
	org.hibernate.validator.constraints.br.TituloEleitoral.message      = invalid Brazilian Voter ID card number


`/org/hibernate/validator/ValidationMessages_es.properties`

	javax.validation.constraints.AssertFalse.message = tiene que ser falso
	javax.validation.constraints.AssertTrue.message  = tiene que ser verdadero
	javax.validation.constraints.DecimalMax.message  = tiene que ser menor ${inclusive == true ? 'o igual que ' : ''}{value}
	javax.validation.constraints.DecimalMin.message  = tiene que ser mayor ${inclusive == true ? 'o igual que ' : ''}{value}
	javax.validation.constraints.Digits.message      = valor num\u00E9rico fuera de los l\u00EDmites (se esperaba <{integer} d\u00EDgitos>.<{fraction} d\u00EDgitos)
	javax.validation.constraints.Future.message      = tiene que ser una fecha en el futuro
	javax.validation.constraints.Max.message         = tiene que ser menor o igual que {value}
	javax.validation.constraints.Min.message         = tiene que ser mayor o igual que {value}
	javax.validation.constraints.NotNull.message     = no puede ser null
	javax.validation.constraints.Null.message        = tiene que ser null
	javax.validation.constraints.Past.message        = tiene que ser una fecha en el pasado
	javax.validation.constraints.Pattern.message     = tiene que corresponder a la expresi\u00F3n regular "{regexp}"
	javax.validation.constraints.Size.message        = el tama\u00F1o tiene que estar entre {min} y {max}
	
	org.hibernate.validator.constraints.CreditCardNumber.message = n\u00FAmero de tarjeta inv\u00E1lido
	org.hibernate.validator.constraints.Email.message            = no es una direcci\u00F3n de correo bien formada
	org.hibernate.validator.constraints.Length.message           = la longitud tiene que estar entre {min} y {max}
	org.hibernate.validator.constraints.NotBlank.message         = no puede estar vac\u00EDo
	org.hibernate.validator.constraints.NotEmpty.message         = no puede estar vac\u00EDo
	org.hibernate.validator.constraints.Range.message            = tiene que estar entre {min} y {max}
	org.hibernate.validator.constraints.SafeHtml.message         = puede tener un contenido html inseguro
	org.hibernate.validator.constraints.ScriptAssert.message     = la expresi\u00F3n "{script}" no se ha evaluado a cierto
	org.hibernate.validator.constraints.URL.message              = tiene que ser una URL v\u00E1lida

## How To Specify Messages

Directly in the annotation

	@NotNull(message = "<message_descriptor>")
	private String manufacturer;
		
* message_descriptor
  * a String
    * "The tax code you entered is wrong"
  * a String with parameters
    * "Your age should not be lower than {min_age}"
  * a String with expression
    * "Your annual income should be lower than ${income * ratio}"
		
1. A parameter is resolved in the bundle.
1. If not resolved, is resolved against the resource bundle offered by the validation provider
   i.e. for Hibernate Validator hibernate-validator-5.2.2.Final-sources.jar, org.hibernate.validator.ValidationMessages
3. If not resolved, it looks whether the contraint has a member with the same name and if yes that value is used.
   i.e. Size#min()) in the error message "must be at least ${min}".
4. Resolve any expresison as an Unified Expression Language (JSR 341). i.e.:
	@Size(
	        min = 2,
	        max = 14,
	        message = "The license plate '${validatedValue}' must be between {min} and {max} characters long"
	)
	private String licensePlate;

Special character escapes

	{ => \{  
	} => \} 
	$ => \$ 
	\ => \\ 
	
`${validatedValue}` is always the value under validation.	


