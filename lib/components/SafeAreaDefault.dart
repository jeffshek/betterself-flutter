import 'package:flutter/material.dart';

SafeArea getSafeAreaDefault(context) {
  return SafeArea(
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
  );
}
