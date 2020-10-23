import 'package:flutter/material.dart';

const safeAreaHeight = 50.0;
const paddingLeft = 8.0;

SafeArea getSafeAreaDefault(context) {
  return SafeArea(
    child: Container(
      padding: EdgeInsets.only(left: paddingLeft),
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      height: safeAreaHeight,
    ),
  );
}

SafeArea getSafeAreaDefaultWithBack(context) {
  return SafeArea(
    child: Container(
      padding: EdgeInsets.only(left: paddingLeft),
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      height: safeAreaHeight,
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ),
  );
}

