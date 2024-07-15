String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{3,}))$';
  RegExp regExp = RegExp(pattern);
  if (value == null || value.isEmpty) {
    return "Email is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid Email";
  } else {
    return null;
  }
}

String? validateOfficeName(String? value) {
  if (value == null || value.isEmpty) {
    return "Office name is required";
  }
  if (value.length < 2 || value.length > 100) {
    return "Office name must be between 2 and 100 characters long";
  }
  if (!RegExp(r'^[a-zA-Z0-9\s\-]+$').hasMatch(value)) {
    return "Office name must contain only alphanumeric characters, spaces, and hyphens";
  }
  return null;
}

String? validateOfficeAddress(String? value) {
  if (value == null || value.isEmpty) {
    return "Office address is required";
  }
  if (value.length < 5 || value.length > 100) {
    return "Office address must be between 5 and 100 characters long";
  }
  if (!RegExp(r'^[a-zA-Z0-9\s,.\-\#]+$').hasMatch(value)) {
    return "Office address must contain only alphanumeric characters, spaces, and common address symbols (,.-'#)";
  }
  return null;
}

String? validateOfficeCapacity(String? value) {
  if (value == null || value.isEmpty) {
    return "Office capacity is required";
  }
  int? capacity = int.tryParse(value);
  if (capacity == null) {
    return "Office capacity must be a valid number";
  }
  if (capacity <= 5) {
    return "Office capacity must be a 5 member";
  }
  if (capacity > 1000) { // Adjust this limit as needed
    return "Office capacity must not exceed 1000";
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return "Phone number is required";
  }

  // Define the pattern for a valid phone number
  final RegExp phoneRegex = RegExp(r'^[0-9]{10}$');

  if (!phoneRegex.hasMatch(value)) {
    return "Please enter a valid 10-digit phone number";
  }

  return null;
}

String? validateFirstName(String? value) {
  if (value == null || value.isEmpty) {
    return "First name is required";
  }


  final RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');

  if (!nameRegex.hasMatch(value)) {
    return "Please enter a valid first name";
  }

  return null;
}
String? validateLastName(String? value) {
  if (value == null || value.isEmpty) {
    return "Last name is required";
  }


  final RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');

  if (!nameRegex.hasMatch(value)) {
    return "Please enter a valid last name";
  }

  return null;
}




