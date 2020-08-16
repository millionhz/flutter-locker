import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:provider/provider.dart';
import 'color_control.dart';
import 'model.dart';

class MySlider extends StatelessWidget {
  final double size;
  final Function(double) innerWidget;
  final Function(int) onChangedInt;
  final Function(double) onChangedDouble;
  final double initialValue;
  MySlider(
      {this.size,
      this.innerWidget,
      this.onChangedInt,
      this.onChangedDouble,
      this.initialValue});

  final List<int> prevValue = [null];

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      onChange: (val) {
        onChangedDouble(val);

        int roundedVal = val.round();
        // use the initialValue at the start to avoid the glitched initial
        // slider sounds
        // dart was not letting me initialize the prevValue with the initialValue
        // (it raises a not static method error) so I figured this trick out where I have
        // the prevValue as null and perform a null check and if its null I  use
        // initialValue. the null is overwritten when the if block runs
        if (roundedVal !=
            ((prevValue[0] != null) ? prevValue[0] : initialValue.toInt())) {
          onChangedInt(roundedVal);
          prevValue[0] = roundedVal;
        }
      },
      min: 0,
      max: context.watch<Locker>().maxSliderRange.toDouble(),
      initialValue: initialValue,
      appearance: CircularSliderAppearance(
          counterClockwise: true,
          size: size,
          animationEnabled: false,
          startAngle: 270,
          angleRange: 360,
          customWidths: CustomSliderWidths(progressBarWidth: 18),
          customColors: CustomSliderColors(
              dotColor: kLight,
              hideShadow: true,
              progressBarColor: kDark,
              trackColor: kDarkLow)),
      innerWidget: (innerWidget != null)
          ? innerWidget
          : (_) => Center(child: SizedBox()),
    );
  }
}
