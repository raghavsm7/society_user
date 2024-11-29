import 'package:fl_sevengen_society_user_app/screens/auth/login/controller/login_controller.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/register/controller/register_controller.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/register/model/enter_details_request_model.dart';
import 'package:fl_sevengen_society_user_app/utils/date_utils.dart';
import 'package:get/get.dart';

import 'app_constants.dart';

class AppValidator {
  static final AppValidator _appValidator = AppValidator();

  static AppValidator get appValidatorInstance => _appValidator;

  final String _emailValidRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  final int _phoneMaxLength = 10;
  final int _nameMinLength = 3;
  final int _flatNumberMinLength = 4;
  final int _flatNumberMaxLength = 10;
  final int _postMinLength = 20;
  final int _societyCodeLength = 5;

// used to check valid email or not
  bool checkValidEmail(String email) {
    RegExp regExp = RegExp(_emailValidRegex);
    return regExp.hasMatch(email.toString().trim());
  }

  //check valid age
  checkValidDob({String? value}) {
    DateTime currentDate = DateTime.now();
    double daysInEighteenYears = 6574;
    DateTime date = DateTime.now();
    DateTime pickedDate = CustomDateUtils.dateUtilsInstance
        .convertStringToDateTime(dateTime: value);
    final difference = currentDate.difference(pickedDate).inDays;
    if (difference < daysInEighteenYears) {
      date = currentDate;
      return true;
    } else {
      date = pickedDate;
      return false;
    }
  }

  // used to check name Validation
  String checkValidName(String value, RegisterController controller) {
    String result = "";

    if (value.length < _nameMinLength) {
      result = "Please enter a valid name";
    } else if (!RegExp(r'^[a-z A-Z,.\-]+$').hasMatch(value)) {
      result = /*controller.appLocal.appvalidator.error.name*/
          "Please enter a valid name";
    }

    return result;
  }

  //used to check valid flat number validation
  String checkValidFlatNumber(String value, RegisterController controller) {
    String result = "";
    if (value.trim().isEmpty) {
      result = "Please enter your flat number";
    }
    /*else if (value.length < _flatNumberMinLength ||
        value.length > _flatNumberMaxLength) {
      result = "Flat number should be minimum 4 digit and maximum 10 digits";
    }*/
    return result;
  }

  //used to check society code validation
  String checkValidSocietyCode(String value, RegisterController controller) {
    String result = "";
    if (value.trim().isEmpty) {
      result = "Please enter your society code.";
    } else if (value.length < _societyCodeLength ||
        value.length > _flatNumberMaxLength) {
      result = "Please enter a valid 5 digit society code.";
    }
    return result;
  }

  //used to check whether password and confirm password are same or not

  String checkConfirmPassword(String confirmPassword,
      RegisterController enterDetailsController, String password) {
    String result = "";
    if (confirmPassword.trim().isEmpty) {
      result = "Please enter confirm password";
    } else if (confirmPassword != password) {
      result = "Password & Confirm Password do not match";
    }
    return result;
  }

  //used to check password validation
  String checkValidPassword(String value) {
    String result = "";
    if (value.trim().isEmpty) {
      result = "Please enter your password";
    } else if (!validatePassword(value)) {
      result =
          "Password should contain at least one upper case,at least one lower case,at least one digit, atleast one special character and minimum 8 character.";
    }
    return result;
  }

  // used to check phone number Validation
  bool checkValidPhoneNumber(String value) {
    bool check = true;
    if (value.length < _phoneMaxLength ||
        (GetUtils.isNumericOnly(value) == false)) {
      check = false;
    }
    return check;
  }

  // if string contains numeric values then it must appears at end, nor at start neither in between
  bool checkNameEndWithDigit(String value) {
    // if it contains numeric values
    if (RegExp(r'^[A-Za-z0-9]+$').hasMatch(value)) {
      var value1 = value.replaceAll(RegExp('[^0-9]'), "");
      var value2 = value.replaceAll(RegExp("[^a-zA-Z]"), "");
      var compare = value2 + value1;
      if (value == compare) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    } // if not contains
  }

// password validation
//  (?=.*[A-Z])        should contain at least one upper case
//  (?=.*[a-z])        should contain at least one lower case
//  (?=.*?[0-9])           should contain at least one digit
//  (?=.*?[!@#\$&*~]).{8,} // should contain at least one Special character and minimum 8 character

  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  // used to check otp Validation
  bool checkValidOTP(String otp) {
    bool check = true;
    if (otp.length != otpLength || (GetUtils.isNumericOnly(otp) == false)) {
      check = false;
    }
    return check;
  }

  String validateRegisterPage(
      RegisterDetailsRequestModel registerDetailsRequestModel,
      RegisterController controller) {
    String result = "";

    // validate name is valid
    if (checkValidName(registerDetailsRequestModel.name ?? "", controller)
            .isNotEmpty ==
        true) {
      return result =
          checkValidName(registerDetailsRequestModel.name ?? "", controller);
    }

    //validate flat number
    if (checkValidFlatNumber(
                registerDetailsRequestModel.flatNumber ?? "", controller)
            .isNotEmpty ==
        true) {
      return result = checkValidFlatNumber(
          registerDetailsRequestModel.flatNumber ?? "", controller);
    }

    //validate society code
    if (checkValidSocietyCode(
                registerDetailsRequestModel.societyCode ?? "", controller)
            .isNotEmpty ==
        true) {
      return result = checkValidSocietyCode(
          registerDetailsRequestModel.societyCode ?? "", controller);
    }

    //validate password
    if (checkValidPassword(registerDetailsRequestModel.password ?? "")
            .isNotEmpty ==
        true) {
      return result =
          checkValidPassword(registerDetailsRequestModel.password ?? "");
    }

    //validate confirm password
    if (checkConfirmPassword(registerDetailsRequestModel.cnfPassword ?? "",
                controller, registerDetailsRequestModel.password ?? "")
            .isNotEmpty ==
        true) {
      return result = checkConfirmPassword(
          registerDetailsRequestModel.cnfPassword ?? "",
          controller,
          registerDetailsRequestModel.password ?? "");
    }
    return result;
  }

  String validateLogInPage(
      String phoneNumber, String password, LogInController controller) {
    String result = "";

    //validate password
    if (checkValidPassword(password ?? "").isNotEmpty == true) {
      return result = checkValidPassword(password ?? "");
    }
    return result;
  }

  //used to check password validation
  String checkValidPost(String value, String titleValue) {
    String result = "";
   /*  if (titleValue.trim().isEmpty) {
    result = "Post title cannot be empty.";
    }
    else*/ if (value.trim().isEmpty) {
      result = "Please brief your post.Post cannot be empty.";
    } else if (value.length < _postMinLength) {
      result = "Post should be at least 20 character long.";
    }
    return result;
  }
}
