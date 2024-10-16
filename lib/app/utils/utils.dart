import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_theme.dart';
import 'custom_loading_indicators/loading_indicators.dart';

class Utils {
  Utils._();

    static void showProgressDialog(BuildContext context) {
    Get.dialog(
        const Center(
          child: LoadingIndicators(),
        ),
        barrierDismissible: false);
  }
  static void showLongToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void showErrorDialog(
      {required BuildContext context,
      required String message,
      void Function()? onPressed}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Error',
          style: AppTextStyle.text16w500.copyWith(color: AppColor.redColor),
        ),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: onPressed,
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static void showLongErrorToast({required String message}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColor.redColor);
  }

  static void showShortToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void showShortErrorToast({required String message}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColor.redColor);
  }
  }