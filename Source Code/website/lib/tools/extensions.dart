import 'package:flutter/material.dart';

extension ToolsString on String {
  String capitalize() => substring(0, 1).toUpperCase() + substring(1);

  Color toColor() => Color("0xFF$this".toInt());

  num toNum() => num.parse(this);
  double toDouble() => double.parse(this);
  int toInt() => int.parse(this);
}

extension ToolsDateTime on DateTime {
  String get to12Hour =>
      "${hour > 12 ? hour - 12 : hour}:$minute ${hour > 12 ? "PM" : "AM"}";
}

extension ToolsColor on Color {
  String code() => toString().toLowerCase().split("f")[2].split(")")[0];
}
