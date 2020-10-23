import 'package:betterself_flutter/components/SafeAreaDefault.dart';
import 'package:betterself_flutter/models/Supplement.dart';
import 'package:flutter/material.dart';

class SupplementDetailScreen extends StatefulWidget {
  final Supplement supplement;

  SupplementDetailScreen({Key key, @required this.supplement})
      : super(key: key);

  @override
  _SupplementDetailScreenState createState() => _SupplementDetailScreenState();
}

class _SupplementDetailScreenState extends State<SupplementDetailScreen> {

  List<Widget> getViewData(Supplement supplement) {
    print (supplement);
    return [
      Text(supplement.name),
      Text(supplement.name),
      Text(supplement.name),
    ];
  }

  @override
  Widget build(BuildContext context) {
    print (widget.supplement.name);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            getSafeAreaDefaultWithBack(context),
            ...getViewData(widget.supplement),
          ],
        ),
      ),
    );
  }
}
