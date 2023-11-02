class FieldValidator {
  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter email';
    }

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailValid) {
      return 'Enter Valid Email';
    }
    return 'Email is valid';
  }

  String? passwordValidation(String? password) {
    String passValid =
        r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.* ).{8,16}$';
    RegExp passRegexValid = RegExp(passValid);

    if (password == null || password.isEmpty) {
      return 'Please enter password';
    }

    final _password = password.trim();

    if (!passRegexValid.hasMatch(_password)) {
      return 'Password must have at least one number, one lowercase, one uppercase character and one special character';
    }

    if (_password.length < 8) {
      return 'Please enter password greater than 8 characters';
    }

    return "Password is valid";
  }
}
