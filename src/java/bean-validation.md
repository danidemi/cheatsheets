## JSR 349 - Bean Validation

### Quick Example

This is how you can use validation annotations.

	@ValidPassengerCount
	public class Car {

	    @NotNull
	    @Valid
	    private Person driver;

	    @NotNull
	    private String manufacturer;

	    @AssertTrue
	    private boolean isRegistered;

	    public Car(String manufacturer, boolean isRegistered) {
		this.manufacturer = manufacturer;
		this.isRegistered = isRegistered;
	    }

	    @NotNull
	    public String getPlateNumber() {
		return manufacturer;
	    }

	}

	class RentalCar extends Car { // inherits all validations from Car
	}

How to get a Validator and validate the object.

	Set<ConstraintViolation<InfoVersamentoConsensoServizioFirmaGrafometrica>> validate = validator.validate(info);
	if(!validate.isEmpty()){
	    StringBuilder sb = new StringBuilder();
	    for (ConstraintViolation<InfoVersamentoConsensoServizioFirmaGrafometrica> constraintViolation : validate) {
		if(sb.length()>0) sb.append(", ");
		sb.append(constraintViolation.getPropertyPath() + " " + constraintViolation.getMessage());
	    }
	    throw new IllegalArgumentException( "The provided info is invalid. " + sb.toString() );
	}
