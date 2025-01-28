import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Utils {
  static errorToast(dynamic str) {
    Fluttertoast.showToast(
        msg: str,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 13.0);
  }

  static handleError(dynamic e, {StackTrace? s}) async {
    if (kDebugMode) {
      print(e.toString());
      print(s);
    }
    errorToast(e.toString());
  }

  static final DateFormat dateTimeFormat = DateFormat('dd.MM.yyyy');

  DateTime? convertStringToDate(String dateString) {
    try {
      return dateTimeFormat.parse(dateString, true);
    } catch (e) {
      return null;
    }
  }

  String convertDateToString(DateTime date) {
    try {
      return dateTimeFormat.format(date);
    } catch (e) {
      return '';
    }
  }
}

final utils = Utils();
