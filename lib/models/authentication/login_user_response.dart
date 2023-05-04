class LoginUserResponse {
  final String? token;
  final User? user;

  LoginUserResponse({
    this.token,
    this.user,
  });

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

  User copyWith({
    String? name,
    String? email,
  }) =>
      User(
        name: name ?? this.name,
        email: email ?? this.email,
      );
}
