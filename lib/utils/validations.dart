import 'package:expense_tracker/models/category_model.dart';

class Validations {
  static String? notNullValidation(String value) {
    if (value == '') {
      return 'Required field.';
    }

    return null;
  }
}