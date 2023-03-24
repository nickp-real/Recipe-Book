/// class for Validator Email and Password
class Validator {
  static String? email(String? value) {
    final pattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || value.isEmpty || !pattern.hasMatch(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a password";
    }
    return null;
  }
}
