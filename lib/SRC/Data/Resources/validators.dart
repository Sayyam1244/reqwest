class AppValidators {
  static String? emptyCheck(String? v) {
    if (v == null || v == '') {
      return "Required field";
    } else {
      return null;
    }
  }

  static String? phoneCheck(String? v) {
    if (v == null || v.trim().isEmpty) {
      return "Phone number required";
    } else if (v.length < 8) {
      return "Invalid phone number";
    } else if (v.length > 15) {
      return "Phone number should not exceed 15 digits";
    } else if (!RegExp(r"^\d+$").hasMatch(v)) {
      return "Invalid phone number format.\nOnly numbers are allowed.";
    }
    return null;
  }

  static String? emailCheck(String? v) {
    if (v == null || v.trim().isEmpty) {
      return "Email address required";
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(v)) {
      return "Invalid email format";
    }
    return null;
  }

  static String? passwordCheck(String? v) {
    if (v!.trim().isEmpty || v.length < 6) {
      return "Invalid Password";
    }
    return null;
  }
}
