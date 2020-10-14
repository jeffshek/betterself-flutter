import 'package:betterself_flutter/constants/theme_constants.dart';
import 'package:flutter/material.dart';

Text headerText(var text) {
  return Text(
    text,
    maxLines: 2,
    style: TextStyle(
        fontFamily: FONT_BOLD,
        fontSize: TEXT_SIZE_LARGE,
        color: TEXT_COLOR_PRIMARY),
  );
}

Text subheaderText(var text) {
  return Text(
    text,
    style: TextStyle(
        fontFamily: FONT_BOLD,
        fontSize: TEXT_SIZE_MEDIUM,
        color: TEXT_COLOR_SECONDARY),
  );
}

Widget styledText(var text,
    {var fontSize = TEXT_SIZE_NORMAL,
      textColor = TEXT_COLOR_SECONDARY,
      var fontFamily = FONT_REGULAR,
      var isCentered = false,
      var maxLine = 1,
      var letterSpacing = 0.5}) {
  return Text(text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: maxLine,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textColor,
          height: 1.5,
          letterSpacing: letterSpacing));
}

class EditText extends StatefulWidget {
  var isPassword;
  var fontSize;
  var textColor;
  var fontFamily;
  var text;
  var maxLine;
  TextEditingController mController;
  VoidCallback onPressed;

  EditText(
      {var this.fontSize = TEXT_SIZE_NORMAL,
        var this.textColor = TEXT_COLOR_SECONDARY,
        var this.fontFamily = FONT_REGULAR,
        var this.isPassword = false,
        var this.text = "",
        var this.mController,
        var this.maxLine = 1});

  @override
  State<StatefulWidget> createState() {
    return EditTextState();
  }
}

class EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.mController,
        obscureText: widget.isPassword,
        cursorColor: COLOR_PRIMARY,
        style: TextStyle(
            fontSize: widget.fontSize,
            color: TEXT_COLOR_PRIMARY),
        decoration: new InputDecoration(
          suffixIcon: new GestureDetector(
            onTap: () {
              setState(() {
                widget.isPassword = !widget.isPassword;
              });
            },
            child: new Icon(
                widget.isPassword ? Icons.visibility : Icons.visibility_off),
          ),
        ));
  }
}

Widget titleWithCheckbox(String title, bool boolValue) {
  return Row(
    children: <Widget>[
      Text(title),
      Checkbox(
        activeColor: COLOR_PRIMARY,
        value: boolValue,
        onChanged: (bool value) {
          boolValue = value;
        },
      )
    ],
  );
}