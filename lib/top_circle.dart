import 'package:flutter/material.dart';
import 'color_control.dart';

class MyCircle extends StatelessWidget {
  final Widget child;
  final double size;

  MyCircle({this.child, this.size: 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.fromBorderSide(BorderSide(color: kDark, width: 5))),
      child: child,
    );
  }
}

class MyText extends StatelessWidget {
  final String textValue;

  MyText(this.textValue);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        textValue,
        style: TextStyle(
          color: kDark,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          fontFamily: 'Quicksand',
        ),
      ),
    );
  }
}
