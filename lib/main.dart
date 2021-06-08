import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Locker(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<Locker>().loadAudioAssets();
    // load past data(passcode, color, and input_codes) from local storage
    context.read<Locker>().setDoubles();
    // set colors
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: "Locker",
      debugShowCheckedModeBanner: false,
      home: MyAppHome(),
    );
  }
}
