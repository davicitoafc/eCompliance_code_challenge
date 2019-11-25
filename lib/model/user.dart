class User {
  String id;
  String createdAt;
  String name;
  String avatar;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = json['createdAt'],
        name = json['name'],
        avatar = json['avatar'];
}
