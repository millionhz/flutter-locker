import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'home.dart';
import 'dart:math';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void selectColor() {
    List<Color> chosenColorSet = colorList[Random().nextInt(colorList.length)];
    kLight = chosenColorSet[0];
    kDark = chosenColorSet[1];
    kDarkLow = chosenColorSet[2];
  }

  @override
  void initState() {
    super.initState();
    selectColor();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: "Locker",
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => Locker(),
        child: MyAppHome(),
      ),
    );
  }
}
