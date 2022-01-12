class User {
  final int id;
  final String name;
  final String username;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '');

  Map<String, dynamic> toJson() {
    var map = {'name': name, 'username': username, 'email': email};
    // if (map['id'] != null) map['id'] = this.id ?? '';
    return map;
  }
}
