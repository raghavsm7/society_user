import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:intl/intl.dart';

class CustomDateUtils {
  static final CustomDateUtils _dateUtils = CustomDateUtils();

  static CustomDateUtils get dateUtilsInstance => _dateUtils;

  DateFormat defaultServerDateFormat = DateFormat("yyyy-MM-dd");
  DateFormat apiDateFormat = DateFormat("dd-MM-yyyy");

  DateFormat timeToSlotTime = DateFormat("HH:mm:ss");
  DateFormat timeFormat = DateFormat("hh:mm a");

  DateFormat appSlotTime1Format = DateFormat("hh:mm:ss");
  DateFormat appSlotTime2Format = DateFormat("MMMM yyyy");

  DateFormat appSlotTimeFormat = DateFormat("HH:mm");

  /// to convert like Jan 26, 2021
  //DateFormat userDisplayFormat = DateFormat("MMM dd, yyyy");
  DateFormat userDisplayFormat = DateFormat("dd MMM yyyy");

  DateFormat dateFormat = DateFormat("MM-dd-yyyy");

  DateFormat appTimeFormat = DateFormat("h:mm a");

  DateFormat defaultServerDateTimeFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateFormat defaultServerDateTimeFormatAM = DateFormat("d/M/yy h:mm a");

 // DateFormat defaultServerDateTimeFormatAM = DateFormat("yyyy-MM-dd h:mm:ss a");

  DateFormat dateOfBirthFormat = DateFormat('dd/MM/yyyy HH:mm');


  // convert date time to String
  String convertDateTimeToDefaultServerDateFormat({DateTime? dateTime}) {
    return defaultServerDateFormat.format(dateTime!);
  }

  // convert string to date time
  DateTime convertStringToDefaultServerDateFormat({String? dateTime}) {
    return defaultServerDateFormat.parse(dateTime!);
  }

  // convert date time to String
  String convertDateTimeToStringFormat({required DateTime dateTime}) {
    return dateFormat.format(dateTime);
  }

  // convert date time to String
  String convertDateTimeToStringApiFormat({required DateTime dateTime}) {
    return apiDateFormat.format(dateTime);
  }

  // convert date time to String
  String convertDateTimeToTimeStringFormat({DateTime? dateTime}) {
    return timeFormat.format(dateTime!).replaceAll("AM", "am")
        .replaceAll("PM", "pm");
  }

// to convert string to string like Jan 26, 2021
  String convertDateTimeStringToOrderPlacedDateFormat(String? orderPlacedDate) {
    if (GetUtils.isNullOrBlank(orderPlacedDate) == true) {
      return "";
    } else {
      DateTime datetime = DateTime.parse(orderPlacedDate!);
      return userDisplayFormat.format(datetime);
    }
  }

  //to send data to server while api call
  String convertDateTimeToDefaultServerDateTimeFormat({DateTime? dateTime}) {
    if (GetUtils.isNullOrBlank(dateTime) == true) {
      return "";
    } else {
      return defaultServerDateTimeFormat.format(dateTime!);
    }
  }

  // convert date to show on front end format
  String convertDateTimeToDefaultServerTimeFormat({DateTime? dateTime}) {
    return appTimeFormat.format(dateTime!);
  }

  DateTime convertStringToDefaultServerTimeFormat({String? dateTime}) {
    return appTimeFormat.parse(dateTime!);
  }

  String convertStringToSlotTimeFormat({String? dateTime}) {
    DateTime date = appSlotTime1Format.parse(dateTime!);
    return appSlotTimeFormat.format(date);
  }
  // convert  String to dateTime
  DateTime convertStringToDateTime({String? dateTime}) {
    return defaultServerDateTimeFormat.parse(dateTime!);
  }



  /// Converts the duration into a readable string
  /// 05:15
  String toHoursMinutes({Duration? duration}) {
    String twoDigitMinutes = _toTwoDigits(duration!.inMinutes.remainder(60));
    return "${_toTwoDigits(duration.inHours)}:$twoDigitMinutes";
  }

  /// Converts the duration into a readable string
  /// 05:15:35
  String toHoursMinutesSeconds({Duration? duration}) {
    String twoDigitMinutes = _toTwoDigits(duration!.inMinutes.remainder(60));
    String twoDigitSeconds = _toTwoDigits(duration.inSeconds.remainder(60));
    return "${_toTwoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String _toTwoDigits(int n) {
    if (n >= 10) return "$n";
    if (n < 0) return "$n";
    return "0$n";
  }

  String convertDateTimeToUserDisplayFormat(DateTime dateTime) {
    return userDisplayFormat.format(dateTime);
  }

  showFormattedDate(String date, {bool isForTitle= false}) {
    String formattedDate="";
    DateTime dateTime = DateTime.parse(date);
    /*CustomDateUtils.dateUtilsInstance
        .convertDateTimeStringToOrderPlacedDateFormat(dateTime: date)*/
    if (isForTitle) {
      formattedDate = CustomDateUtils.dateUtilsInstance
          .convertDateTimeToMonthYearDisplayFormat(dateTime);
    } else {
      formattedDate = CustomDateUtils.dateUtilsInstance
          .convertDateTimeToUserDisplayFormat(dateTime);
    }
    return formattedDate;
  } //get formatted date

  String convertDateTimeToMonthYearDisplayFormat(DateTime dateTime) {
    return appSlotTime2Format.format(dateTime);
  }

  String convertDateTimeStringToStringDateFormat(String? date) {
    if (GetUtils.isNullOrBlank(date) == true) {
      return "";
    } else {
      DateTime datetime = DateTime.parse(date!).toLocal();
      return defaultServerDateTimeFormatAM
          .format(datetime)
          .replaceAll("AM", "am")
          .replaceAll("PM", "pm");
    }
  }

}

extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == day &&
        now.month == month &&
        now.year == year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }


}


