import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

import './firebase_options.dart';
import '/config/constants.dart';
import '/config/theme.dart';
import '/ui/pages/export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (TESTING) {
    try {
      await auth.useAuthEmulator(IP, 9090);

      firestore.settings = const Settings(
        host: "$IP:9080",
        sslEnabled: false,
        persistenceEnabled: false,
      );
    } catch (_) {}
  }

  await analytics.setAnalyticsCollectionEnabled(!TESTING);

  setPathUrlStrategy();

  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "FlashChat",
      theme: FlashChatTheme.of(context),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/signup": (context) => const SignUpPage(),
        "/login": (context) => const LogInPage(),
        "/chat": (context) => const ChatPage(),
      },
    );
  }
}
