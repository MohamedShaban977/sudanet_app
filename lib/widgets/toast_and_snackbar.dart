import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastAndSnackBar {
  static toastError({required String message}) {
    return Fluttertoast.showToast(
      msg: message,
      fontSize: 18,
      backgroundColor: Colors.redAccent,
      gravity: ToastGravity.SNACKBAR,
      textColor: Colors.white,
      timeInSecForIosWeb: 10,
    );
  }

  static toastSuccess({required String message}) {
    return Fluttertoast.showToast(
      msg: message,
      fontSize: 18,
      backgroundColor: Colors.green,
      gravity: ToastGravity.SNACKBAR,
      textColor: Colors.white,
      timeInSecForIosWeb: 5,
    );
  }

  static showSnackBarError(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  static showSnackBaSuccess(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}
