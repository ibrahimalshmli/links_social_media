String? validateEmail(String? value) {
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );
  if (value == null || value.isEmpty) {
    return "Please enter your Email";
  } else if (!emailRegex.hasMatch(value)) {
    return "Please enter a valid email address";
  }
  return null;
}

// Password validation (simple example, can be modified for stronger rules)
String? validatePassword(String? value) {
  final passwordRegex = RegExp(
    r'^[A-Za-z0-9]+$',
  ); // Accepts only alphanumeric characters
  if (value == null || value.isEmpty) {
    return "Please enter your Password";
  } else if (!passwordRegex.hasMatch(value)) {
    return "Password should only contain letters and numbers";
  }
  return null;
}
