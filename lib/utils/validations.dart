class Validations {
  static String? notNullValidation(String value) {
    if (value == '') {
      return 'Required field.';
    }

    return null;
  }
}