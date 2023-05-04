class LoginUserResponse {
  final String? token;
  final User? user;

  LoginUserResponse({
    this.token,
    this.user,
  });



  factory LoginUserResponse.fromMap(Map<String, dynamic> json) =>
      LoginUserResponse(
        token: json["token"],
        user: json["user"],
      );

  Map<String, dynamic> toMap() => {
    "token": token,
    "user": user,
  };



  LoginUserResponse copyWith({
    String? token,
    User? user,
  }) =>
      LoginUserResponse(
        token: token ?? this.token,
        user: user ?? this.user,
      );
}

class User {
  final String? name;
  final String? email;

  User({
    this.name,
    this.email,
  });


  factory User.fromMap(Map<String, dynamic> json) =>
      User(
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
    "name": name,
    "email": email,
  };

  User copyWith({
    String? name,
    String? email,
  }) =>
      User(
        name: name ?? this.name,
        email: email ?? this.email,
      );
}
