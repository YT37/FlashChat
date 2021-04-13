import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flashchat/constants.dart';
import 'package:flashchat/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )
      ..forward()
      ..addListener(() => setState(() {}));

    animation =
        ColorTween(begin: Colors.blueGrey, end: kUIColor).animate(controller);

    if (auth.currentUser != null)
      Timer(Duration(milliseconds: 150),
          () => Navigator.popAndPushNamed(context, "/chat"));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Builder(
        builder: (context) => SafeArea(
          child: Padding(
            padding: screenSize.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Hero(
                        tag: "logo",
                        child: Container(
                          child: Image.asset("images/logo.png"),
                          height: screenSize.height(60),
                        ),
                      ),
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          "Flash Chat",
                          textStyle: TextStyle(
                            fontSize: screenSize.height(45),
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          speed: Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 5,
                      stopPauseOnTap: true,
                      displayFullTextOnTap: true,
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height(48)),
                RoundedButton(
                  color: kUIAccent,
                  text: "Log In",
                  onTap: () => Navigator.pushNamed(context, "/login"),
                ),
                RoundedButton(
                  color: Colors.blueAccent,
                  text: "Register",
                  onTap: () => Navigator.pushNamed(context, "/registration"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
