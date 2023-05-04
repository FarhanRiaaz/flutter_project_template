class RegisterErrorResponse {
  final List<String>? email;

  RegisterErrorResponse({
    this.email,
  });


  factory RegisterErrorResponse.fromMap(Map<String, dynamic> json) =>
      RegisterErrorResponse(
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
    "email": email,
  };



  RegisterErrorResponse copyWith({
    List<String>? email,
  }) =>
      RegisterErrorResponse(
        email: email ?? this.email,
      );
}
