import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

class Utils {
  static toast(dynamic str) {
    Fluttertoast.showToast(
        msg: str.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 15.0);
  }

  static errorToast(dynamic str) {
    Fluttertoast.showToast(
        msg: str,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 13.0);
  }

  static Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    return rootBundle.loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  static handleError(dynamic e, {StackTrace? s}) async {
    if (kDebugMode) {
      print(e.toString());
      print(s);
    }
    errorToast(e.toString());
  }

  static final DateFormat dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm');

  DateTime? convertStringToDate(String dateString) {
    try {
      return dateTimeFormat.parse(dateString, true).toLocal();
    } catch (e) {
      return null;
    }
  }

  String convertDateToString(DateTime? date) {
    try {
      return dateTimeFormat.format(date!.toUtc());
    } catch (e) {
      return '';
    }
  }
}

final utils = Utils();
