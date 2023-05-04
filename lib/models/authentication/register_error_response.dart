class RegisterErrorResponse {
  final List<String>? email;

  RegisterErrorResponse({
    this.email,
  });

  RegisterErrorResponse copyWith({
    List<String>? email,
  }) =>
      RegisterErrorResponse(
        email: email ?? this.email,
      );
}
