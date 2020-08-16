import 'dart:math';
import 'package:flutter/material.dart';
import 'color_control.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'button.dart';
import 'slider_template.dart';
import 'top_circle.dart';

class MyAppHome extends StatefulWidget {
  @override
  _MyAppHomeState createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  // selectColor can be moved to model but im going to leave it here for now
  void selectColor() {
    // to prevent color scheme repetition
    while (newIndex == indexInUse) {
      newIndex = Random().nextInt(kColorList.length);
    }
    indexInUse = newIndex;
    List<Color> chosenColorSet = kColorList[indexInUse];
    kLight = chosenColorSet[0];
    kDark = chosenColorSet[1];
    kDarkLow = chosenColorSet[2];
  }

  @override
  void initState() {
    super.initState();
    context.read<Locker>().generatePassCode();
    context.read<Locker>().loadAudioAssets();
    context.read<Locker>().setDoubles();
    context.read<Locker>().debugLog();
    selectColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLight,
      body: MyBody(),
    );
  }
}

class MyBody extends StatefulWidget {
  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  double aInitialDouble = 0;
  double bInitialDouble = 0;
  double cInitialDouble = 0;

  @override
  void initState() {
    super.initState();
    aInitialDouble = context.read<Locker>().aDouble;
    bInitialDouble = context.read<Locker>().bDouble;
    cInitialDouble = context.read<Locker>().cDouble;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MyCircle(
              child: Consumer<Locker>(
                builder: (context, value, child) => MyText(value.a.toString()),
              ),
            ),
            MyCircle(
              child: Consumer<Locker>(
                builder: (context, value, child) => MyText(value.b.toString()),
              ),
            ),
            MyCircle(
              child: Consumer<Locker>(
                builder: (context, value, child) => MyText(value.c.toString()),
              ),
            )
          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            MySlider(
              size: MediaQuery.of(context).size.width - 50,
              initialValue: aInitialDouble,
              onChangedInt: (val) {
                context.read<Locker>().a = val;
                context.read<Locker>().playASound();
              },
              onChangedDouble: (val) {
                context.read<Locker>().aDouble = val;
              },
            ),
            MySlider(
              size: MediaQuery.of(context).size.width - 150,
              initialValue: bInitialDouble,
              onChangedInt: (val) {
                context.read<Locker>().b = val;
                context.read<Locker>().playBSound();
              },
              onChangedDouble: (val) {
                context.read<Locker>().bDouble = val;
              },
            ),
            MySlider(
              size: MediaQuery.of(context).size.width - 250,
              initialValue: cInitialDouble,
              onChangedInt: (val) {
                context.read<Locker>().c = val;
                context.read<Locker>().playCSound();
              },
              onChangedDouble: (val) {
                context.read<Locker>().cDouble = val;
              },
            ),
          ],
        ),
        MyRoundedButton(),
      ],
    );
  }
}
