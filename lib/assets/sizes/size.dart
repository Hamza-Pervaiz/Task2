import 'package:flutter/material.dart';

class ResponsiveSize {
  final BuildContext context;

  ResponsiveSize(this.context);

  Size get screenSize => MediaQuery.of(context).size;

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;
}
