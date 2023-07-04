class User {
  String? username;
  String? email;
  String? password;

  User({
    this.username,
    this.email,
    this.password,
  });

  User._privateConstructor();
  static final User _instance = User._privateConstructor();
  static User get instance => _instance;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'password': password,
      };
}
