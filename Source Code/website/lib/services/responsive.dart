import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    required this.desktop,
  });

  static int criteria = 730;

  static bool isMobile(BuildContext context) => context.width < criteria;
  static bool isDesktop(BuildContext context) => context.width > criteria;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (size.width > criteria) {
      return desktop;
    } else {
      return mobile;
    }
  }
}
