import 'package:betterself_flutter/models/Supplement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Supplement/SupplementDetailScreen.dart';
import 'SupplementLog/SupplementLogScreen.dart';

pushSupplementDetails(Supplement supplement, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SupplementDetailScreen(supplement: supplement),
    ),
  );
}

pushSupplementLogAddDetails(Supplement supplement, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SupplementLogAddScreen(supplement: supplement),
    ),
  );
}