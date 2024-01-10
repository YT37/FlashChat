import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final void Function() onTap;

  const RoundedButton({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Material(
        color: color,
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          height: 50,
          minWidth: 200,
          onPressed: onTap,
          child: Text(text, style: context.textTheme.titleLarge),
        ),
      ),
    );
  }
}
