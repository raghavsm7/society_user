import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';

class LogUtils {
  // print log in debug mode
  static printLog({String message = "", String tag = ""}) {
    debugPrint("$tag ---> $message");
  }

  // print log in debug mode
  static printLogViaDeveloper({String message = "", String tag = "", String error = ""}) {
    developer.log(message, name: tag, error: error);
  }
}
