import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// ignore: avoid_classes_with_only_static_members
class LocalStorage {
  static Future<void> set(String location, String data) async =>
      (await SharedPreferences.getInstance()).setString(location, data);

  static Future<Map<String, dynamic>> get(String location, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? result = prefs.getString(location);
    if (result == null || result.isEmpty) result = value;

    return jsonDecode(result) as Map<String, dynamic>;
  }
}
