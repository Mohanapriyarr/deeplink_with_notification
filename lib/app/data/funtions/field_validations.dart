mixin FieldValidations {
  String? emptyValidation(String value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please Enter $fieldName';
    }
    return null;
  }

  /// ## Email Validation
  /// * check null or is empty
  /// * trim
  /// * done not match regex pattern
  String? emailValidation(email) {
    String emailValidationPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp emailRegExp = RegExp(emailValidationPattern);

    if (email == null || email.isEmpty) {
      return 'Please enter email';
    }

    final _email = email.trim();

    if (!emailRegExp.hasMatch(_email)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// ## Password Validation
  /// * check null or is empty
  /// * trim
  /// * length less than 8
  String? passwordValidation(String? password, String? name) {
    String passValid =
        r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.* ).{1,16}$';
    RegExp passRegexValid = RegExp(passValid);

    if (password == null || password.isEmpty) {
      return name;
    }

    final _password = password.trim();

    if (!passRegexValid.hasMatch(_password)) {
      return 'Password must have at least one number, one lowercase, one uppercase character and one special character';
    }

    if (_password.length < 8) {
      return 'Password must have at least 8 characters';
    }

    return null;
  }

  String? confirmPasswordValidation(String password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please enter Confirm Password';
    }

    final _confirmPassword = confirmPassword.trim();

    if (password != _confirmPassword) {
      return 'Password and Confirm Password does not match';
    }
    return null;
  }

  String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    } else if (value.length > 10) {
      return 'Please enter valid mobile number';
    }

    return null;
  }
}
