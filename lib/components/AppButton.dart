import 'package:flutter/material.dart';
import 'package:betterself_flutter/constants/theme_constants.dart';

class AppButton extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;
  AppButton({@required this.textContent, @required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return AppButtonState();
  }
}

class AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: widget.onPressed,
        textColor: WHITE_COLOR,
        elevation: 4,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: const EdgeInsets.all(0.0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[COLOR_PRIMARY, COLOR_PRIMARY_DARK]),
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.textContent,
                style: TextStyle(fontSize: TEXT_SIZE_NORMAL),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}