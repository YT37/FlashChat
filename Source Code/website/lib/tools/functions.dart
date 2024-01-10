import 'package:flutter/material.dart';

Widget logo(double size) => Hero(
      tag: "logo",
      child: Image.asset(
        "assets/images/Logo.png",
        height: size,
        width: size,
      ),
    );

Widget divider({
  double height = 5,
  double thickness = 0.5,
}) =>
    Divider(
      height: height,
      thickness: thickness,
    );
