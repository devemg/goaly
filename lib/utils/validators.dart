bool isPasswordValid(String password) {
  // At least 6 chars, 1 mayus and 1 number
  return RegExp(r'^(?=.*[A-Z])(?=.*[0-9]).{6,}$').hasMatch(password);
}

bool isEmail(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}