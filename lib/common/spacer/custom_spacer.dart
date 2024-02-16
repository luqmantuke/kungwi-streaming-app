import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomSpacer extends StatelessWidget {
  double height;
  double width;
  CustomSpacer({super.key, this.height = 0.0, this.width = 0.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
