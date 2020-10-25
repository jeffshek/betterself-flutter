import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

getSuccessSnackbarNotification(BuildContext context, String message) {
  Flushbar(
    title:  "Success!",
    icon: Icon(
      Icons.check,
      size: 28.0,
      color: Colors.lightGreenAccent[200],
    ),
    // message:  "${updatedSupplement.name} has been created!",
    message:  message,
    duration:  Duration(seconds: 3),
  )..show(context);
}