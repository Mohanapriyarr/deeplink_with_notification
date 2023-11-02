import 'package:flutter_test/flutter_test.dart';

import 'validator_testing.dart';

void main() {
  group('Login', () {
    test('empty email test', () {
      final fieldValidator = FieldValidator();
      var result = fieldValidator.validateEmail('');
      expect(result, 'Please enter email');
    });

    test('valid email test', () {
      final fieldValidator = FieldValidator();
      var result = fieldValidator.validateEmail('mohana@gmail.com');
      expect(result, 'Email is valid');
    });

    test('empty password test', () {
      final fieldValidator = FieldValidator();
      var result = fieldValidator.passwordValidation('');
      expect(result, 'Please enter password');
    });

    test('valid password test', () {
      final fieldValidator = FieldValidator();
      var result = fieldValidator.passwordValidation('Mohana@123');
      expect(result, 'Password is valid');
    });
  });
}
