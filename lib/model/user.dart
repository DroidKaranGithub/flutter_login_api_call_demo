/* class User {
  int status;
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
} */

class User {
  int status;
  String message;
  String id;
  String email;
  String name;

  User({this.status, this.message, this.id, this.email, this.name});

  User.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    id = json['id'];
    email = json['email'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    return data;
  }
}
