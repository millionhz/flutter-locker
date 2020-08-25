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
  final List<int> prevValue;

  MySlider(
      {this.size,
      this.innerWidget,
      this.onChangedInt,
      this.onChangedDouble,
      this.initialValue})
      : this.prevValue = [initialValue.toInt()];

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      onChange: (val) {
//        context.read<Locker>().debugLog();
        onChangedDouble(val);

        int roundedVal = val.round();
        // use the initialValue at the start to avoid the glitched initial
        // slider sounds
        // using list as they are immutable
        if (roundedVal != prevValue[0]) {
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
