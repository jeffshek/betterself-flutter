import 'package:flutter/material.dart';

EdgeInsets getDefaultPaddingInsets() {
  return EdgeInsets.only(left: 25, right: 25, top: 14);
}

Padding getDefaultPadding () {
  return Padding(
    padding: getDefaultPaddingInsets(),
  );
}