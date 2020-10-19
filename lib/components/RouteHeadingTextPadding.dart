import 'package:betterself_flutter/components/TextComponents.dart';
import 'package:flutter/material.dart';

Padding getRouteBetterSelfHeaderTextPadding(String subheaderTextSting) {
  return Padding(
    padding: const EdgeInsets.only(left: 25, right: 25, top: 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        headerText("BetterSelf"),
        SizedBox(width: 4),
        Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: subheaderText(subheaderTextSting),
        )
      ],
    ),
  );
}


Padding getRouteHeaderTextPadding(String subheaderTextSting) {
  return Padding(
    padding: const EdgeInsets.only(left: 25, right: 25, top: 14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 4),
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: subheaderText(subheaderTextSting),
        )
      ],
    ),
  );
}

