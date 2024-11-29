import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumberFormatUtils {
  static final NumberFormatUtils _numberFormatUtils = NumberFormatUtils();

  static NumberFormatUtils get numberFormatUtilsInstance => _numberFormatUtils;

  var _locale = const Locale("en", "US");
  var _stringLocale = "en_US";

  // update locale
  void updateLocale({String languageCode = "en", String countryCode = "US"}) {
    _locale = Locale(languageCode, countryCode);
    _stringLocale = "${languageCode}_$countryCode";
  }

  // get currency symbol
  String getCurrencySymbol() {
    var format = NumberFormat.simpleCurrency(locale: _locale.toString());
    return format.currencySymbol;
  }

  // get currency name
  String getCurrencyName() {
    var format = NumberFormat.simpleCurrency(locale: _locale.toString());
    return format.currencyName!;
  }

  // format price with currency name
  String formatPriceWithName({String currencyCode = "", num price = 0.0}) {
    if (currencyCode.isNotEmpty == true) {
      return NumberFormat.currency(name: currencyCode).format(price);
    } else {
      return NumberFormat.currency(locale: _stringLocale).format(price);
    }
  }

  //format price with currency symbol
  String formatPriceWithSymbol({String currencyCode = "", num price = 0.0}) {
    if (currencyCode.isNotEmpty == true) {
      return NumberFormat.simpleCurrency(name: currencyCode).format(price);
    } else {
      return NumberFormat.simpleCurrency(locale: _stringLocale).format(price);
    }
  }
}
