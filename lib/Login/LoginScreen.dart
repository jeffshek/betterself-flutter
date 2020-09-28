import 'package:flutter/material.dart';
import 'package:betterself_flutter/constants/theme_constants.dart';

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

class LoginScreen extends StatefulWidget {
  final title = "Login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;
  bool rememberLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            /*back icon*/
            SafeArea(
              child: Container(
                padding: EdgeInsets.only(left: 8),
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            /*heading*/
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  headerText("BetterSelf"),
                  SizedBox(width: 4),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: subheaderText("Login"))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  styledText("Email", fontSize: TEXT_SIZE_MEDIUM),
                  EditText(),
                  SizedBox(height: 25),
                  styledText("Password", fontSize: TEXT_SIZE_MEDIUM),
                  EditText(isPassword: true),
                  SizedBox(height: 18),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        focusColor: COLOR_PRIMARY,
                        activeColor: COLOR_PRIMARY,
                        value: rememberLogin,
                        onChanged: (bool value) {
                          setState(() {
                            rememberLogin = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  AppButton(
                    textContent: "Login",
                    onPressed: () {},
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
