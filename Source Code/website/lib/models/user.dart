class User {
  final String id;
  final String username;

  User({
    required this.id,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> data) => User(
        id: data["id"],
        username: data["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
      };

  bool isEqual(User user) => user.id == id;
}
