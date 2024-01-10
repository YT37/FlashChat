import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/config/constants.dart';
import '/services/auth.dart';
import '/services/responsive.dart';
import '/tools/functions.dart';
import '/ui/widgets/rounded_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Animation<Color?>? animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )
      ..forward()
      ..addListener(() => setState(() {}));

    if (auth.currentUser != null) {
      Timer(
        const Duration(milliseconds: 150),
        () async => Auth.login(),
      );
    }
  }

  @override
  void didChangeDependencies() {
    animation ??= ColorTween(
      begin: context.theme.colorScheme.secondary.withOpacity(0.5),
      end: context.theme.colorScheme.primary,
    ).animate(controller);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: animation!.value,
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.isDesktop(context) ? 200 : 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Flexible(child: SizedBox(height: 100, child: logo(100))),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "Flash Chat",
                        textStyle: context.textTheme.displayLarge,
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    totalRepeatCount: 5,
                    stopPauseOnTap: true,
                    displayFullTextOnTap: true,
                  ),
                ],
              ),
              const SizedBox(height: 48),
              Hero(
                tag: "login",
                child: RoundedButton(
                  text: "Log In",
                  color: context.theme.colorScheme.secondary,
                  onTap: () => Get.toNamed("/login"),
                ),
              ),
              Hero(
                tag: "signup",
                child: RoundedButton(
                  text: "Sign Up",
                  color: context.theme.colorScheme.tertiary,
                  onTap: () => Get.toNamed("/signup"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
