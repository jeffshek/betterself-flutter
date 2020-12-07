import 'package:betterself_flutter/constants/theme_constants.dart';
import 'package:flutter/material.dart';


const defaultColorGradient = const <Color>[COLOR_PRIMARY, COLOR_PRIMARY_DARK];
// const defaultColorGradient = const <Color>[COLOR_PRIMARY, COLOR_PRIMARY];

class WideAppButton extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;

  WideAppButton({@required this.textContent, @required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return WideAppButtonState();
  }
}

class WideAppButtonState extends State<WideAppButton> {
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

class NarrowButton extends StatefulWidget {
  var textContent;
  VoidCallback onPressed;
  var gradientColors;

  NarrowButton({@required this.textContent, @required this.onPressed, this.gradientColors=defaultColorGradient});

  @override
  State<StatefulWidget> createState() {
    return NarrowButtonState();
  }
}

class NarrowButtonState extends State<NarrowButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: widget.onPressed,
      textColor: WHITE_COLOR,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: widget.gradientColors),
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            widget.textContent,
            style: TextStyle(fontSize: TEXT_SIZE_NORMAL),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
