import 'dart:convert';

import './local_storage.dart';
import '/models/user.dart';

// ignore: avoid_classes_with_only_static_members
class UserManager {
  static Future<List<User>> get users async {
    final List<dynamic> _users = (await LocalStorage.get(
      "users",
      """{"users": []}""",
    ))["users"];

    return List.generate(
      _users.length,
      (index) => User.fromJson(_users[index]),
    );
  }

  static Future<bool> userExists(String id) async {
    final List<User> _users = await users;

    return _users.where((user) => user.id == id).isNotEmpty;
  }

  static Future<void> addUser({
    required String id,
    required String username,
  }) async {
    final List<User> _users = [];
    final Map<String, dynamic> data = {"users": []};

    if (_users.where((user) => user.id == id).isEmpty) {
      _users.add(
        User(
          id: id,
          username: username,
        ),
      );

      _users.forEach((user) => data["users"].add(user.toJson()));

      await LocalStorage.set(
        "users",
        jsonEncode(data),
      );
    }
  }

  static Future<void> updateUser({
    required String id,
    required String username,
  }) async {
    await deleteUser(id);

    await addUser(
      id: id,
      username: username,
    );
  }

  static Future<void> deleteUser(String id) async {
    final List<User> _users = await users;
    final Map<String, dynamic> data = {"users": []};

    _users.removeWhere((_user) => _user.id == id);
    _users.forEach((user) => data["users"].add(user.toJson()));

    await LocalStorage.set(
      "users",
      jsonEncode(data),
    );
  }

  static Future<User> getUser(String id) async {
    final List<User> _users = await users;

    return _users.where((user) => user.id == id).first;
  }

  static Future<void> clearUsers() =>
      LocalStorage.set("users", """{"users": []}""");
}
