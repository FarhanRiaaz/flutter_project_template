class RegisterUserResponse {
  final String? name;
  final String? email;

  RegisterUserResponse({
    this.name,
    this.email,
  });

  RegisterUserResponse copyWith({
    String? name,
    String? email,
  }) =>
      RegisterUserResponse(
        name: name ?? this.name,
        email: email ?? this.email,
      );
}
