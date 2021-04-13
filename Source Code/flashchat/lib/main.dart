import 'package:flashchat/constants.dart';
import 'package:flashchat/screens/chat.dart';
import 'package:flashchat/screens/login.dart';
import 'package:flashchat/screens/registration.dart';
import 'package:flashchat/screens/welcome.dart';
import 'package:flashchat/services/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlashChat',
      builder: (BuildContext context, Widget? child) {
        screenSize = ScreenSize(context: context);

        return child!;
      },
      initialRoute: "/",
      routes: {
        "/": (context) => WelcomeScreen(),
        "/chat": (context) => ChatScreen(),
        "/login": (context) => LoginScreen(),
        "/registration": (context) => RegistrationScreen(),
      },
    );
  }
}
