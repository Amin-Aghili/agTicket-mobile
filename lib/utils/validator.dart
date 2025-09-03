String? usernameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  if (value.length != value.replaceAll(' ', '').length) {
    return 'Username must not contain any spaces';
  }
  if (int.tryParse(value[0]) != null) {
    return 'Username must not start with a number';
  }
  if (value.length <= 2) {
    return 'Username should be at least 3 characters long';
  }
  return null;
}

String? phoneValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  if (value.length != value.replaceAll(' ', '').length) {
    return 'Phone number must not contain any spaces';
  }
  if (value.length < 3) {
    return 'Phone number should not be more than 3 digits';
  }
  if (!RegExp(r'^\d+$').hasMatch(value)) {
    return 'Phone number should be digits only';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  if (value.length != value.replaceAll(' ', '').length) {
    return 'Password must not contain any spaces';
  }
  // if (int.tryParse(value[0]) != null) {
  //   return 'Username must not start with a number';
  // }
  if (value.length <= 2) {
    return 'Password should be at least 3 characters long';
  }
  return null;
}
