class RegisterUserResponse {
  final String? name;
  final String? email;

  RegisterUserResponse({
    this.name,
    this.email,
  });

  factory RegisterUserResponse.fromMap(Map<String, dynamic> json) =>
      RegisterUserResponse(
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
      };

  RegisterUserResponse copyWith({
    String? name,
    String? email,
  }) =>
      RegisterUserResponse(
        name: name ?? this.name,
        email: email ?? this.email,
      );
}
