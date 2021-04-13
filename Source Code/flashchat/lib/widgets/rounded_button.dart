import 'package:flashchat/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final String text;
  final void Function() onTap;

  RoundedButton({
    required this.color,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: screenSize.symmetric(vertical: 16),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          onPressed: onTap,
          minWidth: screenSize.width(200),
          height: screenSize.height(42),
          child: Text(text, style: TextStyle(color: kUIColor)),
        ),
      ),
    );
  }
}
