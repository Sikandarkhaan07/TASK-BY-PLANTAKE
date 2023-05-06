import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

class Utility {
  static double averageRating(List<int> rating) {
    var avgRating = 0;
    for (var i = 0; i < rating.length; i++) {
      avgRating = avgRating + rating[i];
    }
    return double.parse((avgRating / rating.length).toStringAsFixed(1));
  }

  static toastMessage(String message, BuildContext context) {
    var snack = SnackBar(
      content: Text(message),
      elevation: 5,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  static flustBarMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(5),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        reverseAnimationCurve: Curves.easeInOut,
        message: message,
        backgroundColor: Colors.black,
        duration: const Duration(seconds: 3),
      )..show(context),
    );
  }

  static void fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode next,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }
}
