import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'button.dart';
import 'slider.dart';
import 'top_cicle.dart';

class MyAppHome extends StatelessWidget {
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
  
  @override
  void initState() {
    super.initState();
    Provider.of<Locker>(context, listen: false).generatePassCode();
    Provider.of<Locker>(context, listen: false).loadAudioAssets();
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
              initialValue:
                  Provider.of<Locker>(context, listen: false).a.toDouble(),
              onChanged: (val) {
                Provider.of<Locker>(context, listen: false).a = val;
                Provider.of<Locker>(context, listen: false).playASound();
              },
            ),
            MySlider(
              size: MediaQuery.of(context).size.width - 150,
              initialValue:
                  Provider.of<Locker>(context, listen: false).b.toDouble(),
              onChanged: (val) {
                Provider.of<Locker>(context, listen: false).b = val;
                Provider.of<Locker>(context, listen: false).playBSound();
              },
            ),
            MySlider(
              size: MediaQuery.of(context).size.width - 250,
              initialValue:
                  Provider.of<Locker>(context, listen: false).c.toDouble(),
              onChanged: (val) {
                Provider.of<Locker>(context, listen: false).c = val;
                Provider.of<Locker>(context, listen: false).playCSound();
              },
            ),
          ],
        ),
        MyRoundedButton(),
      ],
    );
  }
}
