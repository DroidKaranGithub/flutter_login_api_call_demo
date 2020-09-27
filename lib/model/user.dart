class User {
  String status;
  String message;
  String id;
  String email;
  String name;

  User({
    this.status,
    this.id,
    this.email,
    this.message,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    Map json = parsedJson['user'];
    return User(
      status: json['status'],
      id: json['id'],
      email: json['email'],
      message: json['message'],
      name: json['name'],
    );
  }
}
