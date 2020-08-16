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
    Provider.of<Locker>(context, listen: false).generatePassCode();
    Provider.of<Locker>(context, listen: false).loadAudioAssets();
    Provider.of<Locker>(context, listen: false).setDoubles();
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

class MyBody extends StatelessWidget {
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
              initialValue: Provider.of<Locker>(context, listen: false).aDouble,
              onChangedInt: (val) {
                Provider.of<Locker>(context, listen: false).a = val;
                Provider.of<Locker>(context, listen: false).playASound();
              },
              onChangedDouble: (val) {
                Provider.of<Locker>(context, listen: false).aDouble = val;
              },
            ),
            MySlider(
              size: MediaQuery.of(context).size.width - 150,
              initialValue: Provider.of<Locker>(context, listen: false).bDouble,
              onChangedInt: (val) {
                Provider.of<Locker>(context, listen: false).b = val;
                Provider.of<Locker>(context, listen: false).playBSound();
              },
              onChangedDouble: (val) {
                Provider.of<Locker>(context, listen: false).bDouble = val;
              },
            ),
            MySlider(
              size: MediaQuery.of(context).size.width - 250,
              initialValue: Provider.of<Locker>(context, listen: false).cDouble,
              onChangedInt: (val) {
                Provider.of<Locker>(context, listen: false).c = val;
                Provider.of<Locker>(context, listen: false).playCSound();
              },
              onChangedDouble: (val) {
                Provider.of<Locker>(context, listen: false).cDouble = val;
              },
            ),
          ],
        ),
        MyRoundedButton(),
      ],
    );
  }
}
